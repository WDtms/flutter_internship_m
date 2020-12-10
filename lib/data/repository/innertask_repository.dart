
import 'package:flutter_internship_v2/data/database/db_wrappers/innertask_db_wrapper.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/storage/innertask_wrapper.dart';

class InnerTaskRepository{

  //Объект для работы с таблицой внутренних задач базы данных
  final InnerTaskDBStorage _innerTaskDBStorage;
  //
  //Объект для работы с таблицей задач базы данных
  final TaskDBStorage _taskDBStorage;
  //
  //Объект для работы с кэшем
  final LocalStorageInnerTaskWrapper _innerTaskWrapper;

  InnerTaskRepository(this._innerTaskDBStorage, this._taskDBStorage, this._innerTaskWrapper);

  //Получение задачи из кэша
  Task getTask(String branchID, String taskID){
    return _innerTaskWrapper.getTask(branchID, taskID);
  }

  //Создание новой внутренней задачи
  Future<void> createNewInnerTask(String branchID, String taskID, InnerTask innerTask) async {
    _innerTaskWrapper.createNewInnerTask(branchID, taskID, innerTask);
    await _innerTaskDBStorage.insertObject(innerTask.toMap(branchID, _innerTaskWrapper.getTask(branchID, taskID).id));
  }

  //Редактирование внутренней задачи
  Future<void> editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) async {
    _innerTaskWrapper.editInnerTask(branchID, taskID, innerTaskID, innerTask);
    await _innerTaskDBStorage.updateObject(innerTask.toMap(branchID, _innerTaskWrapper.getTask(branchID, taskID).id));
  }

  //Удаление внутренней задачи
  Future<void> deleteInnerTask(String branchID, String taskID, String innerTaskID) async {
    await _innerTaskDBStorage.deleteObject(_innerTaskWrapper.getTask(branchID, taskID).innerTasks[innerTaskID].id);
    _innerTaskWrapper.deleteInnerTask(branchID, taskID, innerTaskID);
  }

  //Редактирование задачи
  Future<void> editTask(String branchID, Task task) async {
    _innerTaskWrapper.editTask(branchID, task);
    await _taskDBStorage.updateObject(task.toMap(branchID));
  }

  //Удаление задачи
  Future<void> deleteTask(String branchID, String taskID) async {
    await _taskDBStorage.deleteObject(_innerTaskWrapper.getTask(branchID, taskID).id);
    _innerTaskWrapper.deleteTask(branchID, taskID);
  }

  //Получение внутренней задачи из кэша
  InnerTask getInnerTask(String branchID, String taskID, String innerTaskID){
    return _innerTaskWrapper.getInnerTask(branchID, taskID, innerTaskID);
  }

}