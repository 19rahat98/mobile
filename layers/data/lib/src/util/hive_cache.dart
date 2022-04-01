import 'dart:async';

import 'package:hive/hive.dart';

abstract class HiveCache<T extends Object?> {
  HiveCache(this._name) : _completer = Completer() {
    _open();
  }

  late Box<T> cache;
  final String _name;
  final Completer<Box<T>> _completer;

  Future<void> cacheInit() async {
    cache = await _completer.future;
  }

  Future<void> _open() async {
    final box = await Hive.openBox<T>(_name);

    _completer.complete(box);
  }
}
