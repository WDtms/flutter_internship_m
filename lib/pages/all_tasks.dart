import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/my_floating_button.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/popup_menu/popup_appbar.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/tasks_display/task_list.dart';

typedef ChangeThemeCallBack(int value);

class TaskPage extends StatelessWidget {

  Color appBarColor  = Color(0xff6200EE);
  Color backGroundColor = Color.fromRGBO(181, 201, 253, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: Icon(Icons.arrow_back_sharp),
        title: Text('Задачи'),
        actions: [
          PopupMenu(),
        ],
      ),
      floatingActionButton: FloatingButton1(),
      body: TaskList1(
        appBarColor: appBarColor,
        backGroundColor: backGroundColor,
      ),
    );
  }
}



