import 'dart:async';

import 'package:application/util/bloc_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract class CacheBloc<Event, State> extends Bloc<Event, State> {
  CacheBloc(
    State initialState, {
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super(initialState);

  final Logger _logger;

  /// [identifier] is used to uniquely identify multiple instances of
  /// the same [Bloc] type. In most cases it is not
  /// necessary; however, if you wish to intentionally have multiple
  /// instances of the same [Bloc], then you must override
  /// [identifier] and return a unique identifier for each [Bloc]
  /// instance in order to keep the caches independent of each other.
  String get identifier => '';

  @nonVirtual
  String get id => '${runtimeType}_$identifier';

  State? fromJson(Map<String, dynamic>? json);
  Map<String, dynamic>? toJson(State state);

  /// [hydrate] is used to restore the [Bloc] state from
  /// [storage].
  Future<bool> hydrate(Emitter emit) async {
    final cachedState = await retrieve();

    if (cachedState == null) {
      return false;
    }

    emit(cachedState);
    return true;
  }

  Future<State?> retrieve([String? id]) async {
    final result = await storage.read(id ?? this.id);

    if (result == null) {
      return null;
    }

    try {
      return fromJson(Map<String, dynamic>.from(result));
    } catch (e, stack) {
      _logger.e('Error parsing from json, deleting value from cache', e, stack);
      await storage.delete(id ?? this.id);
      return null;
    }
  }

  /// [persist] is used to persist the [Bloc] state to
  /// [storage].
  Future<void> persist(State state) async {
    final result = toJson(state);

    if (result == null) {
      return;
    }

    await storage.write(id, result);
  }

  static BlocStorage? _storage;

  static set storage(BlocStorage storage) {
    _storage = storage;
  }

  @override
  Future<void> onChange(Change<State> change) async {
    super.onChange(change);

    await persist(change.nextState);
  }

  @override
  Future<void> close() async {
    await persist(state);
    await super.close();
  }

  static BlocStorage get storage {
    if (_storage == null) {
      throw StateError('BlocStorage is not set');
    }

    return _storage!;
  }
}
