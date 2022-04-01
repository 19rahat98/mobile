part of 'pin_bloc.dart';

abstract class PinEvent extends Equatable {
  const PinEvent();
}

class _Init extends PinEvent {
  const _Init(this.profileId);

  final String profileId;

  @override
  List<Object> get props => [profileId];
}

/// to be used when the profile id is not known
class _Fail extends PinEvent {
  const _Fail();

  @override
  List<Object> get props => [];
}

class _Verify extends PinEvent {
  const _Verify(this.pin);

  final String pin;

  @override
  List<Object> get props => [pin];
}

extension PinBlocX on PinBloc {
  void init(String profileId) {
    add(_Init(profileId));
  }

  void verify(String pin) {
    add(_Verify(pin));
  }

  void fail() {
    add(const _Fail());
  }
}
