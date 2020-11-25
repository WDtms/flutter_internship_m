
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/create_inner_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/inner_task_card.dart';
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
                    _displayDateOfCreation(state.task.dateOfCreation),
                    for (int i = 0; i <state.task.innerTasks.length; i++)
                      InnerTaskCard(
                        activeColor: widget.theme.keys.toList().first,
                        indexInnerTask: i,
                        indexTask: widget.indexTask,
                        updateTaskList: widget.updateTaskList,
                        task: state.task,
                        branchID: widget.branchID,
                      ),
                    CreateInnerTask(
                      createInnerTask: (String value) {
                        context.bloc<CurrentTaskCubit>().createNewInnerTask(widget.branchID, widget.indexTask, InnerTask(
                          id: Uuid().v4(),
                          title: value,
                        ));
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

  Widget _displayDateOfCreation(DateTime date){
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}