import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/bloc/bloc_provider.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';
import 'package:flutter_internship_v2/repository/task_repository.dart';
import 'bloc/blocs/task_list.dart';
import 'models/task_list.dart';

void main() {
  var _taskRepository = TaskRepository(TaskList());

  runApp(
    BlocProvider(
      taskListBloc: TaskListBloc(_taskRepository),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sdsd',
      home: TaskPage(),
    );
  }
}

