

import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'storage.dart';

class LocalStorageInnerTaskWrapper{

  Task getTask(String branchID, String taskID){
    return Storage.getInstance().branches[branchID].taskList[taskID];
  }

  void createNewInnerTask(String branchID, String taskID, InnerTask innerTask) {
    Storage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTask.id] = innerTask;
  }

  void editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) {
    Storage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTaskID] = innerTask;
  }

  void deleteInnerTask(String branchID, String taskID, String innerTaskID) {
    Storage.getInstance().branches[branchID].taskList[taskID].innerTasks.remove(innerTaskID);
  }

  void editTask(String branchID, Task task) {
    Storage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  void deleteTask(String branchID, String taskID) {
    Storage.getInstance().branches[branchID].taskList.remove(taskID);
  }

}