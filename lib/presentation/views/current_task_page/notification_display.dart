import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';

class NotificationDisplay extends StatelessWidget {

  final Task task;

  NotificationDisplay({this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: InkWell(
        onTap: () async {
          final DateTime date = await showDatePicker(
            context: context,
            initialDate: task.notificationTime == null ? DateTime.now()
                : task.notificationTime,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime: task.notificationTime == null? TimeOfDay.now()
                : TimeOfDay.fromDateTime(task.notificationTime),
          );
          if (date != null && time != null) {
            context.bloc<CurrentTaskCubit>().editTask(
                task.copyWith(
                    notificationTime: DateTime(
                        date.year, date.month, date.day, time.hour, time.minute)
                ));
          }
        },
        child: Row(
          children: <Widget>[
            Builder(
              builder: (context) {
                if (task.notificationTime != null)
                  return Icon(
                    Icons.notifications_active_outlined,
                    color: isExpired(task.notificationTime),
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
                  if (task.notificationTime == null)
                    return Text(
                      'Напомнить',
                      style: TextStyle(
                          color: Color(0xff616161),
                          fontSize: 15
                      ),
                    );
                  return Text(
                    '${task.notificationTime.year}.'
                        '${task.notificationTime.month}.'
                        '${task.notificationTime.day} в '
                        '${task.notificationTime.hour}:'
                        '${_displayMinutes(task.notificationTime.minute)}',
                    style: TextStyle(
                      color: isExpired(task.notificationTime),
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

  Color isExpired(DateTime date){
    if (DateTime.now().isAfter(date))
      return Color(0xffF64444);
    return Color(0xff1A9FFF);
  }

  String _displayMinutes(int minutes){
    if (minutes<10)
      return "0$minutes";
    return "$minutes";
  }
}
