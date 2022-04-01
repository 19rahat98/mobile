enum ThemeMode {
  light,
  dark,
  system,
}

extension ThemeModeX on ThemeMode {
  bool get isLight => this == ThemeMode.light;
  bool get isDark => this == ThemeMode.dark;
  bool get isSystem => this == ThemeMode.system;
}

final _themeModeEnumMap = {
  ThemeMode.light.name: ThemeMode.light,
  ThemeMode.dark.name: ThemeMode.dark,
  ThemeMode.system.name: ThemeMode.system,
};

extension ThemeModeListX on Iterable<ThemeMode> {
  ThemeMode fromString(String value) {
    return _themeModeEnumMap[value] ?? ThemeMode.system;
  }
}
