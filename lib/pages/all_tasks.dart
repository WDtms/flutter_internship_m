import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/form_dialog.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/popup_menu/popup_appbar.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/tasks_display/task_list.dart';

class TaskPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: checkTheme(context, state, 1),
              appBar: AppBar(
                backgroundColor: checkTheme(context, state, 2),
                leading: Icon(Icons.arrow_back_sharp),
                title: Text('Задачи'),
                actions: [
                  BlocBuilder<TaskCubit, TaskState>(
                    builder: (context, state) {
                      if (state is TaskInUsageState) {
                        return PopupMenu1();
                      }
                      else {
                        return SizedBox.shrink();
                      }
                    },
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add_sharp),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FormDialog();
                      }
                  );
                },
                backgroundColor: Colors.teal,
              ),
              body: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is TaskInUsageState) {
                    return TaskList1(
                      taskList: state.taskList,
                    );
                  }
                  else {
                    context.bloc<TaskCubit>().getTasks();
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
          );
        }
        );
  }

  Color checkTheme(BuildContext context, ThemeState state, int index){
    if (state is ThemeChangedState){
      if (index == 1){
        return state.theme.values.toList().first;
      }
      else {
        return state.theme.keys.toList().first;
      }
    }
    else {
      if (index == 1){
        return Color.fromRGBO(181, 201, 253, 1);
      }
      else
        return Color(0xff6200EE);
    }
  }
}



