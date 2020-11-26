
part of 'theme_cubit.dart';

abstract class ThemeState {
}

class ThemeInitialState extends ThemeState {

}

class ThemeLoadingState extends ThemeState {

}

class ThemeUsageState extends ThemeState {
  final Map<Color, Color> theme;

  ThemeUsageState({this.theme});
}

