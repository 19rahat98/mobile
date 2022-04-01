import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

typedef _Emitter = Emitter<AuthStatus>;

class AuthBloc extends CacheBloc<AuthEvent, AuthStatus> {
  AuthBloc({
    required IAuthCache cache,
  })  : _authCache = cache,
        super(AuthStatus.notAuthenticated) {
    on<_Init>(_init);
    on<_Authenticate>(_authenticate);
    on<_RemoveAuthentication>(_removeAuthentication);
    on<_Lock>(_lock);
    on<_Unlock>(_unlock);

    add(const _Init());
  }

  final IAuthCache _authCache;

  /// to ensure that the authentication state is
  /// accurate, we don't update the cache until
  /// after the _Init event has been processed.
  bool _allowCacheUpdate = false;

  @override
  Future<void> persist(AuthStatus state) async {
    if (!_allowCacheUpdate) return;

    await _authCache.save(state);
  }

  Future<void> _init(_Init event, _Emitter emit) async {
    final result = await _authCache.load();
    if (result.isSuccess) {
      emit(result.value);
    }
    _allowCacheUpdate = true;
  }

  Future<void> _authenticate(_Authenticate event, _Emitter emit) async {
    if (event.needsOnboarding) {
      emit(AuthStatus.needsOnboarding);
    } else {
      emit(AuthStatus.authenticated);
    }
  }

  Future<void> _removeAuthentication(
    _RemoveAuthentication event,
    _Emitter emit,
  ) async {
    emit(AuthStatus.notAuthenticated);
  }

  FutureOr<void> _lock(_Lock event, _Emitter emit) {
    emit(AuthStatus.lockedOut);
  }

  FutureOr<void> _unlock(_Unlock event, _Emitter emit) {
    emit(AuthStatus.authenticated);
  }

  @override
  AuthStatus? fromJson(Map<String, dynamic>? json) {
    final jsonState = json?['auth'] as String?;
    if (jsonState != null) {
      return AuthStatus.values.fromString(jsonState);
    }

    return AuthStatus.notAuthenticated;
  }

  @override
  Map<String, dynamic>? toJson(AuthStatus state) {
    return <String, dynamic>{'auth': state.name};
  }
}
