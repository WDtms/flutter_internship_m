
import 'package:flutter_internship_v2/data/constants/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'db_wrapper.dart';
import '../db.dart';

class InnerTaskDBStorage implements DBStorage{

  //Создание таблицы
  @override
  String get createTable => "CREATE TABLE ${DBConstants.innerTaskTable} ("
      "${DBConstants.innerTaskId} TEXT PRIMARY KEY,"
      "${DBConstants.innerTaskTitle} TEXT,"
      "${DBConstants.innerTaskIsDone} INTEGER,"
      "${DBConstants.taskId} TEXT,"
      "${DBConstants.branchId} TEXT"
      ")";

  //Внесение нового объекта в таблицу
  @override
  Future<void> insertObject(Map<String, dynamic> innerTask) async {
    Database db = await DB.instance.database;

    await db.insert(
      DBConstants.innerTaskTable,
      innerTask,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Обновление объекта в таблице
  @override
  Future<void> updateObject(Map<String, dynamic> innerTask) async {
    Database db = await DB.instance.database;

    await db.update(
      DBConstants.innerTaskTable,
      innerTask,
      where: "${DBConstants.innerTaskId} = ?",
      whereArgs: [innerTask[DBConstants.innerTaskId]],
    );
  }

  //Удаление объекта из таблицы
  @override
  Future<void> deleteObject(String innerTaskID) async {
    Database db = await DB.instance.database;

    await db.delete(
      DBConstants.innerTaskTable,
      where: "${DBConstants.innerTaskId} = ?",
      whereArgs: [innerTaskID],
    );
  }

}