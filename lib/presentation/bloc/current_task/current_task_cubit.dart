import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';


part 'current_task_state.dart';

class CurrentTaskCubit extends Cubit<CurrentTaskState>{
  final InnerTaskInteractor _innerTaskInteractor;

  CurrentTaskCubit(this._innerTaskInteractor) : super(CurrentTaskInitialState());

  Future<void> getTask(String branchID, int indexTask) async {
    emit(CurrentTaskLoadingState());
    final task = await _innerTaskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    await _innerTaskInteractor.editInnerTask(branchID, indexTask, innerTaskIndex, innerTask);
    final task = await _innerTaskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editTask(String branchID, int indexTask, Task changedTask) async {
    await _innerTaskInteractor.editTask(branchID, indexTask, changedTask);
    final task = await _innerTaskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> createNewInnerTask(String branchID, int indexTask, String innerTaskName) async {
    await _innerTaskInteractor.createNewInnerTask(branchID, indexTask, innerTaskName);
    final task = await _innerTaskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteInnerTask(String branchID, int indexTask, int indexInnerTask) async {
    await _innerTaskInteractor.deleteInnerTask(branchID, indexTask, indexInnerTask);
    final task = await _innerTaskInteractor.getTask(branchID, indexTask);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteTask(String branchID, int indexTask) async {
    await _innerTaskInteractor.deleteTask(branchID, indexTask);
  }

}