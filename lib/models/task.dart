
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/services/db_constants.dart';

class Task{

  String id;
  String title;
  bool isDone;
  DateTime dateOfCreation;
  DateTime dateToComplete;
  var innerTasks = <InnerTask>[];

  Task({this.id, this.title, this.isDone = false, this.innerTasks, this.dateOfCreation, this.dateToComplete});

  Map<String, dynamic> toMap(String branchID) {
    return {
      DBConstants.taskId : id,
      DBConstants.taskTitle: title,
      DBConstants.taskIsDone: isDone ? 1 : 0,
      DBConstants.branchId: branchID,
      DBConstants.taskDateOfCreation: dateOfCreation.millisecondsSinceEpoch,
      DBConstants.taskDateToComplete: dateToComplete == null ? 0 : dateToComplete.millisecondsSinceEpoch
    };
  }

  Task copyWith({
    String id,
    String title,
    bool isDone,
    DateTime dateOfCreation,
    DateTime dateToComplete,
    var innerTasks,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      dateOfCreation: dateOfCreation ?? this.dateOfCreation,
      dateToComplete: dateToComplete ?? this.dateToComplete,
      innerTasks: innerTasks ?? this.innerTasks,
    );
  }

}