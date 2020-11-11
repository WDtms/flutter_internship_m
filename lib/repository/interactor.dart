
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/repository/repository.dart';

abstract class Interactor{

  //Начало TaskCubit

  Future<List<TaskModel>> getTaskList(String id);

  Future<List<TaskModel>> createNewTask(String id, String value);

  Future<List<TaskModel>> toggleTaskComplete(String id, int index);

  Future<List<TaskModel>> deleteTask(String id, int index);

  Future<List<TaskModel>> deleteAllCompletedTasks(String id);

  //Конец TaskCubit

  //Начало CurrentTaskCubit

  Future<TaskModel> getTask(String id, int index);

  Future<TaskModel> toggleInnerTaskComplete(String id, int index, int innerIndex);

  Future<TaskModel> deleteInnerTask(String id, int index, int innerIndex);

  Future<TaskModel> createNewInnerTask(String id, int index, String value);

  Future<TaskModel> editTaskName(String id, int index, String value);

  Future<TaskModel> addDateToComplete(String id, int index, DateTime dateTime);

  //Конец CurrentTaskCubit

}

class TaskInteractor implements Interactor{

  final Repository repository;

  TaskInteractor({this.repository});

  static TaskInteractor _instance;

  static TaskInteractor getInstance({repository}) {
    if(_instance == null) {
      _instance = TaskInteractor(repository: repository);
      return _instance;
    }
    return _instance;
  }

  Future<TaskModel> getTask(String id, int index) async {
    return repository.getTask(id, index);
  }

  Future<TaskModel> addDateToComplete(String id, int index, DateTime dateTime) async {
    return repository.addDateToComplete(id, index, dateTime);
  }

  Future<TaskModel> editTaskName(String id, int index, String value) async {
    return repository.editTaskName(id, index, value);
  }

  Future<TaskModel> createNewInnerTask(String id, int index, String value) async {
    return repository.createNewInnerTask(id, index, value);
  }

  Future<TaskModel> deleteInnerTask(String id, int index, int innerIndex) async {
    return repository.deleteInnerTask(id, index, innerIndex);
  }

  Future<TaskModel> toggleInnerTaskComplete(String id, int index, int innerIndex) async {
    return repository.toggleInnerTaskComplete(id, index, innerIndex);
  }

  @override
  Future<List<TaskModel>> getTaskList(String id) async {
    return repository.getTaskList(id);
  }

  @override
  Future<List<TaskModel>> createNewTask(String id, String value) async {
    return repository.createNewTask(id, value);
  }

  Future<List<TaskModel>> toggleTaskComplete(String id, int index) async {
    return repository.toggleTaskComplete(id, index);
  }

  Future<List<TaskModel>> deleteTask(String id, int index) async {
    return repository.deleteTask(id, index);
  }

  Future<List<TaskModel>> deleteAllCompletedTasks(String id) async {
    return repository.deleteAllCompletedTasks(id);
  }


}