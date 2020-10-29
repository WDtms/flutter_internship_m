import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/popup_constans.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/tasks_service.dart';
import 'package:flutter_internship_v2/views/form_dialog.dart';
import 'package:flutter_internship_v2/views/tasks_list.dart';

class TasksPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TasksPage>{

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_sharp),
        title: Text('Задачи'),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add_sharp),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FormDialog();
                }
            );
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: TasksViews(),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.delete){
      setState(() {
        TaskService.tasks.removeWhere((task) => task.taskIsDone);
      });
    } else {
      for (TaskModels task in TaskService.tasks){
        if (task.taskIsDone == true){
          setState(() {

          });
        }
      }
    }
  }

}


