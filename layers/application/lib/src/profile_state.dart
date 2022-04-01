part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  bool get isReady => this is _Ready;
  bool get isOnboardingNeeded => this is _OnBoardingNeeded;
  bool get isPinNeeded => this is _PinNeeded;
  bool get isLoading => this is _Loading;
  bool get isError => this is _Error;

  _Ready get _asReady => this as _Ready;
  _OnBoardingNeeded get _asOnboardingNeeded => this as _OnBoardingNeeded;
  _PinNeeded get _asPinNeeded => this as _PinNeeded;
  _Error get asError => this as _Error;

  PreProfile? get profile {
    if (isReady) {
      return _asReady.profile;
    }

    if (isOnboardingNeeded) {
      return _asOnboardingNeeded.profile;
    }

    if (isPinNeeded) {
      return _asPinNeeded.profile;
    }

    return null;
  }
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

  @override
  final Profile? profile;

  Map<String, dynamic> toJson() => _$ReadyToJson(this);

  @override
  List<Object?> get props => [profile];
}

class _OnBoardingNeeded extends ProfileState {
  const _OnBoardingNeeded(this.profile);

  @override
  final PreProfile? profile;

  @override
  List<Object?> get props => [profile];
}

class _PinNeeded extends ProfileState {
  const _PinNeeded(this.profile);

  @override
  final Profile profile;

  @override
  List<Object?> get props => [profile];
}
