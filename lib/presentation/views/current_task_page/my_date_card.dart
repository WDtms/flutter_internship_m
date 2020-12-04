import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/date_to_complete_display.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/notification_display.dart';


class MyDateCard extends StatelessWidget {

  final Task task;

  MyDateCard({this.task});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 30, 16, 8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3),
              )
            ]
        ),
        child: Column(
          children: [
            BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
              builder: (context, state) {
                if (state is CurrentTaskInUsageState){
                  return Column(
                    children: [
                      NotificationDisplay(task: state.task),
                      Divider(
                        thickness: 1,
                        indent: 56,
                        color: Colors.black38,
                      ),
                      DisplayDateToComplete(task: state.task),
                    ],
                  );
                }
                else{
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
