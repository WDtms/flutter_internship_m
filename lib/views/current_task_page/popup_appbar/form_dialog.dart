
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';

class FormDialogCurrentTask extends StatefulWidget {

  final int index;

  FormDialogCurrentTask({this.index});

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
          BlocBuilder<TaskCubit, TaskState> (
            builder: (context, state) {
              return TextFormField(
                  onSaved: (String value) {
                    context.bloc<TaskCubit>().editTaskName(widget.index, value);
                  },
                  validator: (value){
                    if(value.length > 40){
                      return 'Превышена допустимая длина задачи';
                    }
                    return null;
                  }
              );
            },
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