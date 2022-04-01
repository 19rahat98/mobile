part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class _Init extends ThemeEvent {
  const _Init();

  @override
  List<Object> get props => [];
}

class _CycleThemeMode extends ThemeEvent {
  const _CycleThemeMode();

  @override
  List<Object> get props => [];
}

extension ExampleBlocX on ThemeBloc {
  void cycleThemeMode() {
    add(const _CycleThemeMode());
  }
}
