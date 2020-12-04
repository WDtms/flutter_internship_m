
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_internship_v2/presentation/bloc/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/popup_item.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/theme_dialog.dart';


class PopupMenu extends StatelessWidget {

  final Map<Color, Color> theme;
  final Function() updateBranchesInfo;
  final bool isHidden;

  PopupMenu({this.updateBranchesInfo, this.isHidden, this.theme});

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
              return ThemeDialog(
                theme: theme,
                setBranchTheme: (Map<Color, Color> theme) {
                  context.bloc<ThemeCubit>().changeTheme(theme);
                },
              );
            }
          );
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: PopupItem(
            icon: Icons.check_circle,
            logic: isHidden,
            title: 'Скрыть завершенные',
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: PopupItem(
            icon: Icons.delete,
            title: 'Удалить завершенные',
          )
        ),
        PopupMenuItem(
          value: 3,
          child: PopupItem(
            icon: Icons.auto_fix_high,
            title: 'Изменить тему',
          )
        ),
      ],
    );
  }
}