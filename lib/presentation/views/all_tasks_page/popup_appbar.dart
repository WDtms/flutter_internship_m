
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
  final bool isNewest;
  final bool isImportance;

  PopupMenu({this.updateBranchesInfo, this.isHidden, this.theme, this.isNewest, this.isImportance});

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
                  updateBranchesInfo();
                },
              );
            }
          );
        }
        if (value == 4){
          context.bloc<TaskCubit>().toggleIsNewest();
        }
        if (value == 5)
          context.bloc<TaskCubit>().toggleImportance();
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: PopupItem(
            icon: Icons.check_circle,
            hiddenLogic: isHidden,
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
        PopupMenuItem(
          value: 4,
          child: PopupItem(
            icon: Icons.sort,
            title: 'Сначала новые',
            newestLogic: isNewest,
          ),
        ),
        PopupMenuItem(
          value: 5,
          child: PopupItem(
            icon: Icons.whatshot_outlined,
            title: 'Сначала важные',
            importanceLogic: isImportance,
          ),
        )
      ],
    );
  }
}