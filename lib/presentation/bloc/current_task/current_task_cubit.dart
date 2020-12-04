import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';


part 'current_task_state.dart';

class CurrentTaskCubit extends Cubit<CurrentTaskState>{

  final InnerTaskInteractor _innerTaskInteractor;

  //Поле, содержащее ID выбранной ветки
  final String currentBranchID;
  //
  //Поле, содержащее ID выбранной задачи
  final String currentTaskID;

  CurrentTaskCubit(this._innerTaskInteractor, this.currentBranchID, this.currentTaskID) : super(CurrentTaskInitialState());


  //Получение задачи
  void getTask() {
    emit(CurrentTaskLoadingState());
    final task = _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование внутренней задачи
  Future<void> editInnerTask(String innerTaskID, InnerTask innerTask) async {
    await _innerTaskInteractor.editInnerTask(currentBranchID, currentTaskID, innerTaskID, innerTask);
    final task = _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование задачи
  Future<void> editTask(Task changedTask) async {
    await _innerTaskInteractor.editTask(currentBranchID, changedTask);
    final task = _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Создание внутренней задачи
  Future<void> createNewInnerTask(String innerTaskName) async {
    await _innerTaskInteractor.createNewInnerTask(currentBranchID, currentTaskID, innerTaskName);
    final task = _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Удаление внутренней задачи
  Future<void> deleteInnerTask(String innerTaskID) async {
    await _innerTaskInteractor.deleteInnerTask(currentBranchID, currentTaskID, innerTaskID);
    final task = _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Удаление задачи
  Future<void> deleteTask() async {
    await _innerTaskInteractor.deleteTask(currentBranchID, currentTaskID);
  }

}