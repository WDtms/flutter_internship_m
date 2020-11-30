import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'local_storage.dart';


class LocalStorageTaskWrapper{

  List<Task> getTaskList(String branchID){
    return getTaskListCopy(LocalStorage.getInstance().branches[branchID].taskList);
  }

  Map<Color, Color> getBranchTheme(String branchID){
    return LocalStorage.getInstance().branches[branchID].theme;
  }

  void createNewTask(String branchID, Task task) {
    LocalStorage.getInstance().branches[branchID].taskList.add(task);
  }

  void editTask(String branchID, int indexTask, Task task) {
    LocalStorage.getInstance().branches[branchID].taskList[indexTask] = task;
  }

  void deleteTask(String branchID, int taskIndex) {
    LocalStorage.getInstance().branches[branchID].taskList.removeAt(taskIndex);
  }

  void deleteAllCompletedTasks(String branchID) {
    LocalStorage.getInstance().branches[branchID].taskList.removeWhere((task) => task.isDone);
  }

  void changeTheme(String branchID, Map<Color, Color> theme) {
    LocalStorage.getInstance().branches[branchID].theme = theme;
  }

  List<Task> getTaskListCopy(List<Task> taskList){
    List<Task> taskListCopy = List<Task>();
    taskListCopy.addAll(taskList);
    return taskListCopy;
  }

}