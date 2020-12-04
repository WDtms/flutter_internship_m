
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/storage/branch_wrapper.dart';

class BranchRepository{

  //Объект для работы с базой данных
  BranchDBStorage _branchDBStorage = BranchDBStorage();
  //
  //Объект для работы с кэшем
  LocalStorageBranchWrapper _branchWrapper = LocalStorageBranchWrapper();

  //Подтягивание и кэширование всей информации из базы данных
  Future<void> initializeBranches() async {
    _branchWrapper.initializeBranches(await _branchDBStorage.initializeBranches());
  }

  //Создание ветки
  Future<void> createNewBranch(Branch branch) async {
    _branchWrapper.createNewBranch(branch);
    await _branchDBStorage.insertObject(branch.toMap());
  }

  //Удаление ветки
  Future<void> deleteBranch(String branchID) async {
    await _branchDBStorage.deleteObject(branchID);
    _branchWrapper.deleteBranch(branchID);
  }

  //Получение всех веток из кэша
  Map<String, Branch> getAllBranches(){
    return _branchWrapper.getAllBranches();
  }


}