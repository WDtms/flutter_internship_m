
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/storage/task_wrapper.dart';


class TaskRepository{

  //Объект для работы с базой данных
  final TaskDBStorage taskDBStorage;
  //
  //Объект для работы с кэшем
  final LocalStorageTaskWrapper taskWrapper;

  TaskRepository({this.taskDBStorage, this.taskWrapper});

  //Получение списка задач из кэша
  Map<String, Task> getTaskList(String branchID){
    return taskWrapper.getTaskList(branchID);
  }

  //Создание новой задачи
  Future<void> createNewTask(String branchID, Task task) async {
    taskWrapper.createNewTask(branchID, task);
    await taskDBStorage.insertObject(task.toMap(branchID));
  }

  //Редактирование задачи
  Future<void> editTask(String branchID, Task task) async {
    taskWrapper.editTask(branchID, task);
    await taskDBStorage.updateObject(task.toMap(branchID));
  }

  //Удаление задачи
  Future<void> deleteTask(String branchID, String taskID) async {
    await taskDBStorage.deleteObject(taskWrapper.getTaskList(branchID)[taskID].id);
    taskWrapper.deleteTask(branchID, taskID);
  }

  //Удаление всех завершенных задач
  Future<void> deleteAllCompletedTasks(String branchID, List<String> taskIDList) async {
    await taskDBStorage.deleteAllCompletedTasks(branchID, taskIDList);
    taskWrapper.deleteAllCompletedTasks(branchID);
  }

  //Получение задачи из кэша
  Task getTask(String branchID, String taskID){
    return taskWrapper.getTask(branchID, taskID);
  }

}