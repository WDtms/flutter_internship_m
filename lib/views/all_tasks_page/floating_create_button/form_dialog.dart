import 'package:flutter/material.dart';

typedef CreateTaskCallback(String taskName);

class FormDialog extends StatefulWidget {

  final CreateTaskCallback onTaskCreate;

  FormDialog({this.onTaskCreate});

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
                  widget.onTaskCreate(value);
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
                child: Text('Создать'),
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
