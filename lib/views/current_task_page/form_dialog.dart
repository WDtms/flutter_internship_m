

import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';

typedef ChangeTaskNameCallBack(int index, String value);
typedef ChangeTaskNameAtCurrentPageCallBack(String value);

class FormDialogCurrentTask extends StatefulWidget {

  final ChangeTaskNameAtCurrentPageCallBack changeTaskNameAtCurrentPage;
  final ChangeTaskNameCallBack changeTaskName;
  final List<TaskModel> tasks;
  final int index;

  FormDialogCurrentTask({this.tasks, this.index, this.changeTaskName, this.changeTaskNameAtCurrentPage});

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialogCurrentTask> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          Text('Редактирование'),
          TextFormField(
              onSaved: (String value) {
                setState(() {
                  widget.changeTaskName(widget.index, value);
                  widget.changeTaskNameAtCurrentPage(value);
                });
              },
              validator: (value){
                if(value.length > 40){
                  return 'Превышена допустимая длина задачи';
                }
                return null;
              }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Text('Выбрать'),
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}