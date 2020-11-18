
import 'package:flutter_internship_v2/services/db_constants.dart';
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
  Future<List<Map>> getQuery() async {
    Database db = await DB.instance.database;

    return await db.query(DBConstants.branchTable);
  }

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
  }

}