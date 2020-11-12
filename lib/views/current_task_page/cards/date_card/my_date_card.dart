import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/views/current_task_page/cards/date_card/select_time_dialog.dart';

class MyDateCard extends StatelessWidget {

  final int index;
  final String id;

  MyDateCard({this.index, this.id});

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
        child: Column(
          children: [
            BlocBuilder<CurrentTaskCubit, CurrentTaskState>(
              builder: (context, state) {
                if (state is CurrentTaskInUsageState){
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: _displayDateToComplete(state),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context1) {
                                  return SelectTimeDialog(
                                    dateTime: state.task.dateOfCreation,
                                    selectDateToComplete: (DateTime dateTime) {
                                      context.bloc<CurrentTaskCubit>().addDateToComplete(id, index, dateTime);
                                    },
                                  );
                                }
                                );
                            },
                        ),
                      ),
                    ],
                  );
                }
                else{
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayDateToComplete(CurrentTaskState state){
    if (state is CurrentTaskInUsageState){
      if (state.task.dateToComplete == null)
        return Text('Добавить дату выполнения');
      DateTime date = state.task.dateToComplete;
      return Text("${date.day.toString()}.${date.month.toString()}.${date.year.toString()}");
    }
    return const SizedBox.shrink();
  }
}
