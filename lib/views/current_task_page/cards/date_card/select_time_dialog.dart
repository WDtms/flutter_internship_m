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
        InkWell(
          child: Text('Сегодня'),
          onTap: () {
            widget.selectDateToComplete(widget.dateTime);
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Text('Завтра'),
          onTap: () {
            var dateTimeToComplete = DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day + 1);
            widget.selectDateToComplete(dateTimeToComplete);
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Text('На следующей неделе'),
          onTap: () {
            var dateTimeToComplete = DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day + 7);
            widget.selectDateToComplete(dateTimeToComplete);
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Text('Выбрать дату и время'),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2022),
            ).then((dateTimeToComplete) {
              widget.selectDateToComplete(dateTimeToComplete);
              Navigator.pop(context);
            });
          },
        ),
      ],
      contentPadding: EdgeInsets.all(12),
    );
  }
}
