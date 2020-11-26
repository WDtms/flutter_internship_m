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
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: TextFormField(
          onSaved: (String value) {
            widget.createInnerTask(value);
          },
          onEditingComplete: () {
            _key.currentState.save();
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.add),
              hintText: "Добавить шаг",
              hintStyle: TextStyle(
                color: Color(0xff1A9FFF),
              )
          ),
        ),
      ),
    );
  }
}
