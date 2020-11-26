

import 'package:flutter_internship_v2/data/models/branch.dart';

class LocalStorage{

  static LocalStorage _instance;

  static LocalStorage getInstance() {
    if(_instance == null) {
      _instance = LocalStorage();
      return _instance;
    }
    return _instance;
  }

  Map<String, Branch> branches = Map<String, Branch>();

}