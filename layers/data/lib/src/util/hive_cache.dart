import 'dart:async';

import 'package:hive/hive.dart';

abstract class HiveCache {
  HiveCache(String name, {Box? box}) {
    if (box != null) {
      __box = box as Box<Map>;
    } else {
      __box = Hive.openBox(name);
    }

    _open();
  }

  late final FutureOr<Box<Map>> __box;
  late final Box<Map> cache;

  Future<void> _open() async {
    cache = await __box;
  }
}
