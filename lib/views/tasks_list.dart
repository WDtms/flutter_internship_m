import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/services/tasks_service.dart';

class TasksViews extends StatefulWidget{

  bool isHidden;
  TasksViews({this.isHidden});

  @override
  _TasksViewsState createState() => _TasksViewsState(isHideFiltred: isHidden);
}

class _TasksViewsState extends State<TasksViews>{

  bool isHideFiltred;
  _TasksViewsState({this.isHideFiltred});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      itemCount: TaskService.tasks.length,
      itemBuilder: (_, index) {

        return Padding(
          padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
          child: Container(
            decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Row(
              children: [
                Checkbox(
                  value: TaskService.tasks[index].taskIsDone,
                  activeColor: Colors.indigo[600],
                  onChanged: (bool value) {
                    setState(() {
                      TaskService.tasks[index].taskIsDone = value;
                    });
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(TaskService.tasks[index].taskTitle),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.indigo[600],
                  onPressed: () {
                    setState(() {
                      TaskService.tasks.removeAt(index);
                    });
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}