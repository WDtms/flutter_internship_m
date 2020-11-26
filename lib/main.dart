import 'package:flutter/material.dart';
import 'presentation/pages/main_page.dart';

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

