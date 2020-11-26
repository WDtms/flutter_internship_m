
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/constants/popup_current_task.dart';
import 'package:flutter_internship_v2/presentation/cubit/current_task/current_task_cubit.dart';

import 'form_dialog.dart';



class PopupMenuCurrentTask extends StatelessWidget {

  final Function() onDelete;
  final Function() updateBranchesInfo;
  final Function() updateTaskList;
  final String branchID;
  final Task task;
  final int indexTask;

  PopupMenuCurrentTask({this.onDelete, this.branchID, this.indexTask, this.updateTaskList, this.updateBranchesInfo, this.task});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        if (choice == ConstantsOnPopUpCurrentTask.delete) {
          showDialog(
            context: context,
            builder: (context0) {
              return SimpleDialog(
                contentPadding: EdgeInsets.all(16),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Вы точно хотите удалить это задание?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SimpleDialogOption(
                        child: Text(
                          'ОТМЕНА',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          'УДАЛИТЬ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          onDelete();
                        },
                      ),
                    ],
                  )
                ],
              );
            }
          );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context1) {
                return FormDialogCurrentTask(
                  taskName: task.title,
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
