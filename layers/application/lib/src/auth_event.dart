part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class _Init extends AuthEvent {
  const _Init();

  @override
  List<Object?> get props => [];
}

class _SignIn extends AuthEvent {
  const _SignIn({required this.needsOnboarding});

  final bool needsOnboarding;

  @override
  List<Object?> get props => [needsOnboarding];
}

class _SignOut extends AuthEvent {
  const _SignOut();

  @override
  List<Object?> get props => [];
}

extension AuthBlocX on AuthBloc {
  void signIn({required bool needsOnboarding}) {
    add(_SignIn(needsOnboarding: needsOnboarding));
  }

  void signOut() {
    add(const _SignOut());
  }
}
