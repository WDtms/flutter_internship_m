import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InnerTaskCard extends StatelessWidget {

  final Task task;
  final int indexInnerTask;
  final Color activeColor;
  final String branchID;
  final int indexTask;
  final Function() updateTaskList;


  InnerTaskCard({this.task, this.activeColor, this.branchID, this.indexTask, this.indexInnerTask, this.updateTaskList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              value: task.innerTasks[indexInnerTask].isDone,
              activeColor: activeColor,
              onChanged: (bool value) async {
                bool isCompleted = task.innerTasks[indexInnerTask].isDone;
                await context.bloc<CurrentTaskCubit>().editInnerTask(
                    branchID,
                    indexTask,
                    indexInnerTask,
                    task.innerTasks[indexInnerTask].copyWith(isDone: !isCompleted)
                );
                updateTaskList();
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                    task.innerTasks[indexInnerTask].title,
                    style: TextStyle(
                      fontSize: 16,
                    )
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await context.bloc<CurrentTaskCubit>().deleteInnerTask(branchID, indexTask, indexInnerTask);
                updateTaskList();
              },
            )
          ],
        ),
      ),
    );;
  }
}
