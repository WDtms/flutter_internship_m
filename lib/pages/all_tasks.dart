import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';
import 'package:flutter_internship_v2/repository/repository.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/floating_create_button/form_dialog.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/popup_menu/popup_appbar.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/tasks_display/task_list.dart';

class TaskPage extends StatefulWidget {

  final Function() updateBranchesInfo;
  final String id;

  TaskPage({this.id, this.updateBranchesInfo});
  
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  TaskCubit cubit;
  
  @override
  void initState() {
    cubit = TaskCubit(TaskInteractor.getInstance(repository: Repository()));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: checkTheme(context, state, 1),
                appBar: AppBar(
                  backgroundColor: checkTheme(context, state, 2),
                  title: Text('Задачи'),
                  actions: [
                    BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                        if (state is TaskInUsageState) {
                          return PopupMenu1(
                              updateBranchesInfo: widget.updateBranchesInfo,
                              id: widget.id
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add_sharp),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context0) {
                          return FormDialog(
                            id: widget.id,
                            createTask: (String value) async {
                              await context.bloc<TaskCubit>().createNewTask(widget.id, value);
                              widget.updateBranchesInfo();
                            },
                          );
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
                        updateBranchesInfo: widget.updateBranchesInfo,
                        id: widget.id,
                        taskList: state.taskList,
                      );
                    }
                    context.bloc<TaskCubit>().getTasks(widget.id);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
            );
          }
      ),
    );
  }

  Color checkTheme(BuildContext context, ThemeState state, int index) {
    if (state is ThemeChangedState) {
      if (index == 1)
        return state.theme.values.toList().first;
      return state.theme.keys.toList().first;
    }
    if (index == 1)
      return Color.fromRGBO(181, 201, 253, 1);
    return Color(0xff6200EE);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}



