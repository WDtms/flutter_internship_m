
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
  List<TaskCardInfo> getTaskList(String branchID) {
    return _getAllTasksInfo(branchID);
  }

  //Создание новой задачи и, при необходимости, создание уведомления
  Future<void> createNewTask(String branchID, String taskName, DateTime dateToComplete, DateTime notificationTime, int importance) async {
    Task task = Task(
      Uuid().v4(),
      taskName,
      {},
      [],
      DateTime.now().millisecondsSinceEpoch,
      importance,
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

  //Сбор всей необходимой для отображения информации на странице списка задач
  List<TaskCardInfo> _getAllTasksInfo(String branchID) {
    List<TaskCardInfo> allInfo = List<TaskCardInfo>();
    final taskList = _taskRepository.getTaskList(branchID);
    for (int i = 0; i<taskList.length; i++){
      final oneTaskInfo = _countCompletedInnerTasks(taskList.values.elementAt(i));
      allInfo.add(TaskCardInfo(
        taskList.values.elementAt(i).id,
        taskList.values.elementAt(i).title,
        oneTaskInfo.keys.first,
        oneTaskInfo.values.first,
        taskList.values.elementAt(i).isDone,
        taskList.values.elementAt(i).dateOfCreation,
        taskList.values.elementAt(i).importance,
      ));
    }
    return allInfo;
  }

  //Высчитывание количества завершенных внутренних задач
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