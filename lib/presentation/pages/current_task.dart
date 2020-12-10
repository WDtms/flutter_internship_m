
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/flickr_card.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/my_card.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/my_date_card.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/sliver_app_bar.dart';


class CurrentTask extends StatefulWidget {

  final Function() updateBranchesInfo;
  final Function() updateTaskList;
  final String branchID;
  final String taskID;
  final Map<Color, Color> theme;

  CurrentTask({this.branchID, this.taskID, this.updateTaskList, this.updateBranchesInfo, this.theme});

  @override
  _CurrentTaskState createState() => _CurrentTaskState();
}

class _CurrentTaskState extends State<CurrentTask> {

  CurrentTaskCubit cubit;

  @override
  void initState() {
    cubit = CurrentTaskCubit(InnerTaskInteractor(), widget.branchID, widget.taskID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
        builder: (context, state) {
          if (state is CurrentTaskInitialState){
            context.bloc<CurrentTaskCubit>().getTask();
            return CircularProgressIndicator();
          } else if (state is CurrentTaskInUsageState){
            return Scaffold(
              backgroundColor: widget.theme.values.toList().first,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      appBarColor: widget.theme.keys.toList().first,
                      task: state.task,
                      updateTaskList: widget.updateTaskList,
                      updateBranchesInfo: widget.updateBranchesInfo,
                    ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          MyCard(
                            theme: widget.theme,
                            updateTaskList: widget.updateTaskList,
                            description: state.task.description,
                            onSubmitDescription: (String value) async {
                              await context.bloc<CurrentTaskCubit>().editTask(state.task.copyWith(description: value));
                              widget.updateTaskList();
                            },
                          ),
                          MyDateCard(task: state.task),
                          MyFlickrCard(theme: widget.theme, task: state.task, taskID: widget.taskID, branchID: widget.branchID, addImage: (String v) async {
                            List<String> imagesList = state.task.imagesPath;
                            imagesList.add(v);
                            context.bloc<CurrentTaskCubit>().editTask(state.task.copyWith(imagesPath: imagesList));
                          },),
                        ]
                    ),
                  )
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
