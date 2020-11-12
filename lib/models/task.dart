import 'package:flutter_internship_v2/models/inner_task.dart';

class TaskModel{

  String title;
  bool isDone;
  DateTime dateOfCreation;
  DateTime dateToComplete;
  var innerTasks = <InnerTask>[];

  TaskModel({this.title, this.isDone = false, this.innerTasks, this.dateOfCreation, this.dateToComplete});

}