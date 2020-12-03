
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/repository/repository.dart';

abstract class Interactor{

  Future<void> createNewBranch();

  Future<Map<Map<String, String>, Map<dynamic, dynamic>>> getBranchesInfo();

  //Начало TaskCubit

  Future<List<TaskModel>> getTaskList(String id);

  Future<List<TaskModel>> createNewTask(String id, String value, DateTime dateTimeToComplete);

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

  //Начало ThemeCubit

  Future<Map<Color, Color>> getBranchTheme(String id);

  Future<Map<Color, Color>> setBranchTheme(String id, Map<Color, Color> theme);

  //Конец ThemeCubit

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

  Future<void> createNewBranch() async{
    repository.createNewBranch();
  }

  Future<Map<Map<String, String>, Map<dynamic, dynamic>>> getBranchesInfo() async {
    return repository.getBranchesInfo();
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

  Future<TaskModel> toggleTaskCompleteFromCurrentTaskPage(String id, int index) async {
    return repository.toggleTaskCompleteFromCurrentTaskPage(id, index);
  }

  @override
  Future<List<TaskModel>> getTaskList(String id) async {
    return repository.getTaskList(id);
  }

  @override
  Future<List<TaskModel>> createNewTask(String id, String value, DateTime dateToComplete) async {
    return repository.createNewTask(id, value, dateToComplete);
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

  Future<Map<Color, Color>> getBranchTheme(String id) async {
    return repository.getBranchTheme(id);
  }

  Future<Map<Color, Color>> setBranchTheme(String id, Map<Color, Color> theme) async {
    return repository.setBranchTheme(id, theme);
  }


}