


import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';

class InnerTask{

  //Обязательные поля
  //
  //ID
  final String id;
  //
  //Текст внутренней задачи
  String title;

  //Необязательные поля
  //
  //Флаг, сигнализирующий о том, выполнена ли внутренняя задача
  bool isDone;


  //Конструктор
  InnerTask(this.id, this.title, {this.isDone = false});


  /*
  Преобразование объекта в Map для последующей
  отправки в базу данных
   */
  Map<String, dynamic> toMap(String branchID, String taskID) {
    return {
      DBConstants.innerTaskId : id,
      DBConstants.innerTaskTitle: title,
      DBConstants.innerTaskIsDone: isDone ? 1 : 0,
      DBConstants.branchId: branchID,
      DBConstants.taskId: taskID,
    };
  }


  /*
  Преобразование строки таблицы, полученной из базы
  данных в объект
   */
  factory InnerTask.fromMap(Map<String, dynamic> row){
    return InnerTask(
      row[DBConstants.innerTaskId],
      row[DBConstants.innerTaskTitle],
      isDone: row[DBConstants.innerTaskIsDone] == 1 ? true : false,
    );
  }

  /*
  Функция, используемая для изменения задачи по какому-то одному аргументу, не
  меняя все остальные аргументы.
   */
  InnerTask copyWith({
    String id,
    String title,
    bool isDone,
  }) {
    return InnerTask(
      id ?? this.id,
      title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}