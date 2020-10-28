import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/tasks_service.dart';

class FormDialog extends StatefulWidget {
  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          Text('Создать задачу'),
          TextFormField(
              onSaved: (String value) {
                setState(() {
                  TaskService.tasks.add(
                      TaskModels(
                          taskTitle: value
                      )
                  );
                });
              },
              validator: (value){
                if(value.length > 40){
                  return 'Превышена допустимая длина задачи';
                }
                return null;
              }
          ),
          SimpleDialogOption(
            child: Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SimpleDialogOption(
            child: Text('Создать'),
            onPressed: () {
              if (_formKey.currentState.validate()){
                _formKey.currentState.save();
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}
