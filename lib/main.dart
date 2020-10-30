import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';
import 'package:flutter_internship_v2/services/tasks.dart';
import 'package:flutter_internship_v2/services/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  Color _appBarColor;
  Color _backGroundColor;
  final List<TaskModel> tasks = TaskService.tasks;

  @override
  void initState() {
    super.initState();
    _changeTheme(0);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Internship_v2",
      theme: ThemeData(
          textTheme: TextTheme(
              bodyText2: TextStyle(
                  fontSize: 16
              )
          )
      ),
      home: TasksPage(
          tasks: tasks,
          appBarColor: _appBarColor,
          backGroundColor: _backGroundColor,
          changeTheme: _changeTheme),
    );
  }

  void _changeTheme(int value){
    setState(() {
      for (var item in ListOfThemes.themes[value].entries){
        _appBarColor = item.key;
        _backGroundColor = item.value;
      }
    });
  }

}

