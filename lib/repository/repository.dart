import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/task_list.dart';
import 'package:flutter_internship_v2/models/theme_list.dart';
import 'package:flutter_internship_v2/styles/my_themes_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository{

  Repository() {
    initiateBranch();
  }

  Map<String, TaskList> branches = Map<String, TaskList>();
  List<Map<Color, Color>> themes = ThemeList().themes;

  initiateBranch() async {
    TaskList branch = TaskList(
      theme: firstTheme,
      title: 'Работа',
      taskList: [
        TaskModel(
          isDone: true,
          title: "Дорисовать дизайн",
          innerTasks: [],
          dateOfCreation: DateTime.now(),
          dateToComplete: null,
        ),
        TaskModel(
          title: "Дописать тз на стажировку",
          innerTasks: [
            InnerTask(
              title: 'Что-то там',
            ),
            InnerTask(
                title: 'и еще вот это'
            )
          ],
          dateOfCreation: DateTime.now(),
          dateToComplete: null,
        ),
        TaskModel(
          title: "Дописать план",
          innerTasks: [],
          dateOfCreation: DateTime.now(),
          dateToComplete: null,
        ),
      ]
    );
    branches[Uuid().v4()] = branch;
  }

  //Работа с SharedPreference

  addThemeToSf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('initialBranchTheme', 0);
  }

  getThemeFromSf() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('initialBranchTheme');
}

  //Конец работы с SharedPreference

  //Работа на ГЛАВНОЙ СТРАНИЦЕ

  Map<Map<String, String>, Map<dynamic, dynamic>> getBranchesInfo(){
    Map<Map<String, String>, Map<dynamic, dynamic>> branchesInfo = Map<Map<String, String>, Map<dynamic, dynamic>>();
    for (int i = 0; i<branches.length; i++){
      branchesInfo[{branches.keys.toList().elementAt(i) : branches[branches.keys.toList().elementAt(i)].title}]
        = getInfoFromOneBranch(branches.keys.toList().elementAt(i));
    }
    return branchesInfo;
  }

  Map<dynamic, dynamic> getInfoFromOneBranch(String id){
    int countCompletedTasks = 0;
    int countAllTasks = 0;
    for (TaskModel task in branches[id].taskList){
      if (task.isDone)
        countCompletedTasks++;
      countAllTasks++;
    }
    return {
      countCompletedTasks : countAllTasks,
      branches[id].theme.keys.toList().first : branches[id].theme.values.toList().first,
    };
  }

  void createNewBranch(){
    branches[Uuid().v4()] = TaskList(
      title: 'new',
      taskList: [],
      theme: firstTheme,
    );
  }

  //Конец методов ГЛАВНОЙ СТРАНИЦЫ

  //Работа на странице ОДНОЙ ВЕТКИ

  List<TaskModel> getTaskList(String id){
    return branches[id].taskList;
  }

  List<TaskModel> createNewTask(String id, String value, DateTime dateToComplete){
    branches[id].taskList.add(TaskModel(
        title: value,
        innerTasks: [],
        dateOfCreation: DateTime.now(),
        dateToComplete: dateToComplete,
    ));
    return branches[id].taskList;
  }

  List<TaskModel> toggleTaskComplete(String id, int index){
    branches[id].taskList[index].isDone = !branches[id].taskList[index].isDone;
    return branches[id].taskList;
  }

  List<TaskModel> deleteTask(String id, int index){
    branches[id].taskList.removeAt(index);
    return branches[id].taskList;
  }

  List<TaskModel> deleteAllCompletedTasks(String id){
    branches[id].taskList.removeWhere((task) => task.isDone);
    return branches[id].taskList;
  }

  Map<Color, Color> changeTheme(String id, Map<Color, Color> theme){
    branches[id].theme = theme;
    return branches[id].theme;
  }

  List<TaskModel> updateTask(String id){
    return branches[id].taskList;
  }

  Map<Color, Color> getBranchTheme(String id){
    return branches[id].theme;
  }

  Map<Color, Color> setBranchTheme(String id, Map<Color, Color> theme){
    branches[id].theme = theme;
    return branches[id].theme;
  }

  //Конец методов страницы с ОДНОЙ ВЕТКОЙ


  //Работа с ОДНОЙ ЗАДАЧЕЙ

  TaskModel getTask(String id, int index){
    return branches[id].taskList[index];
  }

  TaskModel toggleInnerTaskComplete(String id, int indexTask, int innerTaskIndex){
    branches[id].taskList[indexTask].innerTasks[innerTaskIndex].isDone =
        !branches[id].taskList[indexTask].innerTasks[innerTaskIndex].isDone;
    return branches[id].taskList[indexTask];
  }

  TaskModel toggleTaskCompleteFromCurrentTaskPage(String id, int indexTask){
    branches[id].taskList[indexTask].isDone = !branches[id].taskList[indexTask].isDone;
    return branches[id].taskList[indexTask];
  }

  TaskModel deleteInnerTask(String id, int indexTask, int innerTaskIndex){
    branches[id].taskList[indexTask].innerTasks.removeAt(innerTaskIndex);
    return branches[id].taskList[indexTask];
  }

  TaskModel createNewInnerTask(String id, int indexTask, String value){
    branches[id].taskList[indexTask].innerTasks.add(InnerTask(
      title: value
    ));
    return branches[id].taskList[indexTask];
  }

  TaskModel editTaskName(String id, int indexTask, String value){
    branches[id].taskList[indexTask].title = value;
    return branches[id].taskList[indexTask];
  }

  TaskModel addDateToComplete(String id, int indexTask, DateTime dateTime){
    branches[id].taskList[indexTask].dateToComplete = dateTime;
    return branches[id].taskList[indexTask];
  }

  //Конец методов страницы с ОДНОЙ ЗАДАЧЕЙ
}