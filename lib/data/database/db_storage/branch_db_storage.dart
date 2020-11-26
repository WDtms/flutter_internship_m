

import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';

import 'db_storage.dart';
import 'package:sqflite/sqflite.dart';

import '../db.dart';

class BranchDBStorage implements DBStorage{

  @override
  String get createTable => "CREATE TABLE ${DBConstants.branchTable} ("
      "${DBConstants.branchId} TEXT PRIMARY KEY,"
      "${DBConstants.branchTitle} TEXT,"
      "${DBConstants.branchTheme} INTEGER"
      ")";

  @override
  Future<void> insertObject(Map<String, dynamic> branch) async {
    Database db = await DB.instance.database;

    await db.insert(
      DBConstants.branchTable,
      branch,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

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

  Future<Map<String, Branch>> initializeBranches() async {
    Map<String, Branch> branches = Map<String, Branch>();
    Database db = await DB.instance.database;

    List<Map> branchesDB = await db.query(DBConstants.branchTable);
    branchesDB.forEach((row) {
      branches[row[DBConstants.branchId]] = Branch(
          id: row[DBConstants.branchId],
          title: row[DBConstants.branchTitle],
          theme: themes[row[DBConstants.branchTheme]],
          taskList: []
      );
    });

    List<Map> tasksDB = await db.query(DBConstants.taskTable);
    tasksDB.forEach((row) {
      branches[row[DBConstants.branchId]].taskList.add(
          Task(
            id: row[DBConstants.taskId],
            title: row[DBConstants.taskTitle],
            isDone: row[DBConstants.taskIsDone] == 1 ? true : false,
            dateToComplete: row[DBConstants.taskDateToComplete] == 0 ? null
                : DateTime.fromMillisecondsSinceEpoch(row[DBConstants.taskDateToComplete]),
            dateOfCreation: DateTime.fromMillisecondsSinceEpoch(row[DBConstants.taskDateOfCreation]),
            notificationTime: row[DBConstants.taskNotificationTime] == 0 ? null
                : DateTime.fromMillisecondsSinceEpoch(row[DBConstants.taskNotificationTime]),
            innerTasks: [],
          )
      );
    });

    List<Map> innerTaskDB = await db.query(DBConstants.innerTaskTable);
    innerTaskDB.forEach((row) {
      int index = branches[row[DBConstants.branchId]].taskList.indexWhere((task) => task.id == row[DBConstants.taskId]);
      branches[row[DBConstants.branchId]].taskList[index].innerTasks.add(
          InnerTask(
            id: row[DBConstants.innerTaskId],
            title: row[DBConstants.innerTaskTitle],
            isDone: row[DBConstants.innerTaskIsDone] == 1 ? true : false,
          )
      );
    });

    return branches;
  }

}