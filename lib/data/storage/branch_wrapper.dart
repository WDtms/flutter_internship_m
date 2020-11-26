
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'local_storage.dart';

class LocalStorageBranchWrapper{

  void initializeBranches(Map<String, Branch> branches) {
    LocalStorage.getInstance().branches = branches;
  }

  void createNewBranch(Branch branch) {
    LocalStorage.getInstance().branches[branch.id] = branch;
  }

  void deleteBranch(String branchID) {
    LocalStorage.getInstance().branches.remove(branchID);
  }

  Map<String, Branch> getAllBranches(){
    return LocalStorage.getInstance().branches;
  }

}