import 'package:flutter_internship_v2/models/inner_task.dart';

class TaskModel{

  String title;
  bool isDone;
  var innerTasks = <InnerTask>[];

  TaskModel({this.title, this.isDone = false, this.innerTasks});

  TaskModel copyWith({
    String title,
    bool isDone,
    var innerTasks,
  }) {
    return TaskModel(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      innerTasks: innerTasks ?? this.innerTasks
    );
  }

  TaskModel editTaskName(TaskModel task, String value) {
    return task.copyWith(title: value);
  }

  TaskModel toggleComplete(TaskModel task) {
    return task.copyWith(isDone: !isDone);
  }

  TaskModel toggleInnerComplete(TaskModel task, int innerIndex) {
    var innerTaskList = task.innerTasks;
    innerTaskList[innerIndex].isDone = !innerTaskList[innerIndex].isDone;
    return task.copyWith(innerTasks: innerTasks);
  }

}