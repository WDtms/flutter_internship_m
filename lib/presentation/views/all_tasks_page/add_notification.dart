import 'package:flutter/material.dart';

class AddNotification extends StatefulWidget {

  final Function(DateTime notificationTime) setNotification;

  AddNotification({this.setNotification});

  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {

  DateTime notificationTime;
  bool notificationTimeChosen;

  @override
  void initState() {
    notificationTimeChosen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 50, 8),
      child: InkWell(
        onTap: () async {
          DateTime date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2022),
          );
          TimeOfDay time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (date != null && time != null) {
            notificationTime = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            widget.setNotification(notificationTime);
            setState(() {
              notificationTimeChosen = true;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffB5C9FD),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 8, 4),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.black54,
                  size: 26,
                ),
                Expanded(
                  child: Center(
                    child: Builder(
                        builder: (context) {
                          if (notificationTimeChosen){
                            return Text(
                              '${notificationTime.year}.'
                                  '${_decideHowToDisplay(notificationTime.month)}'
                                  '.${_decideHowToDisplay(notificationTime.day)}'
                                  ' в ${_decideHowToDisplay(notificationTime.hour)}'
                                  ':${_decideHowToDisplay(notificationTime.minute)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black87
                              ),
                            );
                          }
                          return Text(
                            'Напомнить',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          );
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _decideHowToDisplay(int val){
    if (val < 10)
      return "0$val";
    return "$val";
  }
}
