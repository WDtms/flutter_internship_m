import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';

import 'local_storage.dart';

class ThemeWrapper{

  Map<Color, Color> getBranchTheme(String branchID){
    return LocalStorage.getInstance().branches[branchID].theme;
  }

  void changeTheme(String branchID, Map<Color, Color> theme) {
    LocalStorage.getInstance().branches[branchID].theme = theme;
  }

  Branch getBranch(String branchID){
    return LocalStorage.getInstance().branches[branchID];
  }

}