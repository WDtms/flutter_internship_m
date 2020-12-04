
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/description.dart';

import 'create_inner_task.dart';
import 'inner_task_card.dart';

class MyCard extends StatefulWidget {

  final String description;
  final Function() updateTaskList;
  final Function(String value) onSubmitDescription;
  final Map<Color, Color> theme;

  MyCard({this.updateTaskList, this.theme, this.description, this.onSubmitDescription});

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
          child: BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
            builder: (context, state) {
              if (state is CurrentTaskInUsageState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _displayDateOfCreation(state.task.dateOfCreation),
                    for (int i = 0; i <state.task.innerTasks.length; i++)
                      InnerTaskCard(
                        activeColor: widget.theme.keys.toList().first,
                        innerTaskID: state.task.innerTasks.values.toList().elementAt(i).id,
                        updateTaskList: widget.updateTaskList,
                        task: state.task,
                      ),
                    CreateInnerTask(
                      createInnerTask: (String value) async {
                        await context.bloc<CurrentTaskCubit>().createNewInnerTask(value);
                        widget.updateTaskList();
                      },
                    ),
                    Description(
                      description: widget.description,
                      onSubmitDescription: (String value) {
                        widget.onSubmitDescription(value);
                      },
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          )
      ),
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

  _decideHowToDisplay(int val) {
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