import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/inner_task_title.dart';

class InnerTaskCard extends StatelessWidget {

  final InnerTask innerTask;
  final Color activeColor;
  final Function() updateTaskList;

  InnerTaskCard({this.innerTask, this.activeColor, this.updateTaskList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
      child: Container(
        child: Row(
          children: [
            CircularCheckBox(
              value: innerTask.isDone,
              activeColor: activeColor,
              onChanged: (bool value) async {
                await context.bloc<CurrentTaskCubit>().toggleInnerTask(innerTask.id);
                updateTaskList();
              },
            ),
            Expanded(
              child: InnerTaskTitle(
                title: innerTask.title,
                onInnerTaskEdit: (String newName) {
                  context.bloc<CurrentTaskCubit>().editInnerTaskName(innerTask.id, newName);
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Color(0xff616161),
              ),
              onPressed: () async {
                await context.bloc<CurrentTaskCubit>().deleteInnerTask(innerTask.id);
                updateTaskList();
              },
            )
          ],
        ),
      ),
    );
  }
}
