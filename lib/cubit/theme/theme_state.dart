
part of 'theme_cubit.dart';

abstract class ThemeState {
  const ThemeState();
}

class ThemeInitialState extends ThemeState {
  const ThemeInitialState();
}

class ThemeChangedState extends ThemeState {
  final Map theme;

  const ThemeChangedState({this.theme});
}

