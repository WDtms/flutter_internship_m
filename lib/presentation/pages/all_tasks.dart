
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/repository/task_repository.dart';
import 'package:flutter_internship_v2/data/repository/theme_repository.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_internship_v2/presentation/bloc/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/form_dialog.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/popup_appbar.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/task_list.dart';


class AllTasksPage extends StatefulWidget {

  final Function() updateBranchesInfo;
  final String branchID;
  final String branchTitle;

  AllTasksPage({this.branchID, this.updateBranchesInfo, this.branchTitle});
  
  @override
  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {

  TaskCubit taskCubit;
  ThemeCubit themeCubit;
  
  @override
  void initState() {
    themeCubit = ThemeCubit(ThemeRepository(), currentBranchID: widget.branchID);
    taskCubit = TaskCubit(TaskInteractor(), currentBranchID: widget.branchID);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => taskCubit),
        BlocProvider(create: (context) => themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (state is ThemeInitialState){
              themeCubit.getThemeBranch();
              return CircularProgressIndicator();
            } else if (state is ThemeUsageState){
              Map<Color, Color> theme = state.theme;
              return Scaffold(
                  backgroundColor: theme.values.toList().first,
                  appBar: AppBar(
                    backgroundColor: theme.keys.toList().first,
                    title: Text('Задачи ветки ${widget.branchTitle}'),
                    actions: [
                      BlocBuilder<TaskCubit, TaskState>(
                        builder: (context, state) {
                          if (state is TaskInUsageState) {
                            return PopupMenu(
                              theme: theme,
                              isHidden: state.isHidden,
                              updateBranchesInfo: widget.updateBranchesInfo,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add_sharp),
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context0) {
                            return FormDialog(
                              createTask: (String taskName, DateTime dateToComplete, DateTime notificationTime) async {
                                await taskCubit.createNewTask(dateToComplete, notificationTime, taskName);
                                widget.updateBranchesInfo();
                              },
                            );
                          }
                      );
                    },
                    backgroundColor: Color(0xff01A39D),
                  ),
                  body: BlocBuilder<TaskCubit, TaskState>(
                    builder: (context, state) {
                      if (state is TaskLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if (state is TaskInUsageState) {
                        return TaskList(
                          isFiltred: state.isHidden,
                          theme: theme,
                          updateBranchesInfo: widget.updateBranchesInfo,
                          branchID: widget.branchID,
                          taskList: state.taskList,
                        );
                      }
                      taskCubit.getTasks();
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
              );
            }
            return CircularProgressIndicator();
          }
      ),
    );
  }

  @override
  void dispose() {
    taskCubit.close();
    themeCubit.close();
    super.dispose();
  }
}



