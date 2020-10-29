import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/services/popup_constans.dart';

typedef CreateTaskCallback(String taskName);

class PopupMenu extends StatefulWidget {

  final CreateTaskCallback actionChoice;

  PopupMenu({this.actionChoice});

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: widget.actionChoice,
      itemBuilder: (BuildContext context) {
        return Constants.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
