
import 'dart:io';

import 'package:flutter_internship_v2/data/database/db_wrappers/innertask_db_wrapper.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/innertask_repository.dart';
import 'package:flutter_internship_v2/data/storage/innertask_wrapper.dart';
import 'package:flutter_internship_v2/domain/notification/notification_helper.dart';
import 'package:uuid/uuid.dart';

class InnerTaskInteractor {

  InnerTaskRepository _innerTaskRepository = InnerTaskRepository(
    InnerTaskDBStorage(),
    TaskDBStorage(),
    LocalStorageInnerTaskWrapper(),
  );

  //Получение задачи из кэша
  Task getTask(String branchID, String taskID) {
    return _innerTaskRepository.getTask(branchID, taskID);
  }

  //Создание новой внутренней задачи
  Future<void> createNewInnerTask(String branchID, String taskID, String innerTaskName) async {
    await _innerTaskRepository.createNewInnerTask(
      branchID,
      taskID,
      InnerTask(
        Uuid().v4(),
        innerTaskName,
      )
    );
  }

  //Удаление внутренней задачи
  Future<void> deleteInnerTask(String branchID, String taskID, String innerTaskID) async {
    await _innerTaskRepository.deleteInnerTask(branchID, taskID, innerTaskID);
  }

  //Изменение состояния завершенности внутренней задачи
  Future<void> toggleInnerTask(String branchID, String taskID, String innerTaskID) async {
    final innerTask = _innerTaskRepository.getInnerTask(branchID, taskID, innerTaskID);
    await _innerTaskRepository.editInnerTask(branchID, taskID, innerTaskID, innerTask.copyWith(isDone: !innerTask.isDone));
  }

  //Редактирование текста внутренней задачи
  Future<void> editInnerTaskName(String branchID, String taskID, String innerTaskID, String newName) async {
    final innerTask = _innerTaskRepository.getInnerTask(branchID, taskID, innerTaskID);
    await _innerTaskRepository.editInnerTask(branchID, taskID, innerTaskID, innerTask.copyWith(title: newName));
  }

  //Удаление задачи
  Future<void> deleteTask(String branchID, String taskID) async {
    await NotificationHelper.cancelNotification(_innerTaskRepository.getTask(branchID, taskID));
    await _innerTaskRepository.deleteTask(branchID, taskID);
  }

  //Изменение текста задачи
  Future<void> editTaskName(String branchID, String taskID, String newTaskName) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    await _innerTaskRepository.editTask(branchID, task.copyWith(title: newTaskName));
  }

  //Изменение текста заметок по задаче
  Future<void> editDescription(String branchID, String taskID, String newDescription) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    await _innerTaskRepository.editTask(branchID, task.copyWith(description: newDescription));
  }

  //Изменение даты выполнения задачи
  Future<void> editDateToComplete(String branchID, String taskID, int dateToComplete) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    await _innerTaskRepository.editTask(branchID, task.copyWith(dateToComplete: dateToComplete));
  }

  //Изменение даты уведомления
  Future<void> editNotificationTime(String branchID, String taskID, int notificationTime) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    final newTask = (await _innerTaskRepository.getTask(branchID, taskID)).copyWith(notificationTime: notificationTime);
    await _innerTaskRepository.editTask(branchID, newTask);
    if (task.notificationTime != notificationTime){
      if (notificationTime == 0){
        await NotificationHelper.cancelNotification(newTask);
      } else {
        await NotificationHelper.cancelNotification(newTask);
        await NotificationHelper.scheduleNotification(newTask);
      }
    }
  }

  //Изменение состояния завершенности задачи
  Future<void> toggleTaskComplete(String branchID, String taskID) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    await _innerTaskRepository.editTask(branchID, task.copyWith(isDone: !task.isDone));
  }

  //Изменение избранности задачи
  Future<void> toggleTaskFavor(String branchID, String taskID) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    await _innerTaskRepository.editTask(branchID, task.copyWith(favor: !task.favor));
  }


  //Добавление картинки в галерею
  Future<void> addImage(String branchID, String taskID, imagePath) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    final imagesList = task.imagesPath;
    if (!imagesList.contains(imagePath)) {
      imagesList.add(imagePath);
      await _innerTaskRepository.editTask(
          branchID, task.copyWith(imagesPath: imagesList));
    }
  }

  //Удаление картинки из галереи
  Future<void> deleteImage(String branchID, String taskID, imagePath) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    final imagesList = task.imagesPath;
    imagesList.remove(imagePath);
    File(imagePath).delete();
    if (imagePath == task.selectedImage)
      await _innerTaskRepository.editTask(branchID, task.copyWith(imagesPath: imagesList, selectedImage: ""));
    else
      await _innerTaskRepository.editTask(branchID, task.copyWith(imagesPath: imagesList));
  }

  //Изменение выбранной картинки
  Future<void> selectImage(String branchID, String taskID, newImage) async {
    final Task task = await _innerTaskRepository.getTask(branchID, taskID);
    await _innerTaskRepository.editTask(branchID, task.copyWith(selectedImage: newImage));
  }

}