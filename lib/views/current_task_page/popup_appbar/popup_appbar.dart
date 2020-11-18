
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/popup_current_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/form_dialog.dart';

class PopupMenuCurrentTask extends StatelessWidget {

  final Function() updateBranchesInfo;
  final Function() updateTaskList;
  final String branchID;
  final Task task;
  final int indexTask;

  PopupMenuCurrentTask({this.branchID, this.indexTask, this.updateTaskList, this.updateBranchesInfo, this.task});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        if (choice == ConstantsOnPopUpCurrentTask.delete) {
          await context.bloc<CurrentTaskCubit>().deleteTask(branchID, indexTask);
          await updateTaskList();
          updateBranchesInfo();
          Navigator.of(context).pop();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context1) {
                return FormDialogCurrentTask(
                  index: indexTask,
                  editTaskName: (String value) async {
                    await context.bloc<CurrentTaskCubit>().editTask(
                        branchID,
                        indexTask,
                        task.copyWith(
                          title: value,
                        ),
                    );
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
