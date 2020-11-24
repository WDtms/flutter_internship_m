

import 'package:flutter_internship_v2/database/db_storage/branch_db_storage.dart';
import 'package:flutter_internship_v2/database/db_storage/innertask_db_storage.dart';
import 'package:flutter_internship_v2/database/db_storage/task_db_storage.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/branch.dart';
import 'package:flutter_internship_v2/services/db_constants.dart';
import 'package:flutter_internship_v2/styles/my_themes_colors.dart';

class DBStorageAction{

  TaskDBStorage taskDBStorage;
  BranchDBStorage branchDBStorage;
  InnerTaskDBStorage innerTaskDBStorage;

  DBStorageAction(){
    taskDBStorage = TaskDBStorage();
    branchDBStorage = BranchDBStorage();
    innerTaskDBStorage = InnerTaskDBStorage();
  }



  //Загрузка ДБ из таблицы

  Future<Map<String, Branch>> initializeBranches() async {
    Map<String, Branch> branches = Map<String, Branch>();

    List<Map> branchesDB = await branchDBStorage.getQuery();
    branchesDB.forEach((row) {
      branches[row[DBConstants.branchId]] = Branch(
          id: row[DBConstants.branchId],
          title: row[DBConstants.branchTitle],
          theme: themes[row[DBConstants.branchTheme]],
          taskList: []
      );
    });

    List<Map> tasksDB = await taskDBStorage.getQuery();
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

    List<Map> innerTaskDB = await innerTaskDBStorage.getQuery();
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



  //Занесение нового объекта в таблицу

  Future<void> insertTask(Map<String, dynamic> task) async {
    await taskDBStorage.insertObject(task);
  }

  Future<void> insertBranch(Map<String, dynamic> branch) async {
    await branchDBStorage.insertObject(branch);
  }

  Future<void> insertInnerTask(Map<String, dynamic> innerTask) async {
    await innerTaskDBStorage.insertObject(innerTask);
  }



  //Обновление объекта таблицы

  Future<void> updateBranch(Map<String, dynamic> branch) async {
    await branchDBStorage.updateObject(branch);
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    await taskDBStorage.updateObject(task);
  }

  Future<void> updateInnerTask(Map<String, dynamic> innerTask) async {
    await innerTaskDBStorage.updateObject(innerTask);
  }



  //Удаление объекта из таблицы

  Future<void> deleteTask(String taskID) async {
    await taskDBStorage.deleteObject(taskID);
  }

  Future<void> deleteBranch(String branchID) async {
    await branchDBStorage.deleteObject(branchID);
    await taskDBStorage.deleteWhenBranchDeleted(branchID);
    await innerTaskDBStorage.deleteWhenBranchDeleted(branchID);
  }

  Future<void> deleteInnerTask(String innerTaskID) async {
    await innerTaskDBStorage.deleteObject(innerTaskID);
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    await taskDBStorage.deleteAllCompletedTasks(branchID);
  }

}