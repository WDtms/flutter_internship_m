import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/db_constants.dart';
import 'package:flutter_internship_v2/styles/my_themes_colors.dart';

class Branch{

  String id;
  String title;
  Map<Color, Color> theme;
  final List<Task> taskList;

  Branch({this.id, this.title, this.taskList, this.theme});

  Map<String, dynamic> toMap() {
    return {
      DBConstants.branchId : id,
      DBConstants.branchTitle: title,
      DBConstants.branchTheme: themes.indexOf(theme),
    };
  }

  Branch copyWith({
    String id,
    String title,
    Map<Color, Color> theme,
    List<Task> taskList
  }) {
    return Branch(
      id: id ?? this.id,
      title: title ?? this.title,
      theme: theme ?? this.theme,
      taskList: taskList ?? this.taskList
    );
  }
}