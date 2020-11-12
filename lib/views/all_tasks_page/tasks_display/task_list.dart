
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/pages/current_task.dart';
import 'package:flutter_internship_v2/styles/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TaskList1 extends StatelessWidget {

  final List<TaskModel> taskList;

  TaskList1({this.taskList});

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

  int _countCompletedInnerTasks(int index){
    int count = 0;
    for (InnerTask task in taskList[index].innerTasks){
      if (task.isDone){
        count++;
      }
    }
    return count;
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
      onDismissed: (DismissDirection direction) {
        context.bloc<TaskCubit>().deleteTask(index);
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
                activeColor: _checkTheme(context.bloc<ThemeCubit>().state),
                onChanged: (bool value) {
                  context.bloc<TaskCubit>().toggleTaskComplete(index);
                }
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentTask1(
                      index: index,
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

  Color _checkTheme(ThemeState state) {
    if (state is ThemeChangedState)
      return state.theme.keys.toList().first;
    else
      return Color(0xff6200EE);
  }
}