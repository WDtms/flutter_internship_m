

import 'package:flutter_internship_v2/data/constants/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'db_wrapper.dart';
import '../db.dart';

class TaskDBStorage implements DBStorage{

  //Создание таблицы
  @override
  String get createTable => "CREATE TABLE ${DBConstants.taskTable} ("
      "${DBConstants.taskId} TEXT PRIMARY KEY,"
      "${DBConstants.taskTitle} TEXT,"
      "${DBConstants.taskIsDone} INTEGER,"
      "${DBConstants.taskFavor} INTEGER,"
      "${DBConstants.taskDescription} TEXT,"
      "${DBConstants.taskImportance} INTEGER,"
      "${DBConstants.taskDateOfCreation} INTEGER,"
      "${DBConstants.taskDateToComplete} INTEGER,"
      "${DBConstants.taskNotificationTime} INTEGER,"
      "${DBConstants.taskImages} TEXT,"
      "${DBConstants.taskSelectedImage} TEXT,"
      "${DBConstants.branchId} TEXT"
      ")";

  //Внесение нового объекта в таблицу
  @override
  Future<void> insertObject(Map<String, dynamic> task) async {
    Database db = await DB.instance.database;

    await db.insert(
      DBConstants.taskTable,
      task,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Обновление объекта в таблице
  @override
  Future<void> updateObject(Map<String, dynamic> task) async {
    Database db = await DB.instance.database;

    await db.update(
      DBConstants.taskTable,
      task,
      where: "${DBConstants.taskId} = ?",
      whereArgs: [task[DBConstants.taskId]],
    );
  }

  //Удаление объекта из таблицы
  @override
  Future<void> deleteObject(String taskID) async {
    Database db = await DB.instance.database;

    await db.delete(
      DBConstants.taskTable,
      where: "${DBConstants.taskId} = ?",
      whereArgs: [taskID],
    );
    await db.delete(
      DBConstants.innerTaskTable,
      where: "${DBConstants.taskId} = ?",
      whereArgs: [taskID],
    );
  }

  //Удаление всех задач с флагом "Завершена"
  Future<void> deleteAllCompletedTasks(String branchID, List<String> taskIDList) async {
    Database db = await DB.instance.database;

    await db.delete(
      DBConstants.taskTable,
      where: "${DBConstants.branchId} = ? AND ${DBConstants.taskIsDone} = ?",
      whereArgs: [branchID, 1],
    );

    for (String taskID in taskIDList)
      await db.delete(
        DBConstants.innerTaskTable,
        where: "${DBConstants.taskId} = ?",
        whereArgs: [taskID]
      );
  }

}