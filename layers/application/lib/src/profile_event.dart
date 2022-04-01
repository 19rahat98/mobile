part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class _Init extends ProfileEvent {
  const _Init();

  @override
  List<Object> get props => [];
}

class _UpdateProfile extends ProfileEvent {
  const _UpdateProfile(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];
}

class _Login extends ProfileEvent {
  const _Login(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class _ForgotPassword extends ProfileEvent {
  const _ForgotPassword(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class _CreateAccount extends ProfileEvent {
  const _CreateAccount(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class _CreatePin extends ProfileEvent {
  const _CreatePin(this.pin);

  final String pin;

  @override
  List<Object> get props => [pin];
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
  void createAccount(String email, String password) {
    add(_CreateAccount(email, password));
  }

  void createPin(String pin) {
    add(_CreatePin(pin));
  }

  void login(String email, String password) {
    add(_Login(email, password));
  }

  void forgotPassword(String email) {
    add(_ForgotPassword(email));
  }

  void logout() {
    add(const _Logout());
  }

  void updateEmail(String email) {
    add(_UpdateEmail(email));
  }

  void updateProfile(Profile profile) {
    add(_UpdateProfile(profile));
  }
}
