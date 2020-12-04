

import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';
import 'db_wrapper.dart';
import 'package:sqflite/sqflite.dart';

import '../db.dart';

class BranchDBStorage implements DBStorage{

  //Создание таблицы
  @override
  String get createTable => "CREATE TABLE ${DBConstants.branchTable} ("
      "${DBConstants.branchId} TEXT PRIMARY KEY,"
      "${DBConstants.branchTitle} TEXT,"
      "${DBConstants.branchTheme} INTEGER"
      ")";

  //Внесение нового объекта в таблицу
  @override
  Future<void> insertObject(Map<String, dynamic> branch) async {
    Database db = await DB.instance.database;

    await db.insert(
      DBConstants.branchTable,
      branch,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Обновление объекта в таблице
  @override
  Future<void> updateObject(Map<String, dynamic> branch) async {
    Database db = await DB.instance.database;

    await db.update(
      DBConstants.branchTable,
      branch,
      where: "${DBConstants.branchId} = ?",
      whereArgs: [branch[DBConstants.branchId]],
    );
  }

  //Удаление объекта из таблицы
  @override
  Future<void> deleteObject(String branchID) async {
    Database db = await DB.instance.database;

    await db.delete(
      DBConstants.branchTable,
      where: "${DBConstants.branchId} = ?",
      whereArgs: [branchID],
    );
    await db.delete(
      DBConstants.taskTable,
      where: "${DBConstants.branchId} = ?",
      whereArgs: [branchID],
    );
    await db.delete(
      DBConstants.innerTaskTable,
      where: "${DBConstants.branchId} = ?",
      whereArgs: [branchID],
    );
  }

  //Вытягивание и кэширование всей инфы из базы данных
  Future<Map<String, Branch>> initializeBranches() async {
    Map<String, Branch> branches = Map<String, Branch>();
    Database db = await DB.instance.database;

    List<Map> branchesDB = await db.query(DBConstants.branchTable);
    branchesDB.forEach((row) {
      branches[row[DBConstants.branchId]] = Branch.fromMap(row);
    });

    List<Map> tasksDB = await db.query(DBConstants.taskTable);
    tasksDB.forEach((row) {
      branches[row[DBConstants.branchId]].taskList[row[DBConstants.taskId]] = Task.fromMap(row);
    });

    List<Map> innerTaskDB = await db.query(DBConstants.innerTaskTable);
    innerTaskDB.forEach((row) {
      branches[row[DBConstants.branchId]].taskList[row[DBConstants.taskId]].innerTasks[row[DBConstants.innerTaskId]] = InnerTask.fromMap(row);
    });

    return branches;
  }

}