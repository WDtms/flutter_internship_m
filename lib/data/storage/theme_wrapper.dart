import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';

import 'storage.dart';

class ThemeWrapper{

  //Получение цветовой темы ветки
  Map<Color, Color> getBranchTheme(String branchID){
    return Storage.getInstance().branches[branchID].theme;
  }

  //Изменение цветовой темы ветки
  void changeTheme(String branchID, Map<Color, Color> theme) {
    Storage.getInstance().branches[branchID].theme = theme;
  }

  //Получение ветки
  Branch getBranch(String branchID){
    return Storage.getInstance().branches[branchID];
  }

}