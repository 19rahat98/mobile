import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_bloc.g.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emitter = Emitter<AuthState>;

class AuthBloc extends CacheBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _Loading()) {
    on<_Init>(_init);
    on<_SignIn>(_signIn);
    on<_SignOut>(_signOut);

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
    emit(_Authenticated(needsOnboarding: event.needsOnboarding));
  }

  Future<void> _signOut(_SignOut event, _Emitter emit) async {
    emit(const _NotAuthenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const _NotAuthenticated();
    }

    return _Authenticated.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state.isLoading) {
      return null;
    }

    return state.asAuthenticated.toJson();
  }
}
