enum AuthStatus {
  authenticated,
  notAuthenticated,

  /// user failed to authenticate or verify code
  lockedOut,

  /// user just signed up, needs to complete onboarding
  needsOnboarding,

  /// user has completed onboarding, but needs to set a pin
  /// or the pin needs to be reset
  pinNeeded,
}

extension AuthStatusX on AuthStatus {
  bool get isAuthenticated {
    if (this == AuthStatus.authenticated) return true;
    if (isLocked) return true;
    if (isNeedsOnboarding) return true;
    if (isPinNeeded) return true;

    return false;
  }

  bool get isLocked => this == AuthStatus.lockedOut;
  bool get isNotAuthenticated => this == AuthStatus.notAuthenticated;
  bool get isNeedsOnboarding => this == AuthStatus.needsOnboarding;
  bool get isPinNeeded => this == AuthStatus.pinNeeded;
}

final _authStatusEnumMap = <String, AuthStatus>{
  AuthStatus.authenticated.name: AuthStatus.authenticated,
  AuthStatus.notAuthenticated.name: AuthStatus.notAuthenticated,
  AuthStatus.lockedOut.name: AuthStatus.lockedOut,
  AuthStatus.needsOnboarding.name: AuthStatus.needsOnboarding,
  AuthStatus.pinNeeded.name: AuthStatus.pinNeeded,
};

extension AuthStatusListX on Iterable<AuthStatus> {
  AuthStatus fromString(String value) {
    return _authStatusEnumMap[value] ?? AuthStatus.notAuthenticated;
  }
}
