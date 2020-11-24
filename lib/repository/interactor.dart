
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/all_branch_info.dart';
import 'package:flutter_internship_v2/models/one_branch_info.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/repository/repository.dart';

abstract class Interactor{

  Future<void> createNewBranch();

  Future<void> initiateBranches();

  Future<List<OneBranchInfo>> getAllBranchesInfo();

  Future<AllBranchesInfo> getAllBranchesTasksInfo();

  //Начало TaskCubit

  Future<List<Task>> getTaskList(String branchID);

  Future<void> editTask(String branchID, int indexTask, Task task);

  Future<void> createNewTask(String branchID, Task task);

  Future<void> deleteTask(String branchID, int indexTask);

  Future<void> deleteAllCompletedTasks(String id);

  //Конец TaskCubit

  //Начало CurrentTaskCubit

  Future<Task> getTask(String branchID, int indexTask);

  Future<void> editInnerTask(String branchID, int indexTask, int indexInnerTask, InnerTask innerTask);

  Future<void> deleteInnerTask(String branchID, int indexTask, int innerTaskIndex);

  Future<void> createNewInnerTask(String branchID, int index, InnerTask innerTask);

  //Конец CurrentTaskCubit

  //Начало ThemeCubit

  Future<Map<Color, Color>> getBranchTheme(String branchID);

  Future<void> changeTheme(String branchID, Map<Color, Color> theme);

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

  //Работа в BranchCubit

  @override
  Future<void> initiateBranches() async {
    await repository.initializeBranches();
  }

  @override
  Future<void> createNewBranch() async{
    await repository.createNewBranch();
  }

  @override
  Future<List<OneBranchInfo>> getAllBranchesInfo() async {
    return repository.getAllBranchesInfo();
  }

  @override
  Future<AllBranchesInfo> getAllBranchesTasksInfo() async {
    return repository.getAllBranchesTasksInfo();
  }

  //Работа в TaskCubit

  @override
  Future<List<Task>> getTaskList(String branchID) async {
    return repository.getTaskList(branchID);
  }

  @override
  Future<Map<Color, Color>> getBranchTheme(String branchID) async {
    return repository.getBranchTheme(branchID);
  }

  @override
  Future<void> editTask(String branchID, int indexTask, Task task) async {
    await repository.editTask(branchID, indexTask, task);
  }

  @override
  Future<void> createNewTask(String branchID, Task task) async {
    await repository.createNewTask(branchID, task);
  }

  @override
  Future<void> deleteTask(String branchID, int indexTask) async {
    await repository.deleteTask(branchID, indexTask);
  }

  @override
  Future<void> deleteAllCompletedTasks(String branchID) async {
    await repository.deleteAllCompletedTasks(branchID);
  }

  @override
  Future<void> changeTheme(String branchID, Map<Color, Color> theme) async {
   await repository.changeTheme(branchID, theme);
  }

  //Работа с CurrentTaskCubit

  @override
  Future<Task> getTask(String branchID, int indexTask) async {
    return repository.getTask(branchID, indexTask);
  }

  @override
  Future<void> createNewInnerTask(String branchID, int indexTask, InnerTask innerTask) async {
    await repository.createNewInnerTask(branchID, indexTask, innerTask);
  }

  @override
  Future<void> deleteInnerTask(String branchID, int indexTask, int indexInnerTask) async {
    await repository.deleteInnerTask(branchID, indexTask, indexInnerTask);
  }

  @override
  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    await repository.editInnerTask(branchID, indexTask, innerTaskIndex, innerTask);
  }

}