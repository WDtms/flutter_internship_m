
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task_cubit/current_task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';
import 'package:flutter_internship_v2/views/current_task_page/cards/date_card/my_date_card.dart';
import 'package:flutter_internship_v2/views/current_task_page/cards/my_card.dart';
import 'package:flutter_internship_v2/views/current_task_page/floating_button/floating_button.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/popup_appbar.dart';

class CurrentTask1 extends StatefulWidget {

  final String id;
  final int index;

  CurrentTask1({this.id, this.index});

  @override
  _CurrentTask1State createState() => _CurrentTask1State();
}

class _CurrentTask1State extends State<CurrentTask1> {

  CurrentTaskCubit cubit;

  @override
  void initState() {
    cubit = CurrentTaskCubit(TaskInteractor.getInstance());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is CurrentTaskInitialState){
            context.bloc<CurrentTaskCubit>().getTask(widget.id, widget.index);
            return CircularProgressIndicator();
          } else if (state is CurrentTaskInUsageState){
            return Scaffold(
              backgroundColor: checkTheme(context, state, 1),
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0.0),
                      child: Row(
                        children: [
                          CurrentTaskFloatingButton(index: widget.index),
                        ],
                      ),
                    ),
                    actions: [
                      PopupMenuCurrentTask(index: widget.index),
                    ],
                    expandedHeight: 150,
                    snap: false,
                    floating: false,
                    pinned: true,
                    flexibleSpace: BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
                      builder: (context, state) {
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          title: _displayTaskTitle(state, widget.index),
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
                          MyCard1(index: widget.index, id: widget.id),
                          MyDateCard(index: widget.index, id: widget.id),
                        ]
                    ),
                  )
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
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

  _displayTaskTitle(CurrentTaskState state, int index) {
    if (state is CurrentTaskInUsageState){
      return Text(state.task.title,
      style: TextStyle(
        fontSize: 16
      ),);
    }
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
