import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';


part 'current_task_state.dart';

class CurrentTaskCubit extends Cubit<CurrentTaskState>{
  final InnerTaskInteractor _innerTaskInteractor;

  CurrentTaskCubit(this._innerTaskInteractor) : super(CurrentTaskInitialState());

  String currentBranchID;
  String currentTaskID;

  setCurrentIDs(String branchID, String taskID){
    currentBranchID = branchID;
    currentTaskID = taskID;
  }

  Future<void> getTask() async {
    emit(CurrentTaskLoadingState());
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editInnerTask(String innerTaskID, InnerTask innerTask) async {
    await _innerTaskInteractor.editInnerTask(currentBranchID, currentTaskID, innerTaskID, innerTask);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> editTask(Task changedTask) async {
    await _innerTaskInteractor.editTask(currentBranchID, changedTask);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> createNewInnerTask(String innerTaskName) async {
    await _innerTaskInteractor.createNewInnerTask(currentBranchID, currentTaskID, innerTaskName);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteInnerTask(String innerTaskID) async {
    await _innerTaskInteractor.deleteInnerTask(currentBranchID, currentTaskID, innerTaskID);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  Future<void> deleteTask() async {
    await _innerTaskInteractor.deleteTask(currentBranchID, currentTaskID);
  }

}