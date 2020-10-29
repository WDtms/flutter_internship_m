import 'package:flutter_internship_v2/models/inner_task.dart';

class TaskModel{

  String title;
  bool isDone;
  var innerTasks = <InnerTask>[];

  TaskModel({this.title, this.isDone = false, this.innerTasks});

}