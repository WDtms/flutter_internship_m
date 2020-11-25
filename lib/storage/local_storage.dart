import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/branch.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/notification/notification_helper.dart';

class LocalStorage{

  Map<String, Branch> branches = Map<String, Branch>();

  //Работа на ГЛАВНОЙ СТРАНИЦЕ

  void initializeBranches() {

  }


  void createNewBranch(Branch branch) {
    branches[branch.id] = branch;
  }

  void deleteBranch(String branchID) {
    branches.remove(branchID);
  }

  void changeTheme(String branchID, Map<Color, Color> theme) {
    branches[branchID].theme = theme;
  }


  //Конец методов ГЛАВНОЙ СТРАНИЦЫ

  //Работа на странице ОДНОЙ ВЕТКИ

  List<Task> getTaskList(String id){
    return branches[id].taskList;
  }

  void createNewTask(String branchID, Task task) {
    branches[branchID].taskList.add(task);
    if (task.notificationTime != null){
      await NotificationHelper.scheduleNotification(task);
    }
  }

  Future<void> editTask(String branchID, int indexTask, Task task) async {
    if (task.notificationTime != branches[branchID].taskList[indexTask].notificationTime)
      await NotificationHelper.scheduleNotification(task);
    branches[branchID].taskList[indexTask] = task;
  }

  Future<void> deleteTask(String branchID, int taskIndex) async {
    branches[branchID].taskList.removeAt(taskIndex);
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    branches[branchID].taskList.removeWhere((task) => task.isDone);
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
  }

  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    branches[branchID].taskList[indexTask].innerTasks[innerTaskIndex] = innerTask;
  }

  Future<void> deleteInnerTask(String branchID, int indexTask, int innerTaskIndex) async {
    branches[branchID].taskList[indexTask].innerTasks.removeAt(innerTaskIndex);
  }

}