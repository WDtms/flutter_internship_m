import 'package:flutter_internship_v2/services/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'db_storage.dart';
import '../db.dart';

class InnerTaskDBStorage implements DBStorage{

  @override
  String get createTable => "CREATE TABLE ${DBConstants.innerTaskTable} ("
      "${DBConstants.innerTaskId} TEXT PRIMARY KEY,"
      "${DBConstants.innerTaskTitle} TEXT,"
      "${DBConstants.innerTaskIsDone} INTEGER,"
      "${DBConstants.taskId} TEXT,"
      "${DBConstants.branchId} TEXT"
      ")";

  @override
  Future<List<Map>> getQuery() async {
    Database db = await DB.instance.database;

    return await db.query(DBConstants.innerTaskTable);
  }

  @override
  Future<void> insertObject(Map<String, dynamic> innerTask) async {
    Database db = await DB.instance.database;

    await db.insert(
      DBConstants.innerTaskTable,
      innerTask,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

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