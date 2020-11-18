import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/theme_list.dart';
import 'package:flutter_internship_v2/services/db_constants.dart';

class TaskList{

  String id;
  String title;
  Map<Color, Color> theme;
  final List<Task> taskList;

  TaskList({this.id, this.title, this.taskList, this.theme});

  List<Map<Color, Color>> _themes = ThemeList().themes;

  Map<String, dynamic> toMap() {
    return {
      DBConstants.branchId : id,
      DBConstants.branchTitle: title,
      DBConstants.branchTheme: _themes.indexOf(theme),
    };
  }

  TaskList copyWith({
    String id,
    String title,
    Map<Color, Color> theme,
    List<Task> taskList
  }) {
    return TaskList(
      id: id ?? this.id,
      title: title ?? this.title,
      theme: theme ?? this.theme,
      taskList: taskList ?? this.taskList
    );
  }
}