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
