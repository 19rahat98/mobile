import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initLocalStorage([Directory? dir]) async {
  final appDir = dir ?? await getApplicationDocumentsDirectory();

  Hive.init(join(appDir.path, 'data'));
}
