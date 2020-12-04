import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

import 'storage.dart';


class LocalStorageTaskWrapper{

  //Получение списка задач
  Map<String, Task> getTaskList(String branchID){
    return getTaskListCopy(Storage.getInstance().branches[branchID].taskList);
  }

  //Получение темы ветки
  Map<Color, Color> getBranchTheme(String branchID){
    return Storage.getInstance().branches[branchID].theme;
  }

  //Создание новой задачи
  void createNewTask(String branchID, Task task) {
    Storage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  //Редактирование задачи
  void editTask(String branchID, Task task) {
    Storage.getInstance().branches[branchID].taskList[task.id] = task;
  }

  //Удаление задачи
  void deleteTask(String branchID, String taskID) {
    Storage.getInstance().branches[branchID].taskList.remove(taskID);
  }

  //Удаление всех завершенных задач
  void deleteAllCompletedTasks(String branchID) {
    Storage.getInstance().branches[branchID].taskList.removeWhere((taskID, task) => task.isDone);
  }

  //Изменение темы ветки
  void changeTheme(String branchID, Map<Color, Color> theme) {
    Storage.getInstance().branches[branchID].theme = theme;
  }

  //Создание копии списка задач для безопасного изменения в блоке
  Map<String, Task> getTaskListCopy(Map<String, Task> taskList){
    Map<String, Task> taskListCopy = Map<String, Task>();
    taskListCopy.addAll(taskList);
    return taskListCopy;
  }

  //Получение задачи
  Task getTask(String branchID, String taskID){
    return Storage.getInstance().branches[branchID].taskList[taskID];
  }

}