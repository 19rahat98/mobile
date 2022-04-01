part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class _Init extends ProfileEvent {
  const _Init();

  @override
  List<Object> get props => [];
}

class _UpdateName extends ProfileEvent {
  const _UpdateName(this.firstName, this.lastName);

  final String firstName;
  final String lastName;

  @override
  List<Object> get props => [firstName, lastName];
}

class _Login extends ProfileEvent {
  const _Login(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class _Create extends ProfileEvent {
  const _Create(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class _Logout extends ProfileEvent {
  const _Logout();

  @override
  List<Object> get props => [];
}

class _UpdateEmail extends ProfileEvent {
  const _UpdateEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

extension ProfileBlocX on ProfileBloc {
  void createProfile(String email, String password) {
    add(_Create(email, password));
  }

  void login(String email, String password) => add(
        _Login(email, password),
      );

  void logout() => add(const _Logout());

  void updateEmail(String email) => add(_UpdateEmail(email));

  void updateName(String firstName, String lastName) =>
      add(_UpdateName(firstName, lastName));
}
