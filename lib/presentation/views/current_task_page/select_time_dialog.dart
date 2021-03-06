import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';

class SelectTimeDialog extends StatefulWidget {

  final Task task;
  final Function(DateTime dateTime) selectDateToComplete;

  SelectTimeDialog({this.task, this.selectDateToComplete});

  @override
  _SelectTimeDialogState createState() => _SelectTimeDialogState();
}

class _SelectTimeDialogState extends State<SelectTimeDialog> {

  DateTime _dateOfCreation;

  @override
  void initState() {
    _dateOfCreation = DateTime.fromMillisecondsSinceEpoch(widget.task.dateOfCreation);
    super.initState();
  }

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
              widget.selectDateToComplete(DateTime(
                  _dateOfCreation.year,
                  _dateOfCreation.month,
                  _dateOfCreation.day,
                  17, 59, 59));
              Navigator.pop(context);
            },
          ),
        ),
        Divider(),
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
              widget.selectDateToComplete(DateTime(
                  _dateOfCreation.year,
                  _dateOfCreation.month,
                  _dateOfCreation.day
                      + 1, 9, 59, 59));
              Navigator.pop(context);
            },
          ),
        ),
        Divider(),
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
              widget.selectDateToComplete(DateTime(
                  _dateOfCreation.year,
                  _dateOfCreation.month,
                  _dateOfCreation.day
                      + 7, 9, 59, 59));
              Navigator.pop(context);
            },
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            child: Text(
              'Выбрать дату',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: widget.task.dateToComplete == 0 ? DateTime.now()
                    : DateTime.fromMillisecondsSinceEpoch(widget.task.dateToComplete),
                firstDate: DateTime.now(),
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
