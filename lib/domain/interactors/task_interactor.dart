
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/task_repository.dart';
import 'package:flutter_internship_v2/data/storage/task_wrapper.dart';
import 'package:flutter_internship_v2/domain/models/task_card_info.dart';
import 'package:flutter_internship_v2/domain/notification/notification_helper.dart';
import 'package:uuid/uuid.dart';

class TaskInteractor {

  final TaskRepository _taskRepository = TaskRepository(TaskDBStorage(), LocalStorageTaskWrapper());

  //Получение списка задач из кэша
  Map<String, TaskCardInfo> getTaskList(String branchID) {
    return _getAllTasksInfo(branchID);
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
    await _taskRepository.createNewTask(
        branchID,
        task,
    );
    if (notificationTime != null) {
      await NotificationHelper.scheduleNotification(task);
    }
  }

  //Удаление задачи и ее уведомления
  Future<void> deleteTask(String branchID, String taskID) async {
    await NotificationHelper.cancelNotification(_taskRepository.getTask(branchID, taskID));
    await _taskRepository.deleteTask(branchID, taskID);
  }

  /*
  Удаление всех задач и формирования списка их айдишников для последующего
  удаления всех внутренних задач, привязанных к этой
   */
  Future<void> deleteAllCompletedTasks(String branchID) async {
    final taskList = _taskRepository.getTaskList(branchID);
    List<String> taskIDList = List<String>();
    taskList.forEach((key, value) {
      if (value.isDone)
        taskIDList.add(key);
    });
    await _taskRepository.deleteAllCompletedTasks(branchID, taskIDList);
  }

  //Изменение состояния завершенности задачи
  Future<void> toggleTaskComplete(String branchID, String taskID) async {
    final Task task = await _taskRepository.getTask(branchID, taskID);
    await _taskRepository.editTask(branchID, task.copyWith(isDone: !task.isDone));
  }

  Map<String, TaskCardInfo> _getAllTasksInfo(String branchID) {
    Map<String, TaskCardInfo> allInfo = Map<String, TaskCardInfo>();
    final taskList = _taskRepository.getTaskList(branchID);
    for (int i = 0; i<taskList.length; i++){
      final oneTaskInfo = _countCompletedInnerTasks(taskList.values.elementAt(i));
      allInfo[taskList.keys.elementAt(i)] = TaskCardInfo(
        taskList.values.elementAt(i).id,
        taskList.values.elementAt(i).title,
        oneTaskInfo.keys.first,
        oneTaskInfo.values.first,
        taskList.values.elementAt(i).isDone,
      );
    }
    return allInfo;
  }

  Map<int, int> _countCompletedInnerTasks(Task task) {
    int countCompleted = 0;
    int countAll = 0;
    for (int i = 0; i<task.innerTasks.length; i++){
      if (task.innerTasks.values.elementAt(i).isDone)
        countCompleted++;
      countAll++;
    }
    return {countCompleted : countAll};
  }
}