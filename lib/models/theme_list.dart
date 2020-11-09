import 'package:flutter_internship_v2/styles/my_themes_colors.dart';

class ThemeList{
  ThemeList();

  int currentTheme = 0;

  Map changeAndGetCurrentTheme(int value){
    currentTheme = value;
    return themes[currentTheme];
  }

  List<Map> getAllThemes() {
    return themes;
  }

  Map getCurrentTheme(){
    return themes[currentTheme];
  }

  final List<Map> themes = [
    firstTheme,
    secondTheme,
    thirdTheme,
    fourthTheme,
    fifthTheme,
    sixTheme
  ];

}