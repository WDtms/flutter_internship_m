
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/repository/innertask_repository.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/flickr_card.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/floating_button.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/my_card.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/my_date_card.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/popup_appbar.dart';


class CurrentTask1 extends StatefulWidget {

  final Function() updateBranchesInfo;
  final Function() updateTaskList;
  final String branchID;
  final int indexTask;
  final Map<Color, Color> theme;

  CurrentTask1({this.branchID, this.indexTask, this.updateTaskList, this.updateBranchesInfo, this.theme});

  @override
  _CurrentTask1State createState() => _CurrentTask1State();
}

class _CurrentTask1State extends State<CurrentTask1> {

  CurrentTaskCubit cubit;

  @override
  void initState() {
    cubit = CurrentTaskCubit(InnerTaskInteractor(innerTaskRepository: InnerTaskRepository()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
        builder: (context, state) {
          if (state is CurrentTaskInitialState){
            context.bloc<CurrentTaskCubit>().getTask(widget.branchID, widget.indexTask);
            return CircularProgressIndicator();
          } else if (state is CurrentTaskInUsageState){
            return Scaffold(
              backgroundColor: widget.theme.values.toList().first,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0.0),
                      child: Row(
                        children: [
                         CurrentTaskFloatingButton(
                             toggleTaskComplete: () async {
                               bool isCompleted = state.task.isDone;
                               await context.bloc<CurrentTaskCubit>().editTask(
                                   widget.branchID,
                                   widget.indexTask,
                                   state.task.copyWith(isDone: !isCompleted),
                               );
                               widget.updateTaskList();
                               widget.updateBranchesInfo();
                             },
                             index: widget.indexTask
                         ),
                        ],
                      ),
                    ),
                    actions: [
                      PopupMenuCurrentTask(
                        onDelete: () async {
                          await cubit.deleteTask(widget.branchID, widget.indexTask);
                          await widget.updateTaskList();
                          await widget.updateBranchesInfo();
                          Navigator.of(context).pop();
                        },
                        updateBranchesInfo: widget.updateBranchesInfo,
                        updateTaskList: widget.updateTaskList,
                        branchID: widget.branchID,
                        indexTask: widget.indexTask,
                        task: state.task,
                      ),
                    ],
                    expandedHeight: 150,
                    snap: false,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(state.task.title),
                          background: Container(
                            color: widget.theme.keys.toList().first,
                          ),
                    ),
                    backgroundColor: widget.theme.keys.toList().first,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          MyCard(
                            theme: widget.theme,
                            updateTaskList: widget.updateTaskList,
                            indexTask: widget.indexTask,
                            branchID: widget.branchID,
                            description: state.task.description,
                            onSubmitDescription: (String value) async {
                              await context.bloc<CurrentTaskCubit>().editTask(widget.branchID, widget.indexTask, state.task.copyWith(description: value));
                              widget.updateTaskList();
                            },
                          ),
                          MyDateCard(indexTask: widget.indexTask, branchID: widget.branchID, task: state.task),
                          MyFlickrCard(theme: widget.theme),
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
