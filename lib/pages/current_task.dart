import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/views/current_task_page/my_card.dart';

typedef ChangeIsDoneCallback(bool value, TaskModel task, int index);
typedef DeleteInnerTaskCallback(TaskModel task, int index);
typedef CreateInnerTaskCallback(TaskModel task, String value);

class CurrentTaskPage extends StatefulWidget {

  final ChangeIsDoneCallback changeIsDone;
  final DeleteInnerTaskCallback deleteInnerTask;
  final CreateInnerTaskCallback createInnerTask;
  final Color appBarColor;
  final Color backGroundColor;
  final String taskName;
  final TaskModel task;

  CurrentTaskPage({this.taskName, this.appBarColor, this.backGroundColor, this.task, this.changeIsDone, this.deleteInnerTask, this.createInnerTask});

  @override
  _CurrentTaskState createState() => _CurrentTaskState();
}

class _CurrentTaskState extends State<CurrentTaskPage> {

  bool isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backGroundColor,
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        title: Text(widget.taskName),
      ),
      body: Center(
        child: MyCard(
          task: widget.task,
          appBarColor: widget.appBarColor,
          changeIsDone: widget.changeIsDone,
          createInnerTask: widget.createInnerTask,
          deleteInnerTask: widget.deleteInnerTask
        ),
      ),
    );
  }
}
