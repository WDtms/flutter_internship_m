import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/popup_constans.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/tasks.dart';
import 'package:flutter_internship_v2/services/themes.dart';
import 'package:flutter_internship_v2/views/bottom_dialog/bottom_dialog.dart';
import 'package:flutter_internship_v2/views/floating_create_button/my_floating_button.dart';
import 'package:flutter_internship_v2/views/popup_menu/popup_appbar.dart';
import 'package:flutter_internship_v2/views/tasks_display/tasks_list.dart';

class TasksPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TasksPage>{

  final List<TaskModel> tasks = TaskService.tasks;
  List<TaskModel> taskHidden;
  bool isHidden = false;
  Color appBarColor;
  Color backGroundColor;

  @override
  void initState() {
    super.initState();
    appBarColor = Color(0xff6200EE);
    backGroundColor = Color(0xffede7f6);
    taskHidden = List<TaskModel>();
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
      body: TaskList(isHidden: isHidden, tasks: tasks, iconsColor: appBarColor, tasksHidden: taskHidden),
    );
  }

  void createTask(String taskName){
    setState(() {
      tasks.add(
          TaskModel(
              title: taskName
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
            taskHidden.add(tasks[i]);
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


