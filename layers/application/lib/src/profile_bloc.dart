import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as con;
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_bloc.g.dart';
part 'profile_event.dart';
part 'profile_state.dart';

typedef _Emitter = Emitter<ProfileState>;

class ProfileBloc extends CacheBloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required IProfileRemote profileRepo,
    required IProfileCache profileCache,
  })  : _profileRemote = profileRepo,
        _profileCache = profileCache,
        super(const _Loading()) {
    on<_Init>(_init);
    on<_CreateAccount>(_createAccount, transformer: con.droppable());
    on<_CreatePin>(_createPin, transformer: con.droppable());
    on<_ForgotPassword>(_forgotPassword, transformer: con.droppable());
    on<_Login>(_login, transformer: con.droppable());
    on<_Logout>(_logout, transformer: con.droppable());
    on<_UpdateProfile>(_updateProfile, transformer: con.restartable());
    on<_UpdateEmail>(_updateEmail, transformer: con.droppable());

    add(const _Init());
  }

  final IProfileRemote _profileRemote;
  final IProfileCache _profileCache;

  // fix: doesn't persist when updating name
  // expected: should go to welcome screen when profile is null

  @override
  Future<void> persist(ProfileState state) async {
    await _profileCache.save(state.profile);
  }

  Future<void> _init(_Init init, _Emitter emit) async {
    final cacheResult = await _profileCache.profile();

    if (cacheResult.isSuccess) {
      await _checkForPreProfileAndEmit(emit, cacheResult.value);
    }

    final profile = state.profile;

    if (profile == null) {
      emit(const _Ready(null));
      return;
    }

    final remoteResult = await _profileRemote.profile(profile.id);

    if (remoteResult.isError) {
      emit(const _Error('Failed to load profile'));
      return;
    }

    await _checkForPreProfileAndEmit(
      emit,
      remoteResult.value
          // setting default value for testing
          // TODO(mrgnhnt96): remove this
          ??
          profile,
    );
  }

  /// checks if [profile] is a pre-profile,
  ///
  /// if it is, the [_OnBoardingNeeded] state is emitted
  Future<void> _checkForPreProfileAndEmit(
    _Emitter emit,
    PreProfile? profile,
  ) async {
    if (profile == null) {
      return emit(const _Ready(null));
    }

    // "profile.isDetailed" means that the user has gone through onboarding
    if (profile.isDetailed) {
      // always double check to make sure that we have a valid pin
      final hasPinResult = await _profileCache.hasPin(profile.id);

      if (hasPinResult.isError || !hasPinResult.value) {
        emit(_PinNeeded(profile.asDetailed()));
      } else {
        emit(_Ready(profile.asDetailed()));
      }
    } else {
      emit(_OnBoardingNeeded(profile));
    }
  }

  /// checks the `state.profile` for a null value
  /// and emits [_Error] if it is null
  ///
  /// emits [_OnBoardingNeeded] if the profile is not complete
  bool _canUpdateProfile(_Emitter emit) {
    if (state.profile == null) {
      emit(const _Error('Profile not loaded'));
      return false;
    }

    final profile = state.profile!;

    if (!profile.isDetailed) {
      emit(_OnBoardingNeeded(profile));
      return false;
    }

    return true;
  }

  Future<void> _updateProfile(
    _UpdateProfile event,
    _Emitter emit,
  ) async {
    await _updateAndEmitProfile(event.profile, emit);
  }

  Future<void> _login(
    _Login event,
    _Emitter emit,
  ) async {
    final loginResult = await _profileRemote.login(event.email, event.password);

    if (loginResult.isError) {
      emit(const _Error('Failed to login'));
      return;
    }

    final result = loginResult.value;

    await _checkForPreProfileAndEmit(emit, result);
  }

  Future<void> _logout(
    _Logout event,
    _Emitter emit,
  ) async {
    await _profileCache.clear();
    final logoutResult = await _profileRemote.logout();

    if (logoutResult.isError) {
      emit(const _Error('Failed to logout'));
      return;
    }

    emit(const _Ready(null));
  }

  Future<void> _updateEmail(
    _UpdateEmail event,
    _Emitter emit,
  ) async {
    if (!_canUpdateProfile(emit)) {
      return;
    }

    final profile = state.profile!;

    final updatedProfile = profile.asDetailed().copyWith(email: event.email);

    await _updateAndEmitProfile(updatedProfile, emit);
  }

  /// Updates the profile and emits the result.
  ///
  /// Should only be called AFTER onboarding has been completed
  Future<void> _updateAndEmitProfile(Profile profile, _Emitter emit) async {
    final updateResult = await _profileRemote.update(profile);

    if (updateResult.isError) {
      emit(const _Error('Failed to update profile'));
      return;
    }

    final result = updateResult.value;

    emit(_Ready(result));
  }

  FutureOr<void> _createAccount(_CreateAccount event, _Emitter emit) async {
    final createResult =
        await _profileRemote.create(event.email, event.password);

    if (createResult.isError) {
      emit(const _Error('Failed to create profile'));
      return;
    }

    await _checkForPreProfileAndEmit(emit, createResult.value);
  }

  FutureOr<void> _createPin(_CreatePin event, _Emitter emit) async {
    final profile = state.profile;

    if (profile == null) {
      // can't create a pin if we don't have a profile
      return;
    }

    final createResult = await _profileCache.createPin(profile.id, event.pin);

    if (createResult.isError) {
      emit(const _Error('Failed to create pin'));
      return;
    }

    emit(_Ready(profile.asDetailed()));
  }

  FutureOr<void> _forgotPassword(_ForgotPassword event, _Emitter emit) async {
    final forgotResult = await _profileRemote.forgotPassword(event.email);

    if (forgotResult.isError) {
      emit(const _Error('Failed to send forgot password email'));
      return;
    }

    emit(const _Ready(null));
  }

  @override
  ProfileState? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return _Ready.fromJson(json);
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    return state.profile?.toJson();
  }
}
