import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/select_time_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayDateToComplete extends StatelessWidget {

  final Task task;

  DisplayDateToComplete({this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context1) {
                return SelectTimeDialog(
                  task: task,
                  selectDateToComplete: (DateTime dateTime) {
                    if (dateTime != null) {
                      context.bloc<CurrentTaskCubit>().editDateToComplete(
                          DateTime(
                              dateTime.year, dateTime.month, dateTime.day,
                              dateTime.hour < 1 ? 23 : dateTime.hour, 59, 59)
                              .millisecondsSinceEpoch
                          );
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
                if (task.dateToComplete != 0)
                  return Icon(
                    Icons.calendar_today_outlined,
                    color: _isExpired(task.dateToComplete),
                  );
                return Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xff616161),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Builder(
                  builder: (context) {
                    if (task.dateToComplete == 0)
                      return Text(
                        'Добавить дату выполнения',
                        style: TextStyle(
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      );
                    return Text(
                      '${_decideHowToDisplay(DateTime.fromMillisecondsSinceEpoch(task.dateToComplete).day)}.'
                          '${_decideHowToDisplay(DateTime.fromMillisecondsSinceEpoch(task.dateToComplete).month)}.'
                          '${DateTime.fromMillisecondsSinceEpoch(task.dateToComplete).year}',
                      style: TextStyle(
                          color: _isExpired(task.dateToComplete),
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    );
                  },
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.close,
                  color: Color(0xff616161),
                ),
              ),
              onTap: () {
                context.bloc<CurrentTaskCubit>().editDateToComplete(0);
              },
            ),
          ],
        ),
      ),
    );
  }

  _decideHowToDisplay(int val) {
    if (val<10)
      return "0$val";
    return "$val";
  }

  Color _isExpired(int dateInt){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInt);
    if (DateTime.now().isAfter(date))
      return Color(0xffF64444);
    return Color(0xff1A9FFF);
  }
}
