

import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'storage.dart';

class LocalStorageInnerTaskWrapper{

  //Получение задачи
  Task getTask(String branchID, String taskID){
    return Storage.getInstance().branches[branchID].taskList[taskID];
  }

  //Получение внутренней задачи
  InnerTask getInnerTask(String branchID, String taskID, String innerTaskID){
    return Storage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTaskID];
  }

  //Создание новой внутренней задачи
  void createNewInnerTask(String branchID, String taskID, InnerTask innerTask) {
    Storage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTask.id] = innerTask;
  }

  //Редактирование внутренней задачи
  void editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) {
    Storage.getInstance().branches[branchID].taskList[taskID].innerTasks[innerTaskID] = innerTask;
  }

  //Удаление внутренней задачи
  void deleteInnerTask(String branchID, String taskID, String innerTaskID) {
    Storage.getInstance().branches[branchID].taskList[taskID].innerTasks.remove(innerTaskID);
  }

  //Редактирование задачи
  void editTask(String branchID, Task task) {
    Storage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  //Удаление задачи
  void deleteTask(String branchID, String taskID) {
    Storage.getInstance().branches[branchID].taskList.remove(taskID);
  }

}