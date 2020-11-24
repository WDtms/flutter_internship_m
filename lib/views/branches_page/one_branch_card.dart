import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/one_branch_info.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';
import 'one_branch_progress_bar.dart';

class OneBranchCard extends StatelessWidget {

  final Function() updateBranchesInfo;
  final OneBranchInfo branchInfo;

  OneBranchCard({this.branchInfo, this.updateBranchesInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context1) => TaskPage(
            updateBranchesInfo: () {
              updateBranchesInfo();
            },
            branchID: branchInfo.id)
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
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
              padding: const EdgeInsets.fromLTRB(3, 15, 0, 0),
              child: CircleProgressBar(
                completedColor: branchInfo.completedColor,
                progress: branchInfo.progress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                '${branchInfo.title}',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                '${branchInfo.countCompletedTasks + branchInfo.countUnCompletedTasks} задач(и)',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff979797),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: branchInfo.backGroundColor,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      margin: EdgeInsets.fromLTRB(12, 2, 4, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        child: Text(
                          '${branchInfo.countCompletedTasks} Сделано',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
                      padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Text(
                        '${branchInfo.countUnCompletedTasks} осталось',
                        style: TextStyle(
                            color: Color(0xffFD3535),
                            fontWeight: FontWeight.bold,
                            fontSize: 12
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
