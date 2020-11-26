
import 'package:flutter_internship_v2/data/database/db_wrappers/innertask_db_wrapper.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/storage/innertask_wrapper.dart';

class InnerTaskRepository{

  InnerTaskDBStorage innerTaskDBStorage = InnerTaskDBStorage();
  TaskDBStorage taskDBStorage = TaskDBStorage();
  LocalStorageInnerTaskWrapper innerTaskWrapper = LocalStorageInnerTaskWrapper();

  Task getTask(String branchID, int indexTask){
    return innerTaskWrapper.getTask(branchID, indexTask);
  }

  Future<void> createNewInnerTask(String branchID, int indexTask, InnerTask innerTask) async {
    innerTaskWrapper.createNewInnerTask(branchID, indexTask, innerTask);
    await innerTaskDBStorage.insertObject(innerTask.toMap(branchID, innerTaskWrapper.getTask(branchID, indexTask).id));
  }

  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    innerTaskWrapper.editInnerTask(branchID, indexTask, innerTaskIndex, innerTask);
    await innerTaskDBStorage.updateObject(innerTask.toMap(branchID, innerTaskWrapper.getTask(branchID, indexTask).id));
  }

  Future<void> deleteInnerTask(String branchID, int indexTask, int innerTaskIndex) async {
    await innerTaskDBStorage.deleteObject(innerTaskWrapper.getTask(branchID, indexTask).innerTasks[innerTaskIndex].id);
    innerTaskWrapper.deleteInnerTask(branchID, indexTask, innerTaskIndex);
  }

  Future<void> editTask(String branchID, int indexTask, Task task) async {
    innerTaskWrapper.editTask(branchID, indexTask, task);
    await taskDBStorage.updateObject(task.toMap(branchID));
  }

  Future<void> deleteTask(String branchID, int indexTask) async {
    await taskDBStorage.deleteObject(innerTaskWrapper.getTask(branchID, indexTask).id);
    innerTaskWrapper.deleteTask(branchID, indexTask);
  }

}