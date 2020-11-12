
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';

class MyCard1 extends StatefulWidget {

  final int index;

  MyCard1({this.index});

  @override
  _MyCardState1 createState() => _MyCardState1();
}

class _MyCardState1 extends State<MyCard1> {

  bool isCreating = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.fromLTRB(8, 30, 8, 8),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ]
          ),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskInUsageState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _displayDateOfCreation(state),
                    for (int i = 0; i <state.taskList[widget.index].innerTasks.length; i++)
                      _displayTask(widget.index, i, state),
                    _decideWhatToDisplay(widget.index),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          )
      ),
    );
  }

  Widget _displayDateOfCreation(TaskState state){
    if (state is TaskInUsageState){
      DateTime date = state.taskList[widget.index].dateOfCreation;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Создано: ${date.day.toString()}.${date.month.toString()}.${date.year.toString()}")
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  _checkTheme(ThemeState state){
    if (state is ThemeChangedState)
      return state.theme.keys.toList().first;
    return Color(0xff6200EE);
  }

  _displayTask(int index, int innerIndex, TaskState state) {
    if (state is TaskInUsageState) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Container(
          child: Row(
            children: [
              Checkbox(
                value: state.taskList[index].innerTasks[innerIndex].isDone,
                activeColor: _checkTheme(context.bloc<ThemeCubit>().state),
                onChanged: (bool value) {
                  context.bloc<TaskCubit>().toggleInnerTaskComplete(index, innerIndex);
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                      state.taskList[index].innerTasks[innerIndex].title,
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  context.bloc<TaskCubit>().deleteInnerTask(index, innerIndex);
                },
              )
            ],
          ),
        ),
      );
    }
  }


  _decideWhatToDisplay(int index){
    if (isCreating){
      return Column(
        children: <Widget>[
          _displayTextField(index),
          _displayAddTask()
        ],
      );
    }
    else {
      return _displayAddTask();
    }
  }

  _displayTextField(int index){
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextField(
        controller: _controller,
        onEditingComplete: () {
          context.bloc<TaskCubit>().createNewInnerTask(index, _controller.text);
          setState(() {
            _controller.text = "";
            isCreating = false;
          });
        },
      ),
    );
  }

  _displayAddTask(){
    return InkWell(
        onTap: () {
          setState(() {
            isCreating = true;
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 16),
              child: Icon(
                Icons.add_sharp,
                color: Color(0xff1A9FFF),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 16),
              child: Text(
                  'Добавить задачу',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff1A9FFF),
                  )
              ),
            ),
          ],
        )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}