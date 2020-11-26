import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/views/branches_page/branches_grid.dart';


class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(181, 201, 253, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff6200EE),
        title: Text('Оторвись от дивана!'),
      ),
      body: BranchesInfoDisplay(),
    );
  }
}
