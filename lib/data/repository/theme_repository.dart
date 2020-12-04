import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/storage/theme_wrapper.dart';

class ThemeRepository{

  //Объект для работы с кэшем
  ThemeWrapper _themeWrapper = ThemeWrapper();
  //
  //Объект для работы с базой данных
  BranchDBStorage _branchDBStorage = BranchDBStorage();

  //Сменить тему на выбранную
  Future<void> changeTheme(String branchID, Map<Color, Color> theme) async {
    _themeWrapper.changeTheme(branchID, theme);
    await _branchDBStorage.updateObject(_themeWrapper.getBranch(branchID).toMap());
  }

  //Получить тему ветки
  Future<Map<Color, Color>> getBranchTheme(String branchID) async{
    return _themeWrapper.getBranchTheme(branchID);
  }

}