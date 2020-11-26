import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';


class CurrentTaskFloatingButton extends StatefulWidget {

  final Function() toggleTaskComplete;
  final index;

  CurrentTaskFloatingButton({this.index, this.toggleTaskComplete});

  @override
  _CurrentTaskFloatingButtonState createState() => _CurrentTaskFloatingButtonState();
}

class _CurrentTaskFloatingButtonState extends State<CurrentTaskFloatingButton> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
        builder: (context, state) {
        if (state is CurrentTaskInUsageState){
          return Transform.translate(
            key: _key,
            offset: Offset(20, 38),
              child: FloatingActionButton(
                backgroundColor: Color(0xff01A39D),
                child: Builder(
                  builder: (context) {
                    if (state.task.isDone)
                      return Icon(Icons.close);
                    return Icon(Icons.check);
                  },
                ),
                onPressed: () {
                  widget.toggleTaskComplete();
                },
              ),
          );
        }
        return SizedBox.shrink();
        }
        );
  }
}
