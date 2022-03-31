import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

typedef _Emitter = Emitter<ProfileState>;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
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

  Future<void> _init(_Init init, _Emitter emit) async {
    late Profile profile;

    final cachedResult = await _profileCache.profile();
    if (cachedResult.isSuccess && cachedResult.value != null) {
      profile = cachedResult.value!;
      emit(_Ready(profile));
    }

    if (cachedResult.isError || cachedResult.value == null) {
      emit(const _Ready(null));
      return;
    }

    final remoteResult = await _profileRepo.profile(profile.id);

    if (remoteResult.isError) {
      emit(const _Error('Failed to load profile'));
      return;
    }

    final result = remoteResult.value;

    if (result == null) {
      emit(const _Ready(null));
      return;
    }

    await _profileCache.save(result);
    emit(_Ready(result));
  }

  FutureOr<Profile?> _getProfile(_Emitter emit, [String? id]) async {
    if (state is _Ready) {
      return (state as _Ready).profile;
    }

    final cachedResult = await _profileCache.profile();

    if (cachedResult.isSuccess && cachedResult.value != null) {
      return cachedResult.value;
    }

    if (id == null) {
      return null;
    }

    _profileId = id;

    final remoteResult = await _profileRepo.profile(_profileId!);

    if (remoteResult.isError) {
      emit(const _Error('Error fetching profile'));
      return null;
    }

    if (remoteResult.value != null) {
      emit(_Ready(remoteResult.value));
      await _profileCache.save(remoteResult.value!);
    } else {
      emit(const _Ready(null));
    }

    return null;
  }

  Future<void> _updateName(
    _UpdateName event,
    _Emitter emit,
  ) async {
    final profile = await _getProfile(emit);

    if (profile == null) {
      return;
    }

    await _updateProfile(
      profile.copyWith(
        firstName: event.firstName,
        lastName: event.lastName,
      ),
      emit,
    );
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

    await _profileCache.save(result);
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
    final profile = await _getProfile(emit);

    if (profile == null) {
      return;
    }

    await _updateProfile(profile.copyWith(email: event.email), emit);
  }

  Future<void> _updateProfile(Profile profile, _Emitter emit) async {
    final updateResult = await _profileRepo.update(profile);

    if (updateResult.isError) {
      emit(const _Error('Failed to update profile'));
      return;
    }

    final result = updateResult.value;

    await _profileCache.save(result);

    emit(_Ready(result));
  }
}
