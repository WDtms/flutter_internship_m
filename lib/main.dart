import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

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
      home: TasksPage(),
    );
  }
}

