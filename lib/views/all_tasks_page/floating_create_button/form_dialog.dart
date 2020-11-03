import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/bloc/bloc_provider.dart';



class FormDialog extends StatefulWidget {

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).taskListBloc;
    return Form(
      key: _formKey,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          Text('Создать задачу'),
          StreamBuilder<Object>(
            stream: bloc.tasks,
            builder: (context, snapshot) {
              return TextFormField(
                  onSaved: (String value) {
                    bloc.addNewTask(value);
                  },
                  validator: (value){
                    if(value.length > 40){
                      return 'Превышена допустимая длина задачи';
                    }
                    return null;
                  }
              );
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
