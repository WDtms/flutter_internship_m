import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final TaskInteractor taskInteractor;
  final String currentBranchID;

  TaskCubit({this.taskInteractor, this.currentBranchID}) : super(TaskInitialState());

  //Флаг, сигнализирующий о том, запущена ли фильтрация завершенных задач
  bool _isHidden = false;

  //Смена флага на обратное ему значению
  void toggleIsHidden() async {
    _isHidden = !_isHidden;
    await updateTaskList();
  }

  //Метод для проверки, включен ли фильтр
  Map<String, Task> _checkIfIsHidden(Map<String, Task> taskList){
    if (_isHidden){
      taskList.removeWhere((taskID, task) => task.isDone);
      return taskList;
    }
    return taskList;
  }

  //Получение списка задач
  Future<void> getTasks() async {
    emit(TaskLoadingState());
    final taskList = await taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Редактирование задачи
  Future<void> editTask(String taskID, Task task) async {
    await taskInteractor.editTask(currentBranchID, task);
    final taskList = await taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Создание новой задачи
  Future<void> createNewTask(DateTime dateToComplete, DateTime notificationTime, String taskName) async {
    await taskInteractor.createNewTask(currentBranchID, taskName, dateToComplete, notificationTime);
    final taskList = await taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Удаление задачи
  Future<void> deleteTask(String taskID) async {
    await taskInteractor.deleteTask(currentBranchID, taskID);
    final taskList = await taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Удаление всех завершенных задач
  Future<void> deleteAllCompletedTasks() async {
    await taskInteractor.deleteAllCompletedTasks(currentBranchID);
    final taskList = await taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }

  //Обновление задач (колбек)
  Future<void> updateTaskList() async {
    final taskList = await taskInteractor.getTaskList(currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      isHidden: _isHidden,
    ));
  }
}