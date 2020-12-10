import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/storage/theme_wrapper.dart';

class ThemeRepository{

  //Объект для работы с кэшем
  final ThemeWrapper _themeWrapper;
  //
  //Объект для работы с базой данных
  final BranchDBStorage _branchDBStorage;

  ThemeRepository(this._branchDBStorage, this._themeWrapper);

  //Сменить тему на выбранную
  Future<void> changeTheme(String branchID, Map<Color, Color> theme) async {
    _themeWrapper.changeTheme(branchID, theme);
    await _branchDBStorage.updateObject(_themeWrapper.getBranch(branchID).toMap());
  }

  //Получить тему ветки
  Map<Color, Color> getBranchTheme(String branchID) {
    return _themeWrapper.getBranchTheme(branchID);
  }

}