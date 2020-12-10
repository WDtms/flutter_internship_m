
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/task_repository.dart';
import 'package:flutter_internship_v2/data/storage/task_wrapper.dart';
import 'package:flutter_internship_v2/domain/notification/notification_helper.dart';
import 'package:uuid/uuid.dart';

class TaskInteractor {

  final TaskRepository taskRepository = TaskRepository(taskDBStorage: TaskDBStorage(), taskWrapper: LocalStorageTaskWrapper());

  //Получение списка задач из кэша
  Map<String, Task> getTaskList(String branchID) {
    return taskRepository.getTaskList(branchID);
  }

  //Редактирование задачи
  Future<void> editTask(String branchID, Task task) async {
    await taskRepository.editTask(branchID, task);
  }

  //Создание новой задачи и, при необходимости, создание уведомления
  Future<void> createNewTask(String branchID, String taskName, DateTime dateToComplete, DateTime notificationTime) async {
    Task task = Task(
      Uuid().v4(),
      taskName,
      {},
      [],
      DateTime.now().millisecondsSinceEpoch,
      dateToComplete: dateToComplete == null ? 0 : dateToComplete.millisecondsSinceEpoch,
      notificationTime: notificationTime == null ? 0 : notificationTime.millisecondsSinceEpoch,
    );
    await taskRepository.createNewTask(
        branchID,
        task,
    );
    if (notificationTime != null) {
      await NotificationHelper.scheduleNotification(task);
    }
  }

  //Удаление задачи и ее уведомления
  Future<void> deleteTask(String branchID, String taskID) async {
    await NotificationHelper.cancelNotification(taskRepository.getTask(branchID, taskID));
    await taskRepository.deleteTask(branchID, taskID);
  }

  /*
  Удаление всех задач и формирования списка их айдишников для последующего
  удаления всех внутренних задач, привязанных к этой
   */
  Future<void> deleteAllCompletedTasks(String branchID) async {
    final taskList = taskRepository.getTaskList(branchID);
    List<String> taskIDList = List<String>();
    taskList.forEach((key, value) {
      if (value.isDone)
        taskIDList.add(key);
    });
    await taskRepository.deleteAllCompletedTasks(branchID, taskIDList);
  }

}