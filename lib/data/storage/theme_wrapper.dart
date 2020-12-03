import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';

import 'storage.dart';

class ThemeWrapper{

  Map<Color, Color> getBranchTheme(String branchID){
    return Storage.getInstance().branches[branchID].theme;
  }

  void changeTheme(String branchID, Map<Color, Color> theme) {
    Storage.getInstance().branches[branchID].theme = theme;
  }

  Branch getBranch(String branchID){
    return Storage.getInstance().branches[branchID];
  }

}