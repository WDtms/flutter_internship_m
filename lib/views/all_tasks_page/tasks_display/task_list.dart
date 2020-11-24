
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/pages/current_task.dart';
import 'package:flutter_internship_v2/styles/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TaskList1 extends StatelessWidget {

  final Map<Color, Color> theme;
  final Function() updateBranchesInfo;
  final List<Task> taskList;
  final String branchID;

  TaskList1({this.updateBranchesInfo, this.taskList, this.branchID, this.theme});

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty ?
        _displayImages()
        : ListView.builder(
      padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return _displayTask(context, index);
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

  Widget _displayTask(BuildContext context, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) async {
        context.bloc<TaskCubit>().deleteTask(branchID, index);
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
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(8),
              color: Colors.white
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskList[index].isDone,
                activeColor: theme.keys.toList().first,
                onChanged: (bool value) async {
                  bool isCompleted = taskList[index].isDone;
                  context.bloc<TaskCubit>().editTask(branchID, index, taskList[index].copyWith(isDone: !isCompleted));
                  updateBranchesInfo();
                }
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context1) => CurrentTask1(
                      theme: theme,
                      updateBranchesInfo: updateBranchesInfo,
                      updateTaskList: () {
                        context.bloc<TaskCubit>().updateTaskList(branchID);
                      },
                      branchID: branchID,
                      indexTask: index,
                    )));
                  },
                  child: Builder(
                    builder: (BuildContext context) {

                      if (taskList[index].innerTasks.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(taskList[index].title),
                        );
                      }

                      else {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Text(taskList[index].title),
                              ),
                              Text('${_countCompletedInnerTasks(index)} из ${taskList[index].innerTasks.length}')
                            ],
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
    );
  }

  int _countCompletedInnerTasks(int index){
    int count = 0;
    for (InnerTask task in taskList[index].innerTasks){
      if (task.isDone){
        count++;
      }
    }
    return count;
  }
}