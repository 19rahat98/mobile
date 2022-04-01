import 'package:data/src/theme/i_theme_repos.dart';
import 'package:data/src/util/util.dart';
import 'package:domain/enums/theme_mode.dart';

class _Keys {
  const _Keys._();

  static String get themeMode => 'themeMode';
}

class ThemeCache extends HiveCache implements IThemeCache {
  ThemeCache() : super('theme');

  @override
  Future<RequestResult<ThemeMode>> getThemeMode() async {
    try {
      final result = cache.get(
            _Keys.themeMode,
          ) as String? ??
          ThemeMode.system.name;

      final themeMode = ThemeMode.values.fromString(result);

      return RequestResult.success(themeMode);
    } catch (e) {
      return RequestResult.error('$e');
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await cache.put(_Keys.themeMode, themeMode.name);
  }
}
