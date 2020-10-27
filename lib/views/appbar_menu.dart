import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarMenu extends StatefulWidget{

  @override
  _AppBarMenuState createState() => _AppBarMenuState();
}

class _AppBarMenuState extends State<AppBarMenu>{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(Icons.more_vert_rounded),
        onPressed: () {

        },
      ),
    );
  }
}