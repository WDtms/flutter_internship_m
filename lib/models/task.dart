
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/services/db_constants.dart';

class Task{

  String id;
  String title;
  bool isDone;
  DateTime dateOfCreation;
  DateTime dateToComplete;
  DateTime notificationTime;
  List<InnerTask> innerTasks;

  Task({this.id, this.title, this.isDone = false, this.innerTasks, this.dateOfCreation, this.dateToComplete, this.notificationTime});

  Map<String, dynamic> toMap(String branchID) {
    return {
      DBConstants.taskId : id,
      DBConstants.taskTitle: title,
      DBConstants.taskIsDone: isDone ? 1 : 0,
      DBConstants.branchId: branchID,
      DBConstants.taskDateOfCreation: dateOfCreation.millisecondsSinceEpoch,
      DBConstants.taskDateToComplete: dateToComplete == null ? 0 : dateToComplete.millisecondsSinceEpoch,
      DBConstants.taskNotificationTime: notificationTime == null ? 0 : notificationTime.millisecondsSinceEpoch,
    };
  }

  Task copyWith({
    String id,
    String title,
    bool isDone,
    DateTime dateOfCreation,
    DateTime dateToComplete,
    DateTime notificationTime,
    List<InnerTask> innerTasks,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      dateOfCreation: dateOfCreation ?? this.dateOfCreation,
      dateToComplete: dateToComplete ?? this.dateToComplete,
      notificationTime: notificationTime ?? this.notificationTime,
      innerTasks: innerTasks ?? this.innerTasks,
    );
  }

}