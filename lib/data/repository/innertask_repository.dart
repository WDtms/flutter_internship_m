
import 'package:flutter_internship_v2/data/database/db_wrappers/innertask_db_wrapper.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/storage/innertask_wrapper.dart';

class InnerTaskRepository{

  InnerTaskDBStorage innerTaskDBStorage = InnerTaskDBStorage();
  TaskDBStorage taskDBStorage = TaskDBStorage();
  LocalStorageInnerTaskWrapper innerTaskWrapper = LocalStorageInnerTaskWrapper();

  Task getTask(String branchID, String taskID){
    return innerTaskWrapper.getTask(branchID, taskID);
  }

  Future<void> createNewInnerTask(String branchID, String taskID, InnerTask innerTask) async {
    innerTaskWrapper.createNewInnerTask(branchID, taskID, innerTask);
    await innerTaskDBStorage.insertObject(innerTask.toMap(branchID, innerTaskWrapper.getTask(branchID, taskID).id));
  }

  Future<void> editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) async {
    innerTaskWrapper.editInnerTask(branchID, taskID, innerTaskID, innerTask);
    await innerTaskDBStorage.updateObject(innerTask.toMap(branchID, innerTaskWrapper.getTask(branchID, taskID).id));
  }

  Future<void> deleteInnerTask(String branchID, String taskID, String innerTaskID) async {
    await innerTaskDBStorage.deleteObject(innerTaskWrapper.getTask(branchID, taskID).innerTasks[innerTaskID].id);
    innerTaskWrapper.deleteInnerTask(branchID, taskID, innerTaskID);
  }

  Future<void> editTask(String branchID, Task task) async {
    innerTaskWrapper.editTask(branchID, task);
    await taskDBStorage.updateObject(task.toMap(branchID));
  }

  Future<void> deleteTask(String branchID, String taskID) async {
    await taskDBStorage.deleteObject(innerTaskWrapper.getTask(branchID, taskID).id);
    innerTaskWrapper.deleteTask(branchID, taskID);
  }

}