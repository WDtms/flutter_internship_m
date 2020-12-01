import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';

class InnerTaskCard extends StatelessWidget {

  final Task task;
  final String innerTaskID;
  final Color activeColor;
  final Function() updateTaskList;


  InnerTaskCard({this.task, this.activeColor, this.innerTaskID, this.updateTaskList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
      child: Container(
        child: Row(
          children: [
            CircularCheckBox(
              value: task.innerTasks[innerTaskID].isDone,
              activeColor: activeColor,
              onChanged: (bool value) async {
                bool isCompleted = task.innerTasks[innerTaskID].isDone;
                await context.bloc<CurrentTaskCubit>().editInnerTask(
                    innerTaskID,
                    task.innerTasks[innerTaskID].copyWith(isDone: !isCompleted)
                );
                updateTaskList();
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                    task.innerTasks[innerTaskID].title,
                    style: TextStyle(
                      fontSize: 16,
                    )
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await context.bloc<CurrentTaskCubit>().deleteInnerTask(innerTaskID);
                updateTaskList();
              },
            )
          ],
        ),
      ),
    );
  }
}
