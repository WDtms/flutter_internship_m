import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/views/current_task_page/cards/date_card/select_time_dialog.dart';

class MyDateCard extends StatelessWidget {

  final Task task;
  final int indexTask;
  final String branchID;

  MyDateCard({this.task, this.indexTask, this.branchID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 30, 8, 8),
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
            BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
              builder: (context, state) {
                if (state is CurrentTaskInUsageState){
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: _displayDateToComplete(state),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context1) {
                                  return SelectTimeDialog(
                                    dateTime: state.task.dateOfCreation,
                                    selectDateToComplete: (DateTime dateTime) {
                                      context.bloc<CurrentTaskCubit>().editTask(branchID, indexTask, task.copyWith(dateToComplete: dateTime));
                                    },
                                  );
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

  Widget _displayDateToComplete(CurrentTaskState state){
    if (state is CurrentTaskInUsageState){
      if (state.task.dateToComplete == null)
        return Text('Добавить дату выполнения');
      DateTime date = state.task.dateToComplete;
      return Text(
        "${date.day.toString()}.${date.month.toString()}.${date.year.toString()}",
        style: TextStyle(
          color: isExpired(date),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Color isExpired(DateTime date){
    if (DateTime.now().isAfter(date))
      return Color(0xffF64444);
    return Color(0xff1A9FFF);
  }
}
