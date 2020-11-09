import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/views/current_task_page/select_time_dialog.dart';

class MyDateCard extends StatelessWidget {

  final int index;

  MyDateCard({this.index});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 30, 8, 8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ]
        ),
        child: Column(
          children: [
            BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskInUsageState){
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: displayDateToComplete(state),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SelectTimeDialog(index: index, dateTime: state.taskList[index].dateOfCreation);
                                }
                                );
                            },
                        ),
                      ),
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

  displayDateToComplete(TaskState state){
    if (state is TaskInUsageState){
      if (state.taskList[index].dateToComplete == null) {
        return Text('Добавить дату выполнения');
      } else {
        DateTime date = state.taskList[index].dateToComplete;
        return Text("${date.day.toString()}.${date.month.toString()}.${date.year
            .toString()}");
      }
    }
  }
}
