

import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'local_storage.dart';

class LocalStorageInnerTaskWrapper{

  Task getTask(String branchID, String taskID){
    return LocalStorage.getInstance().branches[branchID].taskList[taskID];
  }

  void createNewInnerTask(String branchID, String taskID, InnerTask innerTask) {
    LocalStorage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTask.id] = innerTask;
  }

  void editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) {
    LocalStorage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTaskID] = innerTask;
  }

  void deleteInnerTask(String branchID, String taskID, String innerTaskID) {
    LocalStorage.getInstance().branches[branchID].taskList[taskID].innerTasks.remove(innerTaskID);
  }

  void editTask(String branchID, Task task) {
    LocalStorage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  void deleteTask(String branchID, String taskID) {
    LocalStorage.getInstance().branches[branchID].taskList.remove(taskID);
  }

}