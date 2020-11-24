
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:uuid/uuid.dart';

class MyCard extends StatefulWidget {

  final Function() updateTaskList;
  final Map<Color, Color> theme;
  final int indexTask;
  final String branchID;

  MyCard({this.branchID, this.indexTask, this.updateTaskList, this.theme});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  bool isCreating = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.fromLTRB(16, 30, 16, 8),
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
                      _displayTask(widget.branchID, widget.indexTask, i, state),
                    _decideWhatToDisplay(widget.branchID, widget.indexTask),
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
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                "Создано: ${date.day.toString()}.${date.month.toString()}.${date.year.toString()}",
                style: TextStyle(
                  fontSize: 12
                ),
              )
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  _displayTask(String branchID, int indexTask, int indexInnerTask, CurrentTaskState state) {
    if (state is CurrentTaskInUsageState) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Container(
          child: Row(
            children: [
              Checkbox(
                value: state.task.innerTasks[indexInnerTask].isDone,
                activeColor: widget.theme.keys.toList().first,
                onChanged: (bool value) async {
                  bool isCompleted = state.task.innerTasks[indexInnerTask].isDone;
                  await context.bloc<CurrentTaskCubit>().editInnerTask(
                      widget.branchID,
                      widget.indexTask,
                      indexInnerTask,
                      state.task.innerTasks[indexInnerTask].copyWith(isDone: !isCompleted));
                  widget.updateTaskList();
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                      state.task.innerTasks[indexInnerTask].title,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  await context.bloc<CurrentTaskCubit>().deleteInnerTask(branchID, indexTask, indexInnerTask);
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
        onEditingComplete: () async {
          await context.bloc<CurrentTaskCubit>().createNewInnerTask(
              id,
              index,
              InnerTask(
                id: Uuid().v4(),
                title: _controller.text,
              )
          );
          widget.updateTaskList();
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