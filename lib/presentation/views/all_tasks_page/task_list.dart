
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_internship_v2/presentation/constants/my_images.dart';
import 'package:flutter_internship_v2/presentation/pages/current_task.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TaskList extends StatelessWidget {

  final Map<Color, Color> theme;
  final Function() updateBranchesInfo;
  final Map<String, Task> taskList;
  final String branchID;

  TaskList({this.updateBranchesInfo, this.taskList, this.branchID, this.theme});

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty ?
        _displayImages()
        : ListView.builder(
      padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return _displayTask(context, taskList.keys.elementAt(index));
      },
    );
  }

  Widget _displayImages(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(home_image),
          Container(
            height: 3,
          ),
          SvgPicture.asset(home_text),
        ],
      ),
    );
  }

  Widget _displayTask(BuildContext context, String taskID) {
    return Dismissible(
      key: UniqueKey(),
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
                    bool isCompleted = taskList[taskID].isDone;
                    context.bloc<TaskCubit>().editTask(
                      taskID,
                      taskList[taskID].copyWith(isDone: !isCompleted),
                    );
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
                        if (taskList[taskID].innerTasks.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                taskList[taskID].title,
                                style: TextStyle(
                                  fontSize: 18
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
                                    '${_countCompletedInnerTasks(taskID)} из ${taskList[taskID].innerTasks.length}',
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

  int _countCompletedInnerTasks(String taskID){
    int count = 0;
    for (int i = 0; i<taskList[taskID].innerTasks.length; i++){
      if (taskList[taskID].innerTasks.values.elementAt(i).isDone)
        count++;
    }
    return count;
  }
}