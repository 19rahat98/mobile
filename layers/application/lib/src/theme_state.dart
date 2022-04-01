part of 'theme_bloc.dart';

@JsonSerializable()
class ThemeState extends Equatable {
  const ThemeState({
    this.themeMode = ThemeMode.system,
  });

  factory ThemeState.fromJson(Map<String, dynamic> json) =>
      _$ThemeStateFromJson(json);

  final ThemeMode themeMode;

  Map<String, dynamic> toJson() => _$ThemeStateToJson(this);

  @override
  List<Object> get props => [themeMode];
}
