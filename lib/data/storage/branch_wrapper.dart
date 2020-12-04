
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'storage.dart';

class LocalStorageBranchWrapper{

  //Загрузка всей информации базы данных в кэш
  void initializeBranches(Map<String, Branch> branches) {
    Storage.getInstance().branches = branches;
  }

  //Создание новой ветки
  void createNewBranch(Branch branch) {
    Storage.getInstance().branches[branch.id] = branch;
  }

  //Удаление ветки
  void deleteBranch(String branchID) {
    Storage.getInstance().branches.remove(branchID);
  }

  //Получение всех веток
  Map<String, Branch> getAllBranches(){
    return Storage.getInstance().branches;
  }

}