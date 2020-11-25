import 'package:flutter/material.dart';

class CreateInnerTask extends StatefulWidget {

  final Function(String value) createInnerTask;

  CreateInnerTask({this.createInnerTask});

  @override
  _CreateInnerTaskState createState() => _CreateInnerTaskState();
}

class _CreateInnerTaskState extends State<CreateInnerTask> {

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Form(
        key: _key,
        child: TextFormField(
          maxLength: 40,
          onSaved: (String value) {
            widget.createInnerTask(value);
            },
          onEditingComplete: () {
            _key.currentState.save();
            },
          validator: (value){
            if(value.length > 40){
              return 'Превышена допустимая длина задачи';
            }
            return null;
            },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.add,
              color: Color(0xff1A9FFF),
            ),
            hintText: "Добавить шаг",
            hintStyle: TextStyle(
              color: Color(0xff1A9FFF),
            ),
          ),
        ),
      ),
    );
  }
}
