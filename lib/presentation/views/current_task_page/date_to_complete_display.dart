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
                      context.bloc<CurrentTaskCubit>().editTask(
                          task.copyWith(
                              dateToComplete: DateTime(
                                  dateTime.year, dateTime.month, dateTime.day,
                                  23, 59, 59)
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
                if (task.dateToComplete != null)
                  return Icon(
                    Icons.calendar_today_outlined,
                    color: isExpired(task.dateToComplete),
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
                  if (task.dateToComplete == null)
                    return Text(
                      'Добавить дату выполнения',
                      style: TextStyle(
                        color: Color(0xff616161),
                        fontSize: 15,
                      ),
                    );
                  return Text(
                    '${task.dateToComplete.day}.'
                        '${task.dateToComplete.month}.'
                        '${task.dateToComplete.year}',
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

  Color isExpired(DateTime date){
    if (DateTime.now().isAfter(date))
      return Color(0xffF64444);
    return Color(0xff1A9FFF);
  }
}
