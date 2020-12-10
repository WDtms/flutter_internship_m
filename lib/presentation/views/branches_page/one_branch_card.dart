import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/models/one_branch_info.dart';
import 'package:flutter_internship_v2/presentation/bloc/branch/branch_cubit.dart';
import 'package:flutter_internship_v2/presentation/pages/all_tasks.dart';
import 'one_branch_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneBranchCard extends StatelessWidget {

  final OneBranchInfo branchInfo;

  OneBranchCard({this.branchInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('select branch'),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context1) => AllTasksPage(
          updateBranchesInfo: () {
            context.bloc<BranchCubit>().updateBranchesInfo();
            },
          branchID: branchInfo.id,
          branchTitle: branchInfo.title,
        )
        ));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context0) {
            return SimpleDialog(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Вы точно хотите удалить эту ветвь задач?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff424242),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SimpleDialogOption(
                      child: Text(
                        "УДАЛИТЬ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff424242),
                        ),
                      ),
                      onPressed: () async {
                        await context.bloc<BranchCubit>().removeBranch(branchInfo.id);
                        Navigator.pop(context);
                      },
                    ),
                    SimpleDialogOption(
                      child: Text(
                        "ОТМЕНА",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff424242),
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
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5),
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
              child: CircleProgressBar(
                completedColor: branchInfo.completedColor,
                progress: branchInfo.progress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                '${branchInfo.title}',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                '${branchInfo.countCompletedTasks + branchInfo.countUnCompletedTasks} задач(и)',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff979797),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: branchInfo.backGroundColor,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Text(
                          '${branchInfo.countCompletedTasks} сделано',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: branchInfo.completedColor,
                          ),
                        ),
                      )
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(253, 53, 53, 0.51),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Text(
                        '${branchInfo.countUnCompletedTasks} осталось',
                        style: TextStyle(
                          color: Color(0xffFD3535),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
