part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class _Loading extends ProfileState {
  const _Loading();

  @override
  List<Object> get props => [];
}

class _Error extends ProfileState {
  const _Error(this.reason);

  final String reason;

  @override
  List<Object> get props => [reason];
}

class _Ready extends ProfileState {
  const _Ready(this.profile);

  final Profile? profile;

  @override
  List<Object?> get props => [profile];
}
