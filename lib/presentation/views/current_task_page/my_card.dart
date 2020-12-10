
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/description.dart';

import 'create_inner_task.dart';
import 'inner_task_card.dart';

class MyCard extends StatefulWidget {

  final Function() updateTaskList;
  final Map<Color, Color> theme;
  final Task task;

  MyCard({this.updateTaskList, this.theme, this.task});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _displayDateOfCreation(widget.task.dateOfCreation),
              for (int i = 0; i <widget.task.innerTasks.length; i++)
                InnerTaskCard(
                  activeColor: widget.theme.keys.toList().first,
                  updateTaskList: widget.updateTaskList,
                  innerTask: widget.task.innerTasks[widget.task.innerTasks.values.elementAt(i).id],
                ),
              CreateInnerTask(
                createInnerTask: (String value) async {
                  await context.bloc<CurrentTaskCubit>().createNewInnerTask(value);
                  widget.updateTaskList();
                  },
              ),
              Description(
                description: widget.task.description,
                onSubmitDescription: (String value) async {
                  await context.bloc<CurrentTaskCubit>().editDescription(value);
                  },
              ),
            ],
          ),
      )
    );
  }

  Widget _displayDateOfCreation(int dateOfCreation){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateOfCreation);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              "Создано: ${_decideHowToDisplay(date.day)}.${_decideHowToDisplay(date.month)}.${date.year.toString()}",
              style: TextStyle(
                  fontSize: 12
                ),
            )
          ),
        ],
      );
  }

  String _decideHowToDisplay(int val) {
    if (val<10)
      return "0$val";
    return "$val";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}