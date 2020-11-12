import 'package:flutter/material.dart';

class FormDialog extends StatefulWidget {

  final String id;
  final Function(String value, DateTime dateTimeToComplete) createTask;

  FormDialog({this.id, this.createTask});

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {

  final _formKey = GlobalKey<FormState>();
  DateTime dateTimeToComplete;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          Text('Создать задачу'),
          InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2022),
              ).then((date) {
                dateTimeToComplete = date;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffB5C9FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Text(
                  'Дата выполнения'
                ),
              ),
            ),
          ),
          TextFormField(
              onSaved: (String value) {
                widget.createTask(value, dateTimeToComplete);
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

