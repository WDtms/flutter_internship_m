
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_internship_v2/presentation/bloc/theme/theme_cubit.dart';


import 'bottom_dialog.dart';


class PopupMenu extends StatelessWidget {

  final Function() updateBranchesInfo;
  final bool isHidden;

  PopupMenu({this.updateBranchesInfo, this.isHidden});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (int value) async {
        if (value == 1){
          context.bloc<TaskCubit>().toggleIsHidden();
        }
        if (value == 2){
          await context.bloc<TaskCubit>().deleteAllCompletedTasks();
          updateBranchesInfo();
        }
        if (value == 3){
          showBottomSheet(
            context: context,
            builder: (context1) {
              return BottomDialog(
                setBranchTheme: (Map<Color, Color> theme) async {
                  await context.bloc<ThemeCubit>().changeTheme(theme);
                  await updateBranchesInfo();
                  Navigator.pop(context);
                },
              );
            }
          );
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Builder(
            builder: (context1) {
              if (isHidden){
                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check_circle,
                        size: 28,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'Показать завершенные',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                );
              }
              return Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.check_circle,
                      size: 28,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Скрыть завершенные',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              );
            },
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
                  size: 28,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Удалить завершенные',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.auto_fix_high,
                  size: 28,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Изменить тему',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}