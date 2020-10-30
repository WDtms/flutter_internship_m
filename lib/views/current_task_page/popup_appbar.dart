import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/popup_current_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/form_dialog.dart';

typedef DeleteTaskCallBack(int index);
typedef ChangeTaskNameCallBack(int index, String value);
typedef ChangeTaskNameAtCurrentPageCallBack(String value);

class PopupMenu extends StatefulWidget {

  final ChangeTaskNameAtCurrentPageCallBack changeTaskNameAtCurrentPage;
  final ChangeTaskNameCallBack changeTaskName;
  final DeleteTaskCallBack deleteTask;
  final List<TaskModel> tasks;
  final int index;

  PopupMenu({this.tasks, this.index, this.deleteTask, this.changeTaskName, this.changeTaskNameAtCurrentPage});

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return ConstantsOnPopUpCurrentTask.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  choiceAction(String choice){
    if (choice == ConstantsOnPopUpCurrentTask.delete){
      setState(() {
        widget.deleteTask(widget.index);
        Navigator.of(context).pop();
      });
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormDialogCurrentTask(
            changeTaskName: widget.changeTaskName,
            tasks: widget.tasks,
            index: widget.index,
            changeTaskNameAtCurrentPage: widget.changeTaskNameAtCurrentPage,);
        }
      );
    }
  }
}
