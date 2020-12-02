
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/branch_repository.dart';
import 'package:flutter_internship_v2/domain/models/all_branch_info.dart';
import 'package:flutter_internship_v2/domain/models/one_branch_info.dart';
import 'package:uuid/uuid.dart';

class BranchInteractor {

  final BranchRepository branchRepository;

  BranchInteractor({this.branchRepository});

  Future<void> initiateBranches() async {
    await branchRepository.initializeBranches();
  }

  Future<void> createNewBranch(String branchName, Map<Color, Color> theme) async{
    await branchRepository.createNewBranch(
        Branch(
          id: Uuid().v4(),
          title: branchName,
          taskList: {},
          theme: theme,
        )
    );
  }

  Future<void> removeBranch(String branchID) async {
    await branchRepository.deleteBranch(branchID);
  }

  Future<AllBranchesInfo> getAllBranchesTasksInfo() async {
    Map<String, Branch> branches = await branchRepository.getAllBranches();
    int countAllCompleted = 0;
    int countAllUnCompleted = 0;
    for (int i = 0; i<branches.length; i++){
      Map<int, int> tasksInfo = _calculateTaskInfo(branches.values.toList().elementAt(i).taskList);
      countAllCompleted += tasksInfo.keys.toList().first;
      countAllUnCompleted += tasksInfo.values.toList().first;
    }
    return AllBranchesInfo(
      countAllCompleted: countAllCompleted,
      countAllUncompleted: countAllUnCompleted,
      progress: _calculateProgressDouble({countAllCompleted : countAllUnCompleted}),
    );
  }

  Future<List<OneBranchInfo>> getAllBranchesInfo() async {
    Map<String, Branch> branches = await branchRepository.getAllBranches();
    List<OneBranchInfo> branchesInfo = List<OneBranchInfo>();
    for (int i = 0; i<branches.length; i++){
      Branch branch = branches.values.toList().elementAt(i);
      Map<int, int> tasksInfo = _calculateTaskInfo(branch.taskList);
      branchesInfo.add(
          OneBranchInfo(
            id: branch.id,
            title: branch.title,
            countCompletedTasks: tasksInfo.keys.toList().first,
            countUnCompletedTasks: tasksInfo.values.toList().first,
            completedColor: branch.theme.keys.toList().first,
            backGroundColor: branch.theme.values.toList().first,
            progress: _calculateProgressDouble(tasksInfo),
          )
      );
    }
    return branchesInfo;
  }

  double _calculateProgressDouble(Map<int, int> info){
    if (info.values.toList().first+info.keys.toList().first == 0)
      return 0;
    else
      return info.keys.toList().first/
          (info.values.toList().first+info.keys.toList().first);
  }

  Map<int, int> _calculateTaskInfo(Map<String, Task> taskList){
    int countCompleted = 0;
    int countUncompleted = 0;
    for (int i = 0; i<taskList.length; i++){
      if (taskList.values.toList().elementAt(i).isDone)
        countCompleted++;
      else
        countUncompleted++;
    }
    return {countCompleted : countUncompleted};
  }

}