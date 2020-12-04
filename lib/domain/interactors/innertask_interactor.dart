
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/innertask_repository.dart';
import 'package:flutter_internship_v2/domain/notification/notification_helper.dart';
import 'package:uuid/uuid.dart';

class InnerTaskInteractor {

  final InnerTaskRepository innerTaskRepository;

  InnerTaskInteractor({this.innerTaskRepository});


  //Получение задачи из кэша
  Task getTask(String branchID, String taskID) {
    return innerTaskRepository.getTask(branchID, taskID);
  }

  //Создание новой внутренней задачи
  Future<void> createNewInnerTask(String branchID, String taskID, String innerTaskName) async {
    await innerTaskRepository.createNewInnerTask(
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
    await innerTaskRepository.deleteInnerTask(branchID, taskID, innerTaskID);
  }

  //Редактирование внутренней задачи
  Future<void> editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) async {
    await innerTaskRepository.editInnerTask(branchID, taskID, innerTaskID, innerTask);
  }

  //Редактирование задачи и создание, при необходимости, уведомления
  Future<void> editTask(String branchID, Task task) async {
    if (innerTaskRepository.getTask(branchID, task.id).notificationTime != task.notificationTime){
      if (task.notificationTime == 0){
        await NotificationHelper.cancelNotification(task);
      } else {
        await NotificationHelper.cancelNotification(task);
        await NotificationHelper.scheduleNotification(task);
      }
    }
    await innerTaskRepository.editTask(branchID, task);
  }

  //Удаление задачи
  Future<void> deleteTask(String branchID, String taskID) async {
    await innerTaskRepository.deleteTask(branchID, taskID);
    await NotificationHelper.cancelNotification(innerTaskRepository.getTask(branchID, taskID));
  }

}