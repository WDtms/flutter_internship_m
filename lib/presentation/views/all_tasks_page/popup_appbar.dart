
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_internship_v2/presentation/bloc/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/presentation/constants/popup_constans.dart';

import 'bottom_dialog.dart';


class PopupMenu extends StatelessWidget {

  final Function() updateBranchesInfo;
  final String branchID;

  PopupMenu({this.branchID, this.updateBranchesInfo});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        if (choice == Constants.delete) {
          await context.bloc<TaskCubit>().deleteAllCompletedTasks(branchID);
          updateBranchesInfo();
        }
        if (choice == Constants.hide){
          await context.bloc<TaskCubit>().toggleIsHidden(branchID);
        }
        if (choice == Constants.changeTheme){
          showModalBottomSheet(
            context: context,
            builder: (context1) {
              return BottomDialog(
                setBranchTheme: (Map<Color, Color> theme) async {
                  await context.bloc<ThemeCubit>().changeTheme(branchID, theme);
                  updateBranchesInfo();
                },
              );
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