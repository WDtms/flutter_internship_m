import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';

class NotificationDisplay extends StatelessWidget {

  final int notificationTime;

  NotificationDisplay({this.notificationTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: InkWell(
        onTap: () async {
          final DateTime date = await showDatePicker(
            context: context,
            initialDate: notificationTime == 0 ? DateTime.now()
                : DateTime.fromMillisecondsSinceEpoch(notificationTime),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime: notificationTime == 0? TimeOfDay.now()
                : TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(notificationTime)),
          );
          if (date != null && time != null) {
            context.bloc<CurrentTaskCubit>().editNotificationTime(
                DateTime(
                    date.year, date.month, date.day, time.hour, time.minute)
                    .millisecondsSinceEpoch
            );
          }
        },
        child: Row(
          children: <Widget>[
            Builder(
              builder: (context) {
                if (notificationTime != 0)
                  return Icon(
                    Icons.notifications_active_outlined,
                    color: _isExpired(notificationTime),
                  );
                return Icon(
                  Icons.notifications_active_outlined,
                  color: Color(0xff616161),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Builder(
                  builder: (context) {
                    if (notificationTime == 0)
                      return Text(
                        'Напомнить',
                        style: TextStyle(
                            color: Color(0xff616161),
                            fontSize: 15
                        ),
                      );
                    return Text(
                      '${_decideHowToDisplay(DateTime.fromMillisecondsSinceEpoch(notificationTime).day)}.'
                          '${_decideHowToDisplay(DateTime.fromMillisecondsSinceEpoch(notificationTime).month)}.'
                          '${DateTime.fromMillisecondsSinceEpoch(notificationTime).year} в '
                          '${_decideHowToDisplay(DateTime.fromMillisecondsSinceEpoch(notificationTime).hour)}:'
                          '${_decideHowToDisplay(DateTime.fromMillisecondsSinceEpoch(notificationTime).minute)}',
                      style: TextStyle(
                        color: _isExpired(notificationTime),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
                context.bloc<CurrentTaskCubit>().editNotificationTime(0);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _isExpired(int dateInt){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInt);
    if (DateTime.now().isAfter(date))
      return Color(0xffF64444);
    return Color(0xff1A9FFF);
  }

  String _decideHowToDisplay(int val) {
    if (val<10)
      return "0$val";
    return "$val";
  }
}
