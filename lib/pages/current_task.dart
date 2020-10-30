import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/views/current_task_page/floating_button.dart';
import 'package:flutter_internship_v2/views/current_task_page/my_card.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar.dart';

typedef ChangeTaskNameCallBack(int index, String value);
typedef DeleteTaskCallBack(int index);
typedef ChangeIsDoneOfTaskCallback(TaskModel task);
typedef ChangeIsDoneCallback(bool value, TaskModel task, int index);
typedef DeleteInnerTaskCallback(TaskModel task, int index);
typedef CreateInnerTaskCallback(TaskModel task, String value);

class CurrentTask extends StatefulWidget {

  final ChangeTaskNameCallBack changeTaskName;
  final DeleteTaskCallBack deleteTask;
  final ChangeIsDoneOfTaskCallback changeIsDoneOfTask;
  final ChangeIsDoneCallback changeIsDone;
  final DeleteInnerTaskCallback deleteInnerTask;
  final CreateInnerTaskCallback createInnerTask;
  final Color appBarColor;
  final Color backGroundColor;
  final String taskName;
  final TaskModel task;
  final int index;
  final List<TaskModel> tasks;

  CurrentTask({
    this.taskName,
    this.appBarColor,
    this.backGroundColor,
    this.task,
    this.changeIsDone,
    this.deleteInnerTask,
    this.createInnerTask,
    this.changeIsDoneOfTask,
    this.deleteTask,
    this.tasks,
    this.index,
    this.changeTaskName});

  @override
  _CurrentTaskState createState() => _CurrentTaskState();
}

class _CurrentTaskState extends State<CurrentTask> {

  bool isCreating = false;
  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backGroundColor,
      floatingActionButton: CurrentPageFloatingButton(
        task: widget.task,
        changeIsDoneOfTask: widget.changeIsDoneOfTask,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        title: displayTaskTitle(),
        actions: [
          PopupMenu(
            deleteTask: widget.deleteTask,
            tasks: widget.tasks,
            index: widget.index,
            changeTaskName: widget.changeTaskName,
            changeTaskNameAtCurrentPage: changeTaskNameAtCurrentPage,
          )
        ],
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

  changeTaskNameAtCurrentPage(String value) {
    setState(() {
      taskName = value;
    });
  }

  displayTaskTitle(){
    return Text(
      widget.tasks[widget.index].title
    );
  }

}
