import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/popup_constans.dart';
import 'package:flutter_internship_v2/services/tasks.dart';
import 'package:flutter_internship_v2/services/themes.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/bottom_dialog/bottom_dialog.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/my_floating_button.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/popup_menu/popup_appbar.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/tasks_display/task_list.dart';

class TasksPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TasksPage>{

  final List<TaskModel> tasks = TaskService.tasks;
  List<TaskModel> hiddenTask;
  bool isHidden = false;
  Color appBarColor;
  Color backGroundColor;

  @override
  void initState() {
    super.initState();
    appBarColor = Color(0xff6200EE);
    backGroundColor = Color.fromRGBO(181, 201, 253, 1);
    hiddenTask = List<TaskModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: Icon(Icons.arrow_back_sharp),
        title: Text('Задачи'),
        actions: [
          PopupMenu(actionChoice: choiceAction),
        ],
      ),
      floatingActionButton: FloatingButton(onTaskCreate: createTask),
      body: TaskList(
          isHidden: isHidden,
          tasks: tasks,
          iconsColor: appBarColor,
          hiddenTask: hiddenTask,
          backGroundColor: backGroundColor),
    );
  }

  void createTask(String taskName){
    setState(() {
      tasks.add(
          TaskModel(
              title: taskName,
              innerTasks: []
          )
      );
    });
  }

  void choiceAction(String choice) {
    if (choice == Constants.delete){
      setState(() {
        tasks.removeWhere((task) => task.isDone);
      });
    } else if (choice == Constants.changeTheme){
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return BottomDialog(changeTheme: changeTheme);
          }
      );
    }
    else if (choice == Constants.hide){
      for (int i = 0; i < tasks.length; i++) {
        if (tasks[i].isDone) {
          setState(() {
            hiddenTask.add(tasks[i]);
          });
        }
      }
      setState(() {
          isHidden = true;
      });
    }
  }

  void changeTheme(int value){
    setState(() {
      for (var item in ListOfThemes.themes[value].entries){
        appBarColor = item.key;
        backGroundColor = item.value;
      }
    });
  }
}


