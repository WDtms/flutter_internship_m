import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';
import 'package:flutter_internship_v2/domain/models/task_card_info.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final TaskInteractor _taskInteractor;
  final String _currentBranchID;

  TaskCubit(this._taskInteractor, this._currentBranchID) : super(TaskInitialState());

  //Флаг, сигнализирующий о том, запущена ли фильтрация завершенных задач
  bool _isHidden = false;

  //Смена флага на обратное ему значению
  void toggleIsHidden() async {
    _isHidden = !_isHidden;
    await updateTaskList();
  }

  //Метод для проверки, включен ли фильтр
  Map<String, TaskCardInfo> _checkIfIsHidden(Map<String, TaskCardInfo> taskList){
    if (_isHidden){
      taskList.removeWhere((id, taskCard) => taskCard.isDone);
      return taskList;
    }
    return taskList;
  }

  //Получение списка задач
  Future<void> getTasks() async {
    emit(TaskLoadingState());
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Создание новой задачи
  Future<void> createNewTask(DateTime dateToComplete, DateTime notificationTime, String taskName) async {
    await _taskInteractor.createNewTask(_currentBranchID, taskName, dateToComplete, notificationTime);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Удаление задачи
  Future<void> deleteTask(String taskID) async {
    await _taskInteractor.deleteTask(_currentBranchID, taskID);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Удаление всех завершенных задач
  Future<void> deleteAllCompletedTasks() async {
    await _taskInteractor.deleteAllCompletedTasks(_currentBranchID);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Обновление задач (колбек)
  Future<void> updateTaskList() async {
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Изменение состояния завершенности задачи
  Future<void> toggleTaskComplete(String taskID) async {
    await _taskInteractor.toggleTaskComplete(_currentBranchID, taskID);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }
}