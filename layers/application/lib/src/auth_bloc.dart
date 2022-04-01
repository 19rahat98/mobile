import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emitter = Emitter<AuthState>;

class AuthBloc extends CacheBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _Loading()) {
    on<_Init>(_init);
    on<_SignIn>(_signIn);
    on<_SignOut>(_signOut);
    on<_Lock>(_lock);
    on<_Unlock>(_unlock);

    add(const _Init());
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  Future<void> _init(_Init event, _Emitter emit) async {
    await hydrate(emit);
  }

  Future<void> _signIn(_SignIn event, _Emitter emit) async {
    if (event.needsOnboarding) {
      emit(const _NeedsOnboarding());
    } else {
      emit(const _Authenticated());
    }
  }

  Future<void> _signOut(_SignOut event, _Emitter emit) async {
    emit(const _NotAuthenticated());
  }

  FutureOr<void> _lock(_Lock event, Emitter<AuthState> emit) {
    emit(const _Locked());
  }

  FutureOr<void> _unlock(_Unlock event, Emitter<AuthState> emit) {
    emit(const _Authenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return _Authenticated.fromJson(json);
    }

    return const _NotAuthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state.isAuthenticated) {
      return state.asAuthenticated.toJson();
    }

    return null;
  }
}
