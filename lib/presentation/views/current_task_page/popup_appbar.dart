
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'form_dialog.dart';



class PopupMenuCurrentTask extends StatelessWidget {

  final Function() updateBranchesInfo;
  final Function() updateTaskList;
  final Task task;

  PopupMenuCurrentTask({this.updateTaskList, this.updateBranchesInfo, this.task});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (int value) async {
        if (value == 1){
          showDialog(
            context: context,
            builder: (context1) {
              return FormDialogCurrentTask(
                taskName: task.title,
                editTaskName: (String newTitle) async {
                  await context.bloc<CurrentTaskCubit>().editTask(task.copyWith(title: newTitle));
                  updateTaskList();
                },
              );
            }
          );
        } else {
          await showDialog(
            context: context,
            builder: (context1) {
              return SimpleDialog(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Вы точно хотите удалить эту задачу?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SimpleDialogOption(
                        child: Text(
                          "Удалить",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () async {
                          await context.bloc<CurrentTaskCubit>().deleteTask();
                          await updateTaskList();
                          await updateBranchesInfo();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          "Отмена",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              );
            }
          );
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.edit,
                  size: 32,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Редактировать',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.delete,
                  size: 32,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Удалить',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
