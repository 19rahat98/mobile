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
  const _SignIn();

  @override
  List<Object?> get props => [];
}

class _SignOut extends AuthEvent {
  const _SignOut();

  @override
  List<Object?> get props => [];
}

extension AuthBlocX on AuthBloc {
  void signIn() {
    add(const _SignIn());
  }

  void signOut() {
    add(const _SignOut());
  }
}
