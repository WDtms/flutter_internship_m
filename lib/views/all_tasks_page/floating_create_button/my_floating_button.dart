import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/form_dialog.dart';

typedef CreateTaskCallback(String taskName);

class FloatingButton extends StatefulWidget {

  final CreateTaskCallback onTaskCreate;

  FloatingButton({this.onTaskCreate});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_sharp),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FormDialog(onTaskCreate: widget.onTaskCreate);
            }
        );
      },
      backgroundColor: Colors.teal,
    );
  }
}
