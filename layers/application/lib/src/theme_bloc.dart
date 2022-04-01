import 'dart:async';

import 'package:application/util/cache_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theme_bloc.g.dart';
part 'theme_event.dart';
part 'theme_state.dart';

typedef _Emitter = Emitter<ThemeState>;

class ThemeBloc extends CacheBloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required IThemeCache cache,
  })  : _themeCache = cache,
        super(const ThemeState()) {
    on<_Init>(_init);
    on<_CycleThemeMode>(_cycleThemeMode);

    add(const _Init());
  }

  final IThemeCache _themeCache;

  @override
  Future<void> onPersist(ThemeState saveState) async {
    await _themeCache.setThemeMode(saveState.themeMode);
  }

  Future<void> _init(_Init event, _Emitter emit) async {
    await hydrate(emit);

    // cache always has last say
    final themeMode = await _themeCache.getThemeMode();

    if (themeMode.isSuccess) {
      emit(ThemeState(themeMode: themeMode.value));
    }
  }

  FutureOr<void> _cycleThemeMode(
    _CycleThemeMode event,
    Emitter<ThemeState> emit,
  ) {
    late ThemeMode themeMode;

    if (state.themeMode.isSystem) {
      themeMode = ThemeMode.light;
    } else if (state.themeMode.isLight) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }

    emit(ThemeState(themeMode: themeMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return ThemeState.fromJson(json);
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
