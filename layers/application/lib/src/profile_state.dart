part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  bool get isReady => this is _Ready;
  bool get isLoading => this is _Loading;
  bool get isError => this is _Error;

  _Ready get asReady => this as _Ready;
  _Error get asError => this as _Error;
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

@JsonSerializable()
class _Ready extends ProfileState {
  const _Ready(this.profile);

  factory _Ready.fromJson(Map<String, dynamic> json) => _$ReadyFromJson(json);

  final Profile? profile;

  Map<String, dynamic> toJson() => _$ReadyToJson(this);

  @override
  List<Object?> get props => [profile];
}

class _OnBoardingNeeded extends ProfileState {
  const _OnBoardingNeeded(this.profile);

  final PreProfile? profile;

  @override
  List<Object?> get props => [profile];
}
