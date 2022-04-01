part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class _Init extends AuthEvent {
  const _Init();

  @override
  List<Object?> get props => [];
}

class _Authenticate extends AuthEvent {
  const _Authenticate({required this.needsOnboarding});

  final bool needsOnboarding;

  @override
  List<Object?> get props => [needsOnboarding];
}

class _Lock extends AuthEvent {
  const _Lock();

  @override
  List<Object?> get props => [];
}

class _Unlock extends AuthEvent {
  const _Unlock();

  @override
  List<Object?> get props => [];
}

class _RemoveAuthentication extends AuthEvent {
  const _RemoveAuthentication();

  @override
  List<Object?> get props => [];
}

extension AuthBlocX on AuthBloc {
  void authenticate({required bool needsOnboarding}) {
    add(_Authenticate(needsOnboarding: needsOnboarding));
  }

  void removeAuthentication() {
    add(const _RemoveAuthentication());
  }

  void lock() {
    add(const _Lock());
  }

  void unlock() {
    add(const _Unlock());
  }
}
