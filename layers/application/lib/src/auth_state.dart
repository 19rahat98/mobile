part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @visibleForTesting
  const factory AuthState.authenticated() = _Authenticated;

  @visibleForTesting
  const factory AuthState.notAuthenticated() = _NotAuthenticated;

  bool get isAuthenticated => this is _Authenticated;
}

class _Authenticated extends AuthState {
  const _Authenticated();

  @override
  List<Object> get props => [];
}

class _NotAuthenticated extends AuthState {
  const _NotAuthenticated();

  @override
  List<Object> get props => [];
}
