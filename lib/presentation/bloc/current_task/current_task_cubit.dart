import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';
import 'package:share/share.dart';


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
  Future<void> getTask() async {
    emit(CurrentTaskLoadingState());
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Обновление задачи (колбэк)
  Future<void> updateTask() async {
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Изменение состояние завершенности внутренней задачи
  Future<void> toggleInnerTask(String innerTaskID) async {
    await _innerTaskInteractor.toggleInnerTask(currentBranchID, currentTaskID, innerTaskID);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Создание внутренней задачи
  Future<void> createNewInnerTask(String innerTaskName) async {
    await _innerTaskInteractor.createNewInnerTask(currentBranchID, currentTaskID, innerTaskName);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Удаление внутренней задачи
  Future<void> deleteInnerTask(String innerTaskID) async {
    await _innerTaskInteractor.deleteInnerTask(currentBranchID, currentTaskID, innerTaskID);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование текста внутренней задачи
  Future<void> editInnerTaskName(String innerTaskID, String newName) async {
    await _innerTaskInteractor.editInnerTaskName(currentBranchID, currentTaskID, innerTaskID, newName);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Удаление задачи
  Future<void> deleteTask() async {
    await _innerTaskInteractor.deleteTask(currentBranchID, currentTaskID);
  }

  //Редактирование текста задачи
  Future<void> editTaskName(String newTaskName) async {
    await _innerTaskInteractor.editTaskName(currentBranchID, currentTaskID, newTaskName);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование уведомления задачи
  Future<void> editNotificationTime(int notificationTime) async {
    await _innerTaskInteractor.editNotificationTime(currentBranchID, currentTaskID, notificationTime);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование даты завершения задачи
  Future<void> editDateToComplete(int dateToComplete) async {
    await _innerTaskInteractor.editDateToComplete(currentBranchID, currentTaskID, dateToComplete);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование состояния завершенности задачи
  Future<void> toggleTaskComplete() async {
    await _innerTaskInteractor.toggleTaskComplete(currentBranchID, currentTaskID);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Редактирование текста заметок по задаче
  Future<void> editDescription(String newDescription) async {
    await _innerTaskInteractor.editDescription(currentBranchID, currentTaskID, newDescription);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Добавление новой картинки в галерею
  Future<void> addImage(String newImagePath) async {
    await _innerTaskInteractor.addImage(currentBranchID, currentTaskID, newImagePath);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Удаление картинки из галереи
  Future<void> deleteImage(String imagePath) async {
    await _innerTaskInteractor.deleteImage(currentBranchID, currentTaskID, imagePath);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Изменение выбранной картинки
  Future<void> selectImage(String newImage) async {
    await _innerTaskInteractor.selectImage(currentBranchID, currentTaskID, newImage);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Изменение избранности задачи
  Future<void> toggleTaskFavor() async {
    await _innerTaskInteractor.toggleTaskFavor(currentBranchID, currentTaskID);
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    emit(CurrentTaskInUsageState(task: task));
  }

  //Поделиться задачей
  Future<void> shareFile(RenderBox box) async {
    final task = await _innerTaskInteractor.getTask(currentBranchID, currentTaskID);
    String tasksToComplete = "";

    if (task.innerTasks.isNotEmpty){
      for (int i = 0; i<task.innerTasks.length; i++){
        if (!task.innerTasks.values.elementAt(i).isDone)
          tasksToComplete += "${task.innerTasks.values.elementAt(i).title}\n";
      }
    }

    if (task.selectedImage != null && task.selectedImage != "")
      Share.shareFiles(
        [task.selectedImage],
        text: tasksToComplete == "" ?
        '${task.title}\n'
            'Все задачи выполнены!'
            : '${task.title}\n'
            'Осталось сделать: \n'
            '$tasksToComplete',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    else
      Share.share(
        tasksToComplete == "" ?
        '${task.title}\n'
            'Все задачи выполнены!'
            : '${task.title}\n'
            'Осталось сделать: \n'
            '$tasksToComplete',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
  }

}