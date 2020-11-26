
import 'package:flutter_internship_v2/data/database/db_storage/task_db_storage.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/storage/task_wrapper.dart';


class TaskRepository{

  TaskDBStorage _taskDBStorage = TaskDBStorage();
  LocalStorageTaskWrapper taskWrapper = LocalStorageTaskWrapper();

  List<Task> getTaskList(String branchID){
    return  taskWrapper.getTaskList(branchID);
  }

  Future<void> createNewTask(String branchID, Task task) async {
    taskWrapper.createNewTask(branchID, task);
    await _taskDBStorage.insertObject(task.toMap(branchID));
  }

  Future<void> editTask(String branchID, int indexTask, Task task) async {
    taskWrapper.editTask(branchID, indexTask, task);
    await _taskDBStorage.updateObject(task.toMap(branchID));
  }

  Future<void> deleteTask(String branchID, int taskIndex) async {
    await _taskDBStorage.deleteObject(taskWrapper.getTaskList(branchID)[taskIndex].id);
    taskWrapper.deleteTask(branchID, taskIndex);
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    await _taskDBStorage.deleteAllCompletedTasks(branchID);
    taskWrapper.deleteAllCompletedTasks(branchID);
  }

}