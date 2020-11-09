
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/views/current_task_page/floating_button/floating_button.dart';
import 'file:///C:/Users/Shepelev.AA1/AndroidStudioProjects/flutter_internship_v2/lib/views/current_task_page/cards/my_card.dart';
import 'file:///C:/Users/Shepelev.AA1/AndroidStudioProjects/flutter_internship_v2/lib/views/current_task_page/cards/my_date_card.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/popup_appbar.dart';

class CurrentTask1 extends StatelessWidget {

  final int index;

  CurrentTask1({this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: checkTheme(context, state, 1),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Row(
                    children: [
                      CurrentTaskFloatingButton(index: index),
                    ],
                  ),
                ),
                actions: [
                  PopupMenuCurrentTask(index: index),
                ],
                expandedHeight: 150,
                snap: false,
                floating: false,
                pinned: true,
                flexibleSpace: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: displayTaskTitle(state, index),
                      background: Container(
                        color: checkTheme(context, context.bloc<ThemeCubit>().state, 2),
                      ),
                    );
                  },
                ),
                backgroundColor: checkTheme(context, state, 2),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      MyCard1(index: index),
                      MyDateCard(index: index),
                    ]
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Color checkTheme(BuildContext context, ThemeState state, int index){
    if (state is ThemeChangedState){
      if (index == 1){
        return state.theme.values.toList().first;
      }
      else {
        return state.theme.keys.toList().first;
      }
    }
    else {
      if (index == 1){
        return Color.fromRGBO(181, 201, 253, 1);
      }
      else
        return Color(0xff6200EE);
    }
  }

  displayTaskTitle(TaskState state, int index) {
    if (state is TaskInUsageState){
      return Text(state.taskList[index].title,
      style: TextStyle(
        fontSize: 16
      ),);
    }
  }

/*
  Widget buildFab(){
    final bloc = BlocProvider.of(context).taskListBloc;

    final double defaultTopMargin = 150;
    final double scaleStart = 96;
    final double scaleEnd = scaleStart/2;

    double top = defaultTopMargin;
    double scale = 1;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart){
        scale = 1;
      }
      else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset)/scaleEnd;
      }
      else {
        scale = 0;
      }
    }
    return Positioned(
      top: top,
      left: 16,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: StreamBuilder(
          stream: bloc.tasks,
          builder: (context, snapshot) {
            return FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {

              },
              child: Builder(
                builder: (_) {
                  if (!snapshot.hasData){
                    return Container();
                  }

                  if (snapshot.data[widget.index].isDone)
                    return Icon(Icons.close);
                  else
                    return Icon(Icons.check);
                },
              ),
            );
          }
        ),
      ),
    );
  }

 */


}
