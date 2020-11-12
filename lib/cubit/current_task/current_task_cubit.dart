import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'current_task_state.dart';

class CurrentTaskCubit extends Cubit<CurrentTaskState>{
  final TaskInteractor _taskInteractor;

  CurrentTaskCubit(this._taskInteractor) : super(CurrentTaskInitialState());

  Future<void> getTask(String id, int index) async {
    emit(CurrentTaskLoadingState());
    final task = await _taskInteractor.getTask(id, index);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> addDateToComplete(String id, int index, DateTime dateTime) async {
    final task = await _taskInteractor.addDateToComplete(id, index, dateTime);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editTaskName(String id, int index, String value) async {
    final task = await _taskInteractor.editTaskName(id, index, value);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> createNewInnerTask(String id, int index, String value) async {
    final task = await _taskInteractor.createNewInnerTask(id, index, value);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteInnerTask(String id, int index, int innerIndex) async {
    final task = await _taskInteractor.deleteInnerTask(id, index, innerIndex);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> toggleInnerTaskComplete(String id, int index, int innerIndex) async {
    final task = await _taskInteractor.toggleInnerTaskComplete(id, index, innerIndex);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> toggleTaskCompleteFromCurrentTaskPage(String id, int index) async {
    final task = await _taskInteractor.toggleTaskCompleteFromCurrentTaskPage(id, index);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteTask(String id, int index) async {
    await _taskInteractor.deleteTask(id, index);
  }

}