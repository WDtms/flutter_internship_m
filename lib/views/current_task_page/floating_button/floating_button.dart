import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';

typedef ChangeIsDoneOfTaskCallback(TaskModel task);

class CurrentPageFloatingButton extends StatefulWidget {

  final TaskModel task;
  final ChangeIsDoneOfTaskCallback changeIsDoneOfTask;

  CurrentPageFloatingButton({this.task, this.changeIsDoneOfTask});

  @override
  _CurrentPageFloatingButtonState createState() => _CurrentPageFloatingButtonState();
}

class _CurrentPageFloatingButtonState extends State<CurrentPageFloatingButton> {


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: displayIcon(widget.task),
      backgroundColor: Colors.teal,
      onPressed: () {
        setState(() {
          widget.changeIsDoneOfTask(widget.task);
        });
      },
    );
  }

  displayIcon(TaskModel task) {
    if (task.isDone)
      return Icon(Icons.close);
    else
      return Icon(Icons.check);
  }
}
