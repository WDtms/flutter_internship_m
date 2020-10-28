import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/popup_constans.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/tasks.dart';
import 'package:flutter_internship_v2/styles/my_colors.dart';
import 'package:flutter_internship_v2/views/bottom_dialog.dart';
import 'package:flutter_internship_v2/views/my_floating_button.dart';
import 'package:flutter_internship_v2/views/popup_appbar.dart';
import 'package:flutter_internship_v2/views/tasks_list.dart';

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
          new TaskModel(
              Title: taskName
          )
      );
    });
  }

  void choiceAction(String choice) {
    if (choice == Constants.delete){
      setState(() {
        tasks.removeWhere((task) => task.IsDone);
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
        if (tasks[i].IsDone) {
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
    if (value == 0){
      setState(() {
        for (var item in firstTheme.entries){
          appBarColor = item.key;
          backGroundColor = item.value;
        }
      });
    }
    if (value == 1){
      setState(() {
        for (var item in secondTheme.entries){
          appBarColor = item.key;
          backGroundColor = item.value;
        }
      });
    }
    if (value == 2){
      setState(() {
        for (var item in thirdTheme.entries){
          appBarColor = item.key;
          backGroundColor = item.value;
        }
      });
    }
    if (value == 3){
      setState(() {
        for (var item in fourthTheme.entries){
          appBarColor = item.key;
          backGroundColor = item.value;
        }
      });
    }
    if (value == 4){
      setState(() {
        for (var item in fifthTheme.entries){
          appBarColor = item.key;
          backGroundColor = item.value;
        }
      });
    }
    if (value == 5){
      setState(() {
        for (var item in sixTheme.entries){
          appBarColor = item.key;
          backGroundColor = item.value;
        }
      });
    }
  }
}


