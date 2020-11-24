import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/all_branch_info.dart';
import 'package:flutter_internship_v2/styles/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'horizontal_progress_bar.dart';

class AllBranchCard extends StatelessWidget {

  final AllBranchesInfo allBranchesProgressInfo;

  AllBranchCard({this.allBranchesProgressInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: Color(0xff86A5F5),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Text(
                  'Все задания',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Завершено ${allBranchesProgressInfo.countAllCompleted} задач из ${allBranchesProgressInfo.countAllUncompleted}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 15, 0, 0),
                child: HorizontalProgressBar(progress: allBranchesProgressInfo.progress),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(branches_info_image),
          ),
        ],
      ),
    );
  }
}
