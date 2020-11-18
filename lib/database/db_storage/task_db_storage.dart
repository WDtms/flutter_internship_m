import 'package:flutter_internship_v2/services/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'db_storage.dart';
import '../db.dart';

class TaskDBStorage implements DBStorage{

  @override
  String get createTable => "CREATE TABLE ${DBConstants.taskTable} ("
      "${DBConstants.taskId} TEXT PRIMARY KEY,"
      "${DBConstants.taskTitle} TEXT,"
      "${DBConstants.taskIsDone} INTEGER,"
      "${DBConstants.taskDateOfCreation} INTEGER,"
      "${DBConstants.taskDateToComplete} INTEGER,"
      "${DBConstants.branchId} TEXT"
      ")";

  @override
  Future<List<Map>> getQuery() async {
    Database db = await DB.instance.database;

    return await db.query(DBConstants.taskTable);
  }

  @override
  Future<void> insertObject(Map<String, dynamic> task) async {
    Database db = await DB.instance.database;

    await db.insert(
      DBConstants.taskTable,
      task,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

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

  @override
  Future<void> deleteObject(String taskID) async {
    Database db = await DB.instance.database;

    await db.delete(
      DBConstants.taskTable,
      where: "${DBConstants.taskId} = ?",
      whereArgs: [taskID],
    );
  }

  Future<void> deleteAllTasksCompleted(List<String> listTaskID) async {
    Database db = await DB.instance.database;

    for (String taskID in listTaskID) {
      await db.delete(
        DBConstants.taskTable,
        where: "${DBConstants.taskId} = ?",
        whereArgs: [taskID],
      );
    }
  }

}