
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/cubit/task/task_cubit.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/services/popup_constans.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/views/all_tasks_page/bottom_dialog.dart';

class PopupMenu1 extends StatelessWidget {

  final Function() updateBranchesInfo;
  final String branchID;

  PopupMenu1({this.branchID, this.updateBranchesInfo});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        if (choice == Constants.delete) {
          await context.bloc<TaskCubit>().deleteAllCompletedTasks(branchID);
          updateBranchesInfo();
        }
        if (choice == Constants.hide){

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