import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState>{
  final TaskRepository1 _taskRepository;

  TaskCubit(this._taskRepository) : super(TaskInitialState());

  Future<void> addDateToComplete(int index, DateTime dateTime) async {
    final _taskList = await _taskRepository.addDateToComplete(index, dateTime);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> editTaskName(int index, String value) async {
    final _taskList = await _taskRepository.editTaskName(index, value);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> createNewInnerTask(int index, String value) async {
    final _taskList = await _taskRepository.createNewInnerTask(index, value);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> deleteInnerTask(int index, int innerIndex) async {
    final _taskList = await _taskRepository.deleteInnerTask(index, innerIndex);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> toggleInnerTaskComplete(int index, int innerIndex) async {
    final _taskList = await _taskRepository.toggleInnerTaskComplete(index, innerIndex);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> getTasks() async {
    emit(TaskLoadingState());
    final _taskList = await _taskRepository.getTaskList();
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> createNewTask(String value) async {
    final _taskList = await _taskRepository.createNewTask(value);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> toggleTaskComplete(int index) async {
    final _taskList = await _taskRepository.toggleTaskComplete(index);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> deleteTask(int index) async {
    final _taskList = await _taskRepository.deleteTask(index);
    emit(TaskInUsageState(taskList: _taskList));
  }

  Future<void> deleteAllCompletedTasks() async {
    final _taskList = await _taskRepository.deleteAllCompletedTasks();
    emit(TaskInUsageState(taskList: _taskList));
  }
}