import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final TaskInteractor _taskInteractor;

  TaskCubit(this._taskInteractor) : super(TaskInitialState());

  Future<void> getTasks(String branchID) async {
    emit(TaskLoadingState());
    final taskList = await _taskInteractor.getTaskList(branchID);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> editTask(String branchID, int indexTask, Task task) async {
    await _taskInteractor.editTask(branchID, indexTask, task);
    final taskList = await _taskInteractor.getTaskList(branchID);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> createNewTask(String branchID, DateTime dateToComplete, DateTime notificationTime, String taskName) async {
    await _taskInteractor.createNewTask(branchID, taskName, dateToComplete, notificationTime);
    final taskList = await _taskInteractor.getTaskList(branchID);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> deleteTask(String branchID, int indexTask) async {
    await _taskInteractor.deleteTask(branchID, indexTask);
    final taskList = await _taskInteractor.getTaskList(branchID);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    await _taskInteractor.deleteAllCompletedTasks(branchID);
    final taskList = await _taskInteractor.getTaskList(branchID);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> updateTaskList(String branchID) async {
    final taskList = await _taskInteractor.getTaskList(branchID);
    emit(TaskInUsageState(taskList: taskList));
  }
}