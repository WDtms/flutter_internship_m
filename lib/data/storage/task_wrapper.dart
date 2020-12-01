import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'local_storage.dart';


class LocalStorageTaskWrapper{

  Map<String, Task> getTaskList(String branchID){
    return getTaskListCopy(LocalStorage.getInstance().branches[branchID].taskList);
  }

  Map<Color, Color> getBranchTheme(String branchID){
    return LocalStorage.getInstance().branches[branchID].theme;
  }

  void createNewTask(String branchID, Task task) {
    LocalStorage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  void editTask(String branchID, Task task) {
    LocalStorage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  void deleteTask(String branchID, String taskID) {
    LocalStorage.getInstance().branches[branchID].taskList.remove(taskID);
  }

  void deleteAllCompletedTasks(String branchID) {
    LocalStorage.getInstance().branches[branchID].taskList.removeWhere((taskID, task) => task.isDone);
  }

  void changeTheme(String branchID, Map<Color, Color> theme) {
    LocalStorage.getInstance().branches[branchID].theme = theme;
  }

  Map<String, Task> getTaskListCopy(Map<String, Task> taskList){
    Map<String, Task> taskListCopy = Map<String, Task>();
    taskListCopy.addAll(taskList);
    return taskListCopy;
  }

  Task getTask(String branchID, String taskID){
    return LocalStorage.getInstance().branches[branchID].taskList[taskID];
  }

}