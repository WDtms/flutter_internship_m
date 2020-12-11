import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';
import 'package:flutter_internship_v2/domain/models/task_card_info.dart';
import 'package:flutter_internship_v2/presentation/models/filter_parameters.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final TaskInteractor _taskInteractor;
  final String _currentBranchID;

  TaskCubit(this._taskInteractor, this._currentBranchID) : super(TaskInitialState());

  //Флаг, сигнализирующий о том, включена ли фильтрация завершенных задач
  bool _isHidden = false;
  //
  //Флаг, сигнализирующий о том, включена ли фильтрация по свежести
  bool _isNewest = false;
  //
  //Флаг, сигнализирующий о том, включена ли фильтрация по важности
  bool _isImportant = false;
  //
  //Флаг, сигнализирующий о том, включена ли фильтрация по избранности
  bool _isFavor = false;

  //Смена флага фильтрации "свежести" задач на обратное ему значение
  void toggleIsNewest() async {
    _isNewest = !_isNewest;
    await updateTaskList();
  }

  //Смена флага фильтрации важности задач на обратное ему значение
  void toggleImportance() async {
    _isImportant = !_isImportant;
    await updateTaskList();
  }

  //Смена флага "скрыть завершенные" на обратное ему значению
  void toggleIsHidden() async {
    _isHidden = !_isHidden;
    await updateTaskList();
  }

  //Смена флага избранности на обратное ему значение
  void toggleIsFavor() async {
    _isFavor = !_isFavor;
    await updateTaskList();
  }

  //Метод для проверки, включен ли какой-либо фильтр
  List <TaskCardInfo> _checkIfIsHidden(List<TaskCardInfo> taskList){
    if (_isHidden){
      taskList.removeWhere((taskCard) => taskCard.isDone);
    }
    if (_isNewest){
      taskList.sort((TaskCardInfo a, TaskCardInfo b) => a.dateOfCreation.compareTo(b.dateOfCreation));
      taskList = List.from(taskList.reversed);
    }
    if (_isImportant){
      taskList.sort((TaskCardInfo a, TaskCardInfo b) => a.importance.compareTo(b.importance));
      taskList = List.from(taskList.reversed);
    }
    if (_isFavor){
      taskList.removeWhere((taskCardInfo) => !taskCardInfo.favor);
    }
    return taskList;
  }

  //Получение списка задач
  Future<void> getTasks() async {
    emit(TaskLoadingState());
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      filterParameters: FilterParameters(
        _isHidden,
        _isNewest,
        _isImportant,
        _isFavor,
      )
    ));
  }

  //Создание новой задачи
  Future<void> createNewTask(DateTime dateToComplete, DateTime notificationTime, String taskName, int importance, bool favor) async {
    await _taskInteractor.createNewTask(_currentBranchID, taskName, dateToComplete, notificationTime, importance, favor);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
        taskList: _checkIfIsHidden(taskList),
        filterParameters: FilterParameters(
          _isHidden,
          _isNewest,
          _isImportant,
          _isFavor,
        )
    ));
  }

  //Удаление задачи
  Future<void> deleteTask(String taskID) async {
    await _taskInteractor.deleteTask(_currentBranchID, taskID);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
        filterParameters: FilterParameters(
          _isHidden,
          _isNewest,
          _isImportant,
          _isFavor,
        )
    ));
  }

  //Удаление всех завершенных задач
  Future<void> deleteAllCompletedTasks() async {
    await _taskInteractor.deleteAllCompletedTasks(_currentBranchID);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
      filterParameters: FilterParameters(
        _isHidden,
        _isNewest,
        _isImportant,
        _isFavor,
      ),
    ));
  }

  //Обновление задач (колбек)
  Future<void> updateTaskList() async {
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
        filterParameters: FilterParameters(
          _isHidden,
          _isNewest,
          _isImportant,
          _isFavor,
        )
    ));
  }

  //Изменение состояния завершенности задачи
  Future<void> toggleTaskComplete(String taskID) async {
    await _taskInteractor.toggleTaskComplete(_currentBranchID, taskID);
    final taskList = await _taskInteractor.getTaskList(_currentBranchID);
    emit(TaskInUsageState(
      taskList: _checkIfIsHidden(taskList),
        filterParameters: FilterParameters(
          _isHidden,
          _isNewest,
          _isImportant,
          _isFavor,
        )
    ));
  }
}