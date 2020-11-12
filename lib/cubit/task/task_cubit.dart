import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final Interactor _taskInteractor;

  TaskCubit(this._taskInteractor) : super(TaskInitialState());

  Future<void> getTasks(String id) async {
    emit(TaskLoadingState());
    final taskList = await _taskInteractor.getTaskList(id);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> createNewTask(String id, String value) async {
    final taskList = await _taskInteractor.createNewTask(id, value);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> toggleTaskComplete(String id, int index) async {
    final taskList = await _taskInteractor.toggleTaskComplete(id, index);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> deleteTask(String id, int index) async {
    final taskList = await _taskInteractor.deleteTask(id, index);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> deleteAllCompletedTasks(String id) async {
    final taskList = await _taskInteractor.deleteAllCompletedTasks(id);
    emit(TaskInUsageState(taskList: taskList));
  }

  Future<void> updateTaskList(String id) async {
    final taskList = await _taskInteractor.getTaskList(id);
    emit(TaskInUsageState(taskList: taskList));
  }
}