import 'package:flutter_internship_v2/styles/my_themes_colors.dart';

class ThemeList{
  ThemeList();

  getThemeList(){
    return themes;
  }

  List<Map> themes = [
    firstTheme,
    secondTheme,
    thirdTheme,
    fourthTheme,
    fifthTheme,
    sixTheme
  ];

}