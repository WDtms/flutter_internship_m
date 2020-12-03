import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';

class TaskList{

  String title;
  Map<Color, Color> theme;
  final List<TaskModel> taskList;

  TaskList({this.title, this.taskList, this.theme});
}