
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/storage/branch_wrapper.dart';

class BranchRepository{

  //Объект для работы с базой данных
  BranchDBStorage branchDBStorage = BranchDBStorage();
  //
  //Объект для работы с кэшем
  LocalStorageBranchWrapper branchWrapper = LocalStorageBranchWrapper();

  //Подтягивание и кэширование всей информации из базы данных
  Future<void> initializeBranches() async {
    branchWrapper.initializeBranches(await branchDBStorage.initializeBranches());
  }

  //Создание ветки
  Future<void> createNewBranch(Branch branch) async {
    branchWrapper.createNewBranch(branch);
    await branchDBStorage.insertObject(branch.toMap());
  }

  //Удаление ветки
  Future<void> deleteBranch(String branchID) async {
    await branchDBStorage.deleteObject(branchID);
    branchWrapper.deleteBranch(branchID);
  }

  //Получение всех веток из кэша
  Map<String, Branch> getAllBranches(){
    return branchWrapper.getAllBranches();
  }


}