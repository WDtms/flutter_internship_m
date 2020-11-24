import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/database/db_actions.dart';
import 'package:flutter_internship_v2/models/all_branch_info.dart';
import 'package:flutter_internship_v2/models/one_branch_info.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/branch.dart';
import 'package:flutter_internship_v2/styles/my_themes_colors.dart';
import 'package:uuid/uuid.dart';

class Repository{


  DBStorageAction dbActions = DBStorageAction();
  Map<String, Branch> branches = Map<String, Branch>();

  //Работа на ГЛАВНОЙ СТРАНИЦЕ

  Future<void> initializeBranches() async {
    branches = await dbActions.initializeBranches();
  }


  Future<void> createNewBranch() async {
    String id = Uuid().v4();
    Branch branch = Branch(
      id: id,
      title: 'new',
      taskList: [],
      theme: firstTheme,
    );
    await dbActions.insertBranch(branch.toMap());
    branches[id] = branch;
  }

  Future<void> changeTheme(String branchID, Map<Color, Color> theme) async {
    branches[branchID].theme = theme;
  }

  AllBranchesInfo getAllBranchesTasksInfo(){
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

  List<OneBranchInfo> getAllBranchesInfo(){
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

  //Конец методов ГЛАВНОЙ СТРАНИЦЫ

  //Работа на странице ОДНОЙ ВЕТКИ

  List<Task> getTaskList(String id){
    return branches[id].taskList;
  }

  Future<void> createNewTask(String branchID, Task task) async {
    branches[branchID].taskList.add(task);
    await dbActions.insertTask(task.toMap(branchID));
  }

  Future<void> editTask(String branchID, int indexTask, Task task) async {
    branches[branchID].taskList[indexTask] = task;
    await dbActions.updateTask(task.toMap(branchID));
  }

  Future<void> deleteTask(String branchID, int taskIndex) async {
    branches[branchID].taskList.removeAt(taskIndex);
    await dbActions.deleteTask(branches[branchID].taskList[taskIndex].id);
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    branches[branchID].taskList.removeWhere((task) => task.isDone);
    List<String> tasksToDeleteId = List<String>();
    for (Task task in branches[branchID].taskList){
      if (task.isDone)
        tasksToDeleteId.add(task.id);
    }
    await dbActions.deleteallCompletedTasks(tasksToDeleteId);
  }

  Map<Color, Color> getBranchTheme(String branchID){
    return branches[branchID].theme;
  }

  //Конец методов страницы с ОДНОЙ ВЕТКОЙ


  //Работа с ОДНОЙ ЗАДАЧЕЙ

  Task getTask(String branchID, int indexTask){
    return branches[branchID].taskList[indexTask];
  }

  Future<void> createNewInnerTask(String branchID, int indexTask, InnerTask innerTask) async {
    branches[branchID].taskList[indexTask].innerTasks.add(innerTask);
    await dbActions.insertInnerTask(innerTask.toMap(branchID, branches[branchID].taskList[indexTask].id));
  }

  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    branches[branchID].taskList[indexTask].innerTasks[innerTaskIndex] = innerTask;
    await dbActions.updateInnerTask(innerTask.toMap(branchID, branches[branchID].taskList[indexTask].id));
  }

  Future<void> deleteInnerTask(String branchID, int indexTask, int innerTaskIndex) async {
    branches[branchID].taskList[indexTask].innerTasks.removeAt(innerTaskIndex);
    await dbActions.deleteInnerTask(branches[branchID].taskList[indexTask].innerTasks[innerTaskIndex].id);
  }

  //Конец методов страницы с ОДНОЙ ЗАДАЧЕЙ
}