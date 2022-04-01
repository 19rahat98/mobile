import 'package:data/src/util/util.dart';
import 'package:domain/domain.dart';

abstract class IThemeCache {
  Future<void> setThemeMode(ThemeMode themeMode);
  Future<RequestResult<ThemeMode>> getThemeMode();
}
