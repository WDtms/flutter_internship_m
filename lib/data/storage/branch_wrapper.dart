

import 'package:flutter_internship_v2/data/models/all_branch_info.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/models/one_branch_info.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

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

  AllBranchesInfo getAllBranchesTasksInfo(){
    int countAllCompleted = 0;
    int countAllUnCompleted = 0;
    for (int i = 0; i<LocalStorage.getInstance().branches.length; i++){
      Map<int, int> tasksInfo = _calculateTaskInfo(LocalStorage.getInstance().branches.values.toList().elementAt(i).taskList);
      countAllCompleted += tasksInfo.keys.toList().first;
      countAllUnCompleted += tasksInfo.values.toList().first;
    }
    return AllBranchesInfo(
      countAllCompleted: countAllCompleted,
      countAllUncompleted: countAllUnCompleted,
      progress: _calculateProgressDouble({countAllCompleted : countAllUnCompleted}),
    );
  }

  List<OneBranchInfo> getAllBranchesInfo(){
    List<OneBranchInfo> branchesInfo = List<OneBranchInfo>();
    for (int i = 0; i<LocalStorage.getInstance().branches.length; i++){
      Branch branch = LocalStorage.getInstance().branches.values.toList().elementAt(i);
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

  Map<int, int> _calculateTaskInfo(List<Task> taskList){
    int countCompleted = 0;
    int countUncompleted = 0;
    for (Task task in taskList){
      if (task.isDone)
        countCompleted++;
      else
        countUncompleted++;
    }
    return {countCompleted : countUncompleted};
  }

}