part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @visibleForTesting
  factory AuthState.authenticated({bool needsOnboarding = false}) =>
      _Authenticated(needsOnboarding: needsOnboarding);

  @visibleForTesting
  const factory AuthState.notAuthenticated() = _NotAuthenticated;

  bool get isAuthenticated => this is _Authenticated;
  bool get isLoading => this is _Loading;

  _Authenticated get asAuthenticated => this as _Authenticated;
}

@JsonSerializable()
class _Authenticated extends AuthState {
  const _Authenticated({required this.needsOnboarding});

  factory _Authenticated.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedToJson(this);

  final bool needsOnboarding;

  @override
  List<Object> get props => [needsOnboarding];
}

class _Loading extends AuthState {
  const _Loading();

  @override
  List<Object> get props => [];
}

class _NotAuthenticated extends AuthState {
  const _NotAuthenticated();

  @override
  List<Object> get props => [];
}
