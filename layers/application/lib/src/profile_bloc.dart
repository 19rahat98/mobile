import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
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
  })  : _profileRepo = profileRepo,
        _profileCache = profileCache,
        super(const _Loading()) {
    on<_Init>(_init);
    on<_UpdateName>(_updateName);
    on<_Login>(_login);
    on<_Logout>(_logout);
    on<_UpdateEmail>(_updateEmail);

    _profileId = null;
  }

  final IProfileRemote _profileRepo;
  final IProfileCache _profileCache;

  late String? _profileId;

  @override
  Future<void> onChange(Change<ProfileState> change) async {
    super.onChange(change);

    if (change.nextState.isReady) {
      final ready = change.nextState.asReady;

      if (ready.profile != null) {
        await _profileCache.save(ready.profile!);
      }
    }
  }

  Future<void> _init(_Init init, _Emitter emit) async {
    await hydrate(emit);

    if (!state.isReady || state.asReady.profile == null) {
      emit(const _Ready(null));
      return;
    }

    final profile = state.asReady.profile!;

    final remoteResult = await _profileRepo.profile(profile.id);

    if (remoteResult.isError) {
      emit(const _Error('Failed to load profile'));
      return;
    }

    final result = remoteResult.value;

    await emitProfile(emit, result);
  }

  Future<void> emitProfile(_Emitter emit, PreProfile? profile) async {
    if (profile == null) {
      return emit(const _Ready(null));
    }

    if (profile.isDetailed) {
      emit(_Ready(profile.asDetailed()));
    } else {
      emit(_OnBoardingNeeded(profile));
    }
  }

  bool _canUpdateProfile(_Emitter emit) {
    if (!state.isReady || state.asReady.profile == null) {
      emit(const _Error('Profile not loaded'));
      return false;
    }

    final profile = state.asReady.profile!;

    if (!profile.isDetailed) {
      emit(_OnBoardingNeeded(profile));
      return false;
    }

    return true;
  }

  Future<void> _updateName(
    _UpdateName event,
    _Emitter emit,
  ) async {
    if (!_canUpdateProfile(emit)) {
      return;
    }

    final profile = state.asReady.profile!;

    final updatedProfile = profile.asDetailed().copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
        );

    await _updateProfile(updatedProfile, emit);
  }

  Future<void> _login(
    _Login event,
    _Emitter emit,
  ) async {
    final loginResult = await _profileRepo.login(event.email);

    if (loginResult.isError) {
      emit(const _Error('Failed to login'));
      return;
    }

    final result = loginResult.value;

    emit(_Ready(result));
  }

  Future<void> _logout(
    _Logout event,
    _Emitter emit,
  ) async {
    await _profileCache.clear();
    final logoutResult = await _profileRepo.logout();

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

    final profile = state.asReady.profile!;

    final updatedProfile = profile.asDetailed().copyWith(email: event.email);

    await _updateProfile(updatedProfile, emit);
  }

  Future<void> _updateProfile(Profile profile, _Emitter emit) async {
    final updateResult = await _profileRepo.update(profile);

    if (updateResult.isError) {
      emit(const _Error('Failed to update profile'));
      return;
    }

    final result = updateResult.value;

    emit(_Ready(result));
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
    if (state.isReady) {
      return state.asReady.toJson();
    }

    return null;
  }
}
