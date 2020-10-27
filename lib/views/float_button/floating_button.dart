import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/views/float_button/alert_dialog.dart';

class FloatingButton extends StatefulWidget{

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton>{

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: IconButton(
        icon: Icon(Icons.add_sharp),
        onPressed: () {
          
        },
      ),
      backgroundColor: Colors.teal,
    );
  }
}
