part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @visibleForTesting
  const factory AuthState.authenticated() = _Authenticated;

  @visibleForTesting
  const factory AuthState.notAuthenticated() = _NotAuthenticated;

  bool get isAuthenticated => this is _Authenticated;
  bool get isLoading => this is _Loading;

  _Authenticated get asAuthenticated => this as _Authenticated;
}

class _Authenticated extends AuthState {
  const _Authenticated();

  static _Authenticated? fromJson(Map<String, dynamic> json) {
    final stateString = json['authState'] as String?;

    if (stateString == '$_Authenticated') {
      return const _Authenticated();
    } else if (stateString == '$_NeedsOnboarding') {
      return const _NeedsOnboarding();
    } else if (stateString == '$_Locked') {
      // on hydration, lock is not needed
      return const _Authenticated();
    }

    return null;
  }

  bool get needsOnboarding => this is _NeedsOnboarding;
  bool get isLocked => this is _Locked;

  Map<String, dynamic> toJson() =>
      // ignore: no_runtimetype_tostring
      <String, dynamic>{'authState': '$runtimeType'};

  @override
  List<Object> get props => [];
}

class _NeedsOnboarding extends _Authenticated {
  const _NeedsOnboarding();
}

class _Locked extends _Authenticated {
  const _Locked();
}

class _Loading extends AuthState {
  const _Loading();

  @override
  List<Object> get props => [];
}

class _NotAuthenticated extends AuthState {
  const _NotAuthenticated();

  @override
  List<Object> get props => [];
}
