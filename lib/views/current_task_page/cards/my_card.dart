
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';

class MyCard1 extends StatefulWidget {

  final Function() updateTaskList;
  final int index;
  final String id;

  MyCard1({this.id, this.index, this.updateTaskList});

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
          child: BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
            builder: (context, state) {
              if (state is CurrentTaskInUsageState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _displayDateOfCreation(state),
                    for (int i = 0; i <state.task.innerTasks.length; i++)
                      _displayTask(widget.id, widget.index, i, state),
                    _decideWhatToDisplay(widget.id, widget.index),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          )
      ),
    );
  }

  Widget _displayDateOfCreation(CurrentTaskState state){
    if (state is CurrentTaskInUsageState){
      DateTime date = state.task.dateOfCreation;
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

  _displayTask(String id, int index, int innerIndex, CurrentTaskState state) {
    if (state is CurrentTaskInUsageState) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Container(
          child: Row(
            children: [
              Checkbox(
                value: state.task.innerTasks[innerIndex].isDone,
                activeColor: _checkTheme(context.bloc<ThemeCubit>().state),
                onChanged: (bool value) async {
                  await context.bloc<CurrentTaskCubit>().toggleInnerTaskComplete(id, index, innerIndex);
                  widget.updateTaskList();
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                      state.task.innerTasks[innerIndex].title,
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  await context.bloc<CurrentTaskCubit>().deleteInnerTask(id, index, innerIndex);
                  widget.updateTaskList();
                },
              )
            ],
          ),
        ),
      );
    }
  }


  _decideWhatToDisplay(String id, int index){
    if (isCreating){
      return Column(
        children: <Widget>[
          _displayTextField(id, index),
          _displayAddTask()
        ],
      );
    }
    else {
      return _displayAddTask();
    }
  }

  _displayTextField(String id, int index){
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextField(
        controller: _controller,
        onEditingComplete: () {
          context.bloc<CurrentTaskCubit>().createNewInnerTask(id, index, _controller.text);
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