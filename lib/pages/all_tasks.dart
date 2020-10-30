import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/popup_constans.dart';
import 'package:flutter_internship_v2/services/tasks.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/bottom_dialog/bottom_dialog.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/my_floating_button.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/popup_menu/popup_appbar.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/tasks_display/task_list.dart';

typedef ChangeThemeCallBack(int value);

class TasksPage extends StatefulWidget {

  final appBarColor;
  final backGroundColor;
  final ChangeThemeCallBack changeTheme;
  final List<TaskModel> tasks;

  TasksPage({this.tasks, this.appBarColor, this.backGroundColor, this.changeTheme});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TasksPage>{

  final List<TaskModel> tasks = TaskService.tasks;
  List<TaskModel> taskHidden;
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    taskHidden = List<TaskModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backGroundColor,
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
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
        iconsColor: widget.appBarColor,
        tasksHidden: taskHidden,
        backGroundColor: widget.backGroundColor,

        deleteTask: deleteTask,
        changeTaskName: changeTaskName,),
    );
  }

  void changeTaskName(int index, String value){
    setState(() {
      tasks[index].title = value;
    });
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

  void deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
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
            return BottomDialog(changeTheme: widget.changeTheme);
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
}


