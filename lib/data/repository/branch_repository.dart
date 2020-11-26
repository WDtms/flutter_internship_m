
import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/storage/branch_wrapper.dart';

class BranchRepository{

  BranchDBStorage branchDBStorage = BranchDBStorage();
  LocalStorageBranchWrapper branchWrapper = LocalStorageBranchWrapper();

  Future<void> initializeBranches() async {
    branchWrapper.initializeBranches(await branchDBStorage.initializeBranches());
  }

  Future<void> createNewBranch(Branch branch) async {
    branchWrapper.createNewBranch(branch);
    await branchDBStorage.insertObject(branch.toMap());
  }

  Future<void> deleteBranch(String branchID) async {
    await branchDBStorage.deleteObject(branchID);
    branchWrapper.deleteBranch(branchID);
  }

  Map<String, Branch> getAllBranches(){
    return branchWrapper.getAllBranches();
  }


}