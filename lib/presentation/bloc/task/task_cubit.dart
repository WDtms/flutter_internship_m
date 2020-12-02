import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final TaskInteractor _taskInteractor;
  final String currentBranchID;

  TaskCubit(this._taskInteractor, {this.currentBranchID}) : super(TaskInitialState());

  bool _isHidden = false;

  toggleIsHidden() async {
    _isHidden = !_isHidden;
    await updateTaskList();
  }

  _checkIfIsHidden(Map<String, Task> taskList){
    if (_isHidden){
      taskList.removeWhere((taskID, task) => task.isDone);
      return taskList;
    }
    return taskList;
  }

  Future<void> getTasks() async {
    emit(TaskLoadingState());
    final taskList = await _taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  Future<void> editTask(String taskID, Task task) async {
    await _taskInteractor.editTask(currentBranchID, task);
    final taskList = await _taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  Future<void> createNewTask(DateTime dateToComplete, DateTime notificationTime, String taskName) async {
    await _taskInteractor.createNewTask(currentBranchID, taskName, dateToComplete, notificationTime);
    final taskList = await _taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  Future<void> deleteTask(String taskID) async {
    await _taskInteractor.deleteTask(currentBranchID, taskID);
    final taskList = await _taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  Future<void> deleteAllCompletedTasks() async {
    await _taskInteractor.deleteAllCompletedTasks(currentBranchID);
    final taskList = await _taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  Future<void> updateTaskList() async {
    final taskList = await _taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }
}