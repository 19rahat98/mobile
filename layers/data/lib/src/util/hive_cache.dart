import 'dart:async';

import 'package:hive/hive.dart';

abstract class HiveCache<T extends Object?> {
  HiveCache(String name, {Box? box}) {
    if (box != null) {
      __box = box as Box<T>;
    } else {
      __box = Hive.openBox<T>(name);
    }

    _open();
  }

  late final FutureOr<Box<T>> __box;
  late final Box<T> cache;

  Future<void> _open() async {
    cache = await __box;
  }
}
