import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/constants/db_constants.dart';
import 'package:flutter_internship_v2/data/constants/my_themes_colors.dart';
import 'package:flutter_internship_v2/data/models/task.dart';


class Branch{

  //Обязательные поля
  //
  //ID ветки
  final String id;
  //
  //Название ветки
  final String title;
  //
  //Массив задач
  final Map<String, Task> taskList;
  //
  //Цветовая тема ветки
  Map<Color, Color> theme;

  //Конструктор
  Branch(this.id, this.title, this.taskList, this.theme);

  /*
  Преобразование объекта в Map для последующей
  отправки в базу данных
   */
  Map<String, dynamic> toMap() {
    return {
      DBConstants.branchId : id,
      DBConstants.branchTitle: title,
      DBConstants.branchTheme: themes.indexOf(theme),
    };
  }

  /*
  Преобразование строки таблицы, полученной из базы
  данных в объект
   */
  factory Branch.fromMap(Map<String, dynamic> row){
    return Branch(
        row[DBConstants.branchId],
        row[DBConstants.branchTitle],
        {},
        themes[row[DBConstants.branchTheme]],
    );
  }
}