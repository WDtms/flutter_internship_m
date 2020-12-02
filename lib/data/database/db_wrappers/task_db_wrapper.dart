
import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'db_wrapper.dart';
import '../db.dart';

class TaskDBStorage implements DBStorage{

  @override
  String get createTable => "CREATE TABLE ${DBConstants.taskTable} ("
      "${DBConstants.taskId} TEXT PRIMARY KEY,"
      "${DBConstants.taskTitle} TEXT,"
      "${DBConstants.taskIsDone} INTEGER,"
      "${DBConstants.taskDescription} TEXT,"
      "${DBConstants.taskDateOfCreation} INTEGER,"
      "${DBConstants.taskDateToComplete} INTEGER,"
      "${DBConstants.taskNotificationTime} INTEGER,"
      "${DBConstants.taskImages} TEXT,"
      "${DBConstants.taskSelectedImage} TEXT,"
      "${DBConstants.branchId} TEXT"
      ")";

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
    await db.delete(
      DBConstants.innerTaskTable,
      where: "${DBConstants.taskId} = ?",
      whereArgs: [taskID],
    );
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    Database db = await DB.instance.database;

    await db.delete(
      DBConstants.taskTable,
      where: "${DBConstants.branchId} = ? AND ${DBConstants.taskIsDone} = ?",
      whereArgs: [branchID, 1],
    );
  }

}