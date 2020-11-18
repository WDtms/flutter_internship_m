import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'current_task_state.dart';

class CurrentTaskCubit extends Cubit<CurrentTaskState>{
  final TaskInteractor _taskInteractor;

  CurrentTaskCubit(this._taskInteractor) : super(CurrentTaskInitialState());

  Future<void> getTask(String branchID, int indexTask) async {
    emit(CurrentTaskLoadingState());
    final task = await _taskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    await _taskInteractor.editInnerTask(branchID, indexTask, innerTaskIndex, innerTask);
    final task = await _taskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editTask(String branchID, int indexTask, Task changedTask) async {
    await _taskInteractor.editTask(branchID, indexTask, changedTask);
    final task = await _taskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> createNewInnerTask(String branchID, int indexTask, InnerTask innerTask) async {
    await _taskInteractor.createNewInnerTask(branchID, indexTask, innerTask);
    final task = await _taskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteInnerTask(String branchID, int indexTask, int indexInnerTask) async {
    await _taskInteractor.deleteInnerTask(branchID, indexTask, indexInnerTask);
    final task = await _taskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteTask(String branchID, int indexTask) async {
    await _taskInteractor.deleteTask(branchID, indexTask);
  }

}