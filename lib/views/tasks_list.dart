import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/pages/tasks_page.dart';

class TasksViews extends StatefulWidget{

  @override
  _TasksViewsState createState() => _TasksViewsState();
}

class _TasksViewsState extends State<TasksViews>{

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      itemCount: TasksPage.tasks.length,
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
                  value: TasksPage.tasks[index].taskIsDone,
                  activeColor: Colors.indigo[600],
                  onChanged: (bool value) {
                    setState(() {
                      TasksPage.tasks[index].taskIsDone = value;
                    });
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(TasksPage.tasks[index].taskTitle),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.indigo[600],
                  onPressed: () {
                    setState(() {

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