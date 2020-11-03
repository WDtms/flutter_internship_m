import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/form_dialog.dart';

class FloatingButton1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      child: Icon(Icons.add_sharp),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FormDialog();
            }
        );
      },
      backgroundColor: Colors.teal,
    );
  }
}