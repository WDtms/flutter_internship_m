
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/models/task_card_info.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_internship_v2/presentation/pages/current_task.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/animated_backgound.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TaskList extends StatelessWidget {

  final bool isFiltred;
  final Map<Color, Color> theme;
  final Function() updateBranchesInfo;
  final Map<String, TaskCardInfo> taskList;
  final String branchID;

  TaskList({this.updateBranchesInfo, this.taskList, this.branchID, this.theme, this.isFiltred});

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty ?
        AnimatedBackground(
          isFiltred: isFiltred,
        )
        : Stack (children: [
          _displayLines(context),
          ListView.builder(
        padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return _displayTask(context, taskList.keys.elementAt(index));
        },
      )
    ],
    );
  }

  Widget _displayLines(BuildContext context){
    return ListView(
      children: <Widget>[
        for (int i = 0; i<(MediaQuery.of(context).size.height/70).ceil(); i++)
          _oneLine(),
      ],
    );
  }

  Widget _oneLine(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 68, 16, 0),
      child: Container(
        height: 1,
        color: Colors.black12,
      ),
    );
  }

  Widget _displayTask(BuildContext context, String taskID) {
    return Dismissible(
      key: ValueKey('$taskID'),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) async {
        await context.bloc<TaskCubit>().deleteTask(taskID);
        updateBranchesInfo();
      },
      background: Container(
        margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
        padding: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          color: Colors.redAccent,
        ),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
            Icons.delete,
            color: Colors.white
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(16),
              color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                CircularCheckBox(
                  value: taskList[taskID].isDone,
                  activeColor: theme.keys.toList().first,
                  onChanged: (bool value) async {
                    await context.bloc<TaskCubit>().toggleTaskComplete(taskID);
                    updateBranchesInfo();
                  }
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context1) => CurrentTask(
                        theme: theme,
                        updateBranchesInfo: updateBranchesInfo,
                        updateTaskList: () {
                          context.bloc<TaskCubit>().updateTaskList();
                        },
                        branchID: branchID,
                        taskID: taskID,
                      )));
                    },
                    child: Builder(
                      builder: (BuildContext context) {
                        if (taskList[taskID].countAll == 0) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                taskList[taskID].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff424242),
                                ),
                              ),
                            ),
                          );
                        }
                        else {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      taskList[taskID].title,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${taskList[taskID].countCompleted} из ${taskList[taskID].countAll}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}