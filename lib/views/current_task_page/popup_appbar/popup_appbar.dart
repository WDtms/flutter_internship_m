
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/services/popup_current_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/form_dialog.dart';

class PopupMenuCurrentTask extends StatelessWidget {

  final Function() updateBranchesInfo;
  final Function() updateTaskList;
  final String id;
  final int index;

  PopupMenuCurrentTask({this.id, this.index, this.updateTaskList, this.updateBranchesInfo});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        if (choice == ConstantsOnPopUpCurrentTask.delete) {
          await context.bloc<CurrentTaskCubit>().deleteTask(id, index);
          await updateTaskList();
          updateBranchesInfo();
          Navigator.of(context).pop();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context1) {
                return FormDialogCurrentTask(
                  index: index,
                  editTaskName: (String value) async {
                    await context.bloc<CurrentTaskCubit>().editTaskName(id, index, value);
                    updateTaskList();
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
