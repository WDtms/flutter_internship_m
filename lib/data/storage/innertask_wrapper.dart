

import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'local_storage.dart';

class LocalStorageInnerTaskWrapper{

  Task getTask(String branchID, int indexTask){
    return LocalStorage.getInstance().branches[branchID].taskList[indexTask];
  }

  void createNewInnerTask(String branchID, int indexTask, InnerTask innerTask) {
    LocalStorage.getInstance().branches[branchID].taskList[indexTask].innerTasks.add(innerTask);
  }

  void editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) {
    LocalStorage.getInstance().branches[branchID].taskList[indexTask].innerTasks[innerTaskIndex] = innerTask;
  }

  void deleteInnerTask(String branchID, int indexTask, int innerTaskIndex) {
    LocalStorage.getInstance().branches[branchID].taskList[indexTask].innerTasks.removeAt(innerTaskIndex);
  }

  void editTask(String branchID, int indexTask, Task task) {
    LocalStorage.getInstance().branches[branchID].taskList[indexTask] = task;
  }

  void deleteTask(String branchID, int taskIndex) {
    LocalStorage.getInstance().branches[branchID].taskList.removeAt(taskIndex);
  }

}