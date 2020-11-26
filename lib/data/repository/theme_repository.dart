import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/storage/theme_wrapper.dart';

class ThemeRepository{

  ThemeWrapper themeWrapper = ThemeWrapper();
  BranchDBStorage branchDBStorage = BranchDBStorage();

  Future<void> changeTheme(String branchID, Map<Color, Color> theme) async {
    themeWrapper.changeTheme(branchID, theme);
    await branchDBStorage.updateObject(themeWrapper.getBranch(branchID).toMap());
  }

  Future<Map<Color, Color>> getBranchTheme(String branchID) async{
    return themeWrapper.getBranchTheme(branchID);
  }

}