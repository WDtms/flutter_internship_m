import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';

import 'package:flutter_internship_v2/presentation/views/current_task_page/select_time_dialog.dart';


class MyDateCard extends StatelessWidget {

  final Task task;
  final int indexTask;
  final String branchID;

  MyDateCard({this.task, this.indexTask, this.branchID});

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
                      _displayNotificationTime(state, context),
                      Divider(
                        thickness: 1,
                        indent: 56,
                        color: Colors.black38,
                      ),
                      _displayDateToComplete(state, context),
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

  Widget _displayNotificationTime(CurrentTaskState state, BuildContext context) {
    if (state is CurrentTaskInUsageState) {
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: InkWell(
          onTap: () async {
            final DateTime date = await showDatePicker(
              context: context,
              initialDate: state.task.notificationTime == null ? DateTime.now()
                  : state.task.notificationTime,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            final TimeOfDay time = await showTimePicker(
              context: context,
              initialTime: state.task.notificationTime == null? TimeOfDay.now()
                  : TimeOfDay.fromDateTime(state.task.notificationTime),
            );
            if (date != null && time != null) {
              context.bloc<CurrentTaskCubit>().editTask(
                  branchID, indexTask, task.copyWith(
                  notificationTime: DateTime(
                      date.year, date.month, date.day, time.hour, time.minute)
              ));
            }
          },
          child: Row(
            children: <Widget>[
              Builder(
                builder: (context) {
                  if (state.task.notificationTime != null)
                    return Icon(
                      Icons.notifications_active_outlined,
                      color: isExpired(state.task.notificationTime),
                    );
                  return Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xff616161),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Builder(
                    builder: (context) {
                      if (state.task.notificationTime == null)
                        return Text(
                          'Напомнить',
                          style: TextStyle(
                            color: Color(0xff616161),
                            fontSize: 15
                          ),
                        );
                      return Text(
                        '${state.task.notificationTime.year}.'
                            '${state.task.notificationTime.month}.'
                            '${state.task.notificationTime.day} в '
                            '${state.task.notificationTime.hour}:'
                            '${_displayMinutes(state.task.notificationTime.minute)}',
                        style: TextStyle(
                          color: isExpired(state.task.notificationTime),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _displayDateToComplete(CurrentTaskState state, BuildContext context){
    if (state is CurrentTaskInUsageState){
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context1) {
                  return SelectTimeDialog(
                    task: state.task,
                    selectDateToComplete: (DateTime dateTime) {
                      if (dateTime != null) {
                        context.bloc<CurrentTaskCubit>().editTask(
                            branchID, indexTask, task.copyWith(
                            dateToComplete: DateTime(
                                dateTime.year, dateTime.month, dateTime.day, 23,
                                59, 59)
                        ));
                      }
                    },
                  );
                }
            );
          },
          child: Row(
            children: <Widget>[
              Builder(
                builder: (context) {
                  if (state.task.dateToComplete != null)
                    return Icon(
                      Icons.calendar_today_outlined,
                      color: isExpired(state.task.dateToComplete),
                    );
                  return Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xff616161),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Builder(
                  builder: (context) {
                    if (state.task.dateToComplete == null)
                      return Text(
                        'Добавить дату выполнения',
                        style: TextStyle(
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      );
                    return Text(
                      '${state.task.dateToComplete.year}.'
                          '${state.task.dateToComplete.month}.'
                          '${state.task.dateToComplete.day}',
                      style: TextStyle(
                          color: isExpired(task.dateToComplete),
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    );
                    },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  String _displayMinutes(int minutes){
    if (minutes<10)
      return "0$minutes";
    return "$minutes";
  }

  Color isExpired(DateTime date){
    if (DateTime.now().isAfter(date))
      return Color(0xffF64444);
    return Color(0xff1A9FFF);
  }
}
