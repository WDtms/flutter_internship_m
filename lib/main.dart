import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/pages/main_page.dart';


void main() {

  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test_app',
      home: MainPage(),
    );
  }
}

