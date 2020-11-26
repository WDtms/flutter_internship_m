
import 'package:flutter_internship_v2/data/models/all_branch_info.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/models/one_branch_info.dart';
import 'package:flutter_internship_v2/data/repository/branch_repository.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:uuid/uuid.dart';

class BranchInteractor {

  final BranchRepository branchRepository;

  BranchInteractor({this.branchRepository});

  Future<void> initiateBranches() async {
    await branchRepository.initializeBranches();
  }

  Future<void> createNewBranch(String branchName) async{
    await branchRepository.createNewBranch(
        Branch(
          id: Uuid().v4(),
          title: branchName,
          taskList: [],
          theme: themes[0],
        )
    );
  }

  Future<void> removeBranch(String branchID) async {
    await branchRepository.deleteBranch(branchID);
  }

  Future<List<OneBranchInfo>> getAllBranchesInfo() async {
    return branchRepository.getAllBranchesInfo();
  }

  Future<AllBranchesInfo> getAllBranchesTasksInfo() async {
    return branchRepository.getAllBranchesTasksInfo();
  }

}