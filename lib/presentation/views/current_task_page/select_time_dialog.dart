import 'package:flutter/material.dart';

class SelectTimeDialog extends StatefulWidget {

  final DateTime dateTime;
  final Function(DateTime dateTime) selectDateToComplete;

  SelectTimeDialog({this.dateTime, this.selectDateToComplete});

  @override
  _SelectTimeDialogState createState() => _SelectTimeDialogState();
}

class _SelectTimeDialogState extends State<SelectTimeDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            child: Container(
                child: Text(
                  'Сегодня (18:00)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                )
            ),
            onTap: () {
              widget.selectDateToComplete(DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day, 17, 59, 59));
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            child: Text(
              'Завтра (9:00)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              widget.selectDateToComplete(DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day + 1, 9, 59, 59));
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            child: Text(
              'На следующей неделе (9:00)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              widget.selectDateToComplete(DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day + 7, 9, 59, 59));
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            child: Text(
              'Выбрать дату и время',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((dateTimeToComplete) {
                widget.selectDateToComplete(dateTimeToComplete);
                Navigator.pop(context);
              });
            },
          ),
        ),
      ],
      contentPadding: EdgeInsets.all(12),
    );
  }
}
