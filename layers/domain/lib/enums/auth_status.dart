enum AuthStatus {
  authenticated,
  notAuthenticated,
  lockedOut,
  needsOnboarding,
}

extension AuthStatusX on AuthStatus {
  bool get isAuthenticated {
    if (this == AuthStatus.authenticated) return true;
    if (isLocked) return true;
    if (isNeedsOnboarding) return true;

    return false;
  }

  bool get isLocked => this == AuthStatus.lockedOut;
  bool get isNotAuthenticated => this == AuthStatus.notAuthenticated;
  bool get isNeedsOnboarding => this == AuthStatus.needsOnboarding;
}

final _authStatusEnumMap = <String, AuthStatus>{
  AuthStatus.authenticated.name: AuthStatus.authenticated,
  AuthStatus.notAuthenticated.name: AuthStatus.notAuthenticated,
  AuthStatus.lockedOut.name: AuthStatus.lockedOut,
  AuthStatus.needsOnboarding.name: AuthStatus.needsOnboarding,
};

extension AuthStatusListX on Iterable<AuthStatus> {
  AuthStatus fromString(String value) {
    return _authStatusEnumMap[value] ?? AuthStatus.notAuthenticated;
  }
}
