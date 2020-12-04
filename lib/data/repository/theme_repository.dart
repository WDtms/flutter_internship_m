import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/storage/theme_wrapper.dart';

class ThemeRepository{

  //Объект для работы с кэшем
  ThemeWrapper themeWrapper = ThemeWrapper();
  //
  //Объект для работы с базой данных
  BranchDBStorage branchDBStorage = BranchDBStorage();

  //Сменить тему на выбранную
  Future<void> changeTheme(String branchID, Map<Color, Color> theme) async {
    themeWrapper.changeTheme(branchID, theme);
    await branchDBStorage.updateObject(themeWrapper.getBranch(branchID).toMap());
  }

  //Получить тему ветки
  Future<Map<Color, Color>> getBranchTheme(String branchID) async{
    return themeWrapper.getBranchTheme(branchID);
  }

}