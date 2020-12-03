import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'storage.dart';


class LocalStorageTaskWrapper{

  Map<String, Task> getTaskList(String branchID){
    return getTaskListCopy(Storage.getInstance().branches[branchID].taskList);
  }

  Map<Color, Color> getBranchTheme(String branchID){
    return Storage.getInstance().branches[branchID].theme;
  }

  void createNewTask(String branchID, Task task) {
    Storage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  void editTask(String branchID, Task task) {
    Storage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  void deleteTask(String branchID, String taskID) {
    Storage.getInstance().branches[branchID].taskList.remove(taskID);
  }

  void deleteAllCompletedTasks(String branchID) {
    Storage.getInstance().branches[branchID].taskList.removeWhere((taskID, task) => task.isDone);
  }

  void changeTheme(String branchID, Map<Color, Color> theme) {
    Storage.getInstance().branches[branchID].theme = theme;
  }

  Map<String, Task> getTaskListCopy(Map<String, Task> taskList){
    Map<String, Task> taskListCopy = Map<String, Task>();
    taskListCopy.addAll(taskList);
    return taskListCopy;
  }

  Task getTask(String branchID, String taskID){
    return Storage.getInstance().branches[branchID].taskList[taskID];
  }

}