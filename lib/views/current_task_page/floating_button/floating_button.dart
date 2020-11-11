import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';

class CurrentTaskFloatingButton extends StatefulWidget {

  final Function() toggleInnerTaskComplete;
  final index;

  CurrentTaskFloatingButton({this.index, this.toggleInnerTaskComplete});

  @override
  _CurrentTaskFloatingButtonState createState() => _CurrentTaskFloatingButtonState();
}

class _CurrentTaskFloatingButtonState extends State<CurrentTaskFloatingButton> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
        if (state is TaskInUsageState){
          return Transform.translate(
            key: _key,
            offset: Offset(20, 38),
              child: FloatingActionButton(
                backgroundColor: Colors.teal,
                child: Builder(
                  builder: (context) {
                    if (state.taskList[widget.index].isDone)
                      return Icon(Icons.close);
                    return Icon(Icons.check);
                  },
                ),
                onPressed: () {
                  widget.toggleInnerTaskComplete();
                },
              ),
          );
        }
        return SizedBox.shrink();
        }
        );
  }
}
