import 'package:flutter/material.dart';
import 'file:///C:/Android/AndroidStudioProjects/flutter_internship_m/lib/database/db_actions.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/task_list.dart';

import 'package:flutter_internship_v2/styles/my_themes_colors.dart';
import 'package:uuid/uuid.dart';

class Repository{


  DBStorageAction dbActions = DBStorageAction();
  Map<String, TaskList> branches = Map<String, TaskList>();

  //Работа на ГЛАВНОЙ СТРАНИЦЕ

  Future<void> initializeBranches() async {
    branches = await dbActions.initializeBranches();
  }

  Map<Map<String, String>, Map<dynamic, dynamic>> getBranchesInfo(){
    Map<Map<String, String>, Map<dynamic, dynamic>> branchesInfo = Map<Map<String, String>, Map<dynamic, dynamic>>();
    for (int i = 0; i<branches.length; i++){
      branchesInfo[{branches.keys.toList().elementAt(i) : branches[branches.keys.toList().elementAt(i)].title}]
        = getInfoFromOneBranch(branches.keys.toList().elementAt(i));
    }
    return branchesInfo;
  }

  Map<dynamic, dynamic> getInfoFromOneBranch(String id){
    int countCompletedTasks = 0;
    int countAllTasks = 0;
    for (Task task in branches[id].taskList){
      if (task.isDone)
        countCompletedTasks++;
      countAllTasks++;
    }
    return {
      countCompletedTasks : countAllTasks,
      branches[id].theme.keys.toList().first : branches[id].theme.values.toList().first,
    };
  }

  Future<void> createNewBranch() async {
    String id = Uuid().v4();
    TaskList branch = TaskList(
      id: id,
      title: 'new',
      taskList: [],
      theme: firstTheme,
    );
    await dbActions.insertBranch(branch.toMap());
    branches[id] = branch;
  }

  void changeTheme(String branchID, Map<Color, Color> theme){
    branches[branchID].theme = theme;
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