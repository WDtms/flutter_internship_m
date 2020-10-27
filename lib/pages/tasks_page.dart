import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task_model.dart';
import 'package:flutter_internship_v2/views/appbar_menu.dart';
import 'file:///C:/Users/Shepelev.AA1/AndroidStudioProjects/flutter_internship_v2/lib/views/float_button/floating_button.dart';
import 'package:flutter_internship_v2/views/tasks_list.dart';

class TasksPage extends StatelessWidget{

  static final tasks = [
    new TaskModels(
        taskTitle: "Дорисовать дизайн"
    ),
    new TaskModels(
        taskTitle: "Дописать тз на стажировку"
    ),
    new TaskModels(
        taskTitle: "Дописать план"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_sharp),
        title: Text('Задачи'),
        actions: [
          AppBarMenu()
        ],
      ),
      floatingActionButton: FloatingButton(),
      body: TasksViews(),
    );
  }
}