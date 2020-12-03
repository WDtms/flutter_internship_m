
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'storage.dart';

class LocalStorageBranchWrapper{

  void initializeBranches(Map<String, Branch> branches) {
    Storage.getInstance().branches = branches;
  }

  void createNewBranch(Branch branch) {
    Storage.getInstance().branches[branch.id] = branch;
  }

  void deleteBranch(String branchID) {
    Storage.getInstance().branches.remove(branchID);
  }

  Map<String, Branch> getAllBranches(){
    return Storage.getInstance().branches;
  }

}