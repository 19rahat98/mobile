import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emitter = Emitter<AuthState>;

class AuthBloc extends CacheBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _NotAuthenticated()) {
    on<_Init>(_init);
    on<_SignIn>((_, emit) => _authorize(emit));
    on<_SignOut>((_, emit) => _removeAuth(emit));

    add(const _Init());
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  Future<void> _init(_Init event, _Emitter emit) async {
    final cachedState = await retrieve();

    if (cachedState == null) {
      await _removeAuth(emit);
      return;
    }

    if (cachedState.isAuthenticated) {
      await _authorize(emit);
    }
  }

  Future<void> _removeAuth(_Emitter emit) async {
    emit(const _NotAuthenticated());
  }

  Future<void> _authorize(_Emitter emit) async {
    emit(const _Authenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic>? json) {
    final isSignedIn = json?['value'] as bool?;

    if (isSignedIn ?? false) {
      return const _Authenticated();
    } else {
      return const _NotAuthenticated();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return <String, dynamic>{'value': state.isAuthenticated};
  }
}
