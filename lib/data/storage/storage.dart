

import 'package:flutter_internship_v2/data/models/branch.dart';

class Storage{

  static Storage _instance;

  static Storage getInstance() {
    if(_instance == null) {
      _instance = Storage();
      return _instance;
    }
    return _instance;
  }

  //Массив со всей кэшированной информацией
  Map<String, Branch> branches = Map<String, Branch>();

}