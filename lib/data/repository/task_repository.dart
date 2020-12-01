
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/storage/task_wrapper.dart';


class TaskRepository{

  TaskDBStorage _taskDBStorage = TaskDBStorage();
  LocalStorageTaskWrapper taskWrapper = LocalStorageTaskWrapper();

  Map<String, Task> getTaskList(String branchID){
    return  taskWrapper.getTaskList(branchID);
  }

  Future<void> createNewTask(String branchID, Task task) async {
    taskWrapper.createNewTask(branchID, task);
    await _taskDBStorage.insertObject(task.toMap(branchID));
  }

  Future<void> editTask(String branchID, Task task) async {
    taskWrapper.editTask(branchID, task);
    await _taskDBStorage.updateObject(task.toMap(branchID));
  }

  Future<void> deleteTask(String branchID, String taskID) async {
    await _taskDBStorage.deleteObject(taskWrapper.getTaskList(branchID)[taskID].id);
    taskWrapper.deleteTask(branchID, taskID);
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    await _taskDBStorage.deleteAllCompletedTasks(branchID);
    taskWrapper.deleteAllCompletedTasks(branchID);
  }

  Task getTask(String branchID, String taskID){
    return taskWrapper.getTask(branchID, taskID);
  }

}