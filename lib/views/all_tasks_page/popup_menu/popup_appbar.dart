import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/services/popup_constans.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/bottom_dialog/bottom_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupMenu1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) {
        if (choice == Constants.delete){
          context.bloc<TaskCubit>().deleteAllCompletedTasks();
        }
        if (choice == Constants.hide){

        }
        if (choice == Constants.changeTheme){
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomDialog();
            }
          );
        }
      },
      itemBuilder: (BuildContext context) {
        return Constants.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}