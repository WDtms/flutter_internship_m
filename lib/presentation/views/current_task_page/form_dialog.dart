
import 'package:flutter/material.dart';

class FormDialogCurrentTask extends StatefulWidget {

  final String taskName;
  final Function(String value) editTaskName;

  FormDialogCurrentTask({this.taskName, this.editTaskName});

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
          Text(
            'Редактирование',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          TextFormField(
              decoration: InputDecoration(
                hintText: "${widget.taskName}"
              ),
              onSaved: (String value) {
                widget.editTaskName(value);
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
                child: Text(
                  'ОТМЕНА',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'ВЫБРАТЬ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
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