import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'db_wrappers/branch_db_wrapper.dart';
import 'db_wrappers/innertask_db_wrapper.dart';
import 'db_wrappers/task_db_wrapper.dart';



class DB{

  DB._();

  static final DB instance = DB._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(BranchDBStorage().createTable);
      await db.execute(TaskDBStorage().createTable);
      await db.execute(InnerTaskDBStorage().createTable);
    });
  }
}