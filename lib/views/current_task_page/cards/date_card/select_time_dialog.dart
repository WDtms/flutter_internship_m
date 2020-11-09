import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';

class SelectTimeDialog extends StatefulWidget {

  final int index;
  final DateTime dateTime;

  SelectTimeDialog({this.index, this.dateTime});

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
            context.bloc<TaskCubit>().addDateToComplete(widget.index, widget.dateTime);
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Text('Завтра'),
          onTap: () {
            var dateTimeToComplete = DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day + 1);
            context.bloc<TaskCubit>().addDateToComplete(widget.index, dateTimeToComplete);
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Text('На следующей неделе'),
          onTap: () {
            var dateTimeToComplete = DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day + 7);
            context.bloc<TaskCubit>().addDateToComplete(widget.index, dateTimeToComplete);
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
            ).then((date) {
              context.bloc<TaskCubit>().addDateToComplete(widget.index, date);
              Navigator.pop(context);
            });
          },
        ),
      ],
      contentPadding: EdgeInsets.all(12),
    );
  }
}
