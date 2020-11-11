
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task_cubit/current_task_cubit.dart';
import 'package:flutter_internship_v2/services/popup_current_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/form_dialog.dart';

class PopupMenuCurrentTask extends StatelessWidget {

  final String id;
  final int index;

  PopupMenuCurrentTask({this.id, this.index});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) {
        if (choice == ConstantsOnPopUpCurrentTask.delete){
          context.bloc<CurrentTaskCubit>().deleteTask(id, index);
          Navigator.of(context).pop();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FormDialogCurrentTask(
                  index: index,
                  editTaskName: (String value) {
                    context.bloc<CurrentTaskCubit>().editTaskName(id, index, value);
                  },
                );
              }
              );
        }
        },
      itemBuilder: (BuildContext context) {
        return ConstantsOnPopUpCurrentTask.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
        },
    );
  }
}
