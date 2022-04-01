part of 'pin_bloc.dart';

abstract class PinState extends Equatable {
  const PinState();

  bool get isReady => this is _Ready;
  bool get isVerified => this is _Verified;
  bool get isFailed => this is _Failed;
  bool get isLoading => this is _Loading;
  bool get isError => this is _Error;

  _Ready get asReady => this as _Ready;
  _Error get asError => this as _Error;
  _Failed get asFailed => this as _Failed;
}

class _Ready extends PinState {
  const _Ready(this.pinVerification);

  final PinVerification pinVerification;

  @override
  List<Object> get props => [];
}

class _Verified extends PinState {
  const _Verified();

  @override
  List<Object> get props => [];
}

class _Failed extends PinState {
  const _Failed(this.pinVerification);

  final PinVerification pinVerification;

  @override
  List<Object> get props => [pinVerification];
}

class _Loading extends PinState {
  const _Loading();

  @override
  List<Object> get props => [];
}

class _Error extends PinState {
  const _Error(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
