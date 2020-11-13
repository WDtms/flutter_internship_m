
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/branch/branch_cubit.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';
import 'package:flutter_internship_v2/repository/repository.dart';
import 'package:flutter_internship_v2/styles/my_images.dart';
import 'package:flutter_internship_v2/views/branches_page/horizontal_progress_bar.dart';
import 'package:flutter_internship_v2/views/branches_page/one_branch_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BranchesInfoDisplay extends StatefulWidget {

  @override
  _BranchesInfoDisplayState createState() => _BranchesInfoDisplayState();
}

class _BranchesInfoDisplayState extends State<BranchesInfoDisplay> {

  BranchCubit cubit;

  @override
  void initState() {
    cubit = BranchCubit(TaskInteractor.getInstance(repository: Repository()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<BranchCubit, BranchState>(
        builder: (context, state) {
          if (state is BranchInitialState){
            context.bloc<BranchCubit>().getBranchesInfo();
            return CircularProgressIndicator();
          } else if (state is BranchInUsageState){
            return  Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    displayAllTaskInfo(calculateAllTasksProgress(state.branchesInfo)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        'Ветки задач',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2,
                        children: <Widget>[
                          for (int i = 0; i<state.branchesInfo.length; i++)
                            displaySpecificBranchInfo(
                                context,
                                state.branchesInfo.keys.toList().elementAt(i).keys.toList().first,
                                state.branchesInfo.keys.toList().elementAt(i).values.toList().first,
                                state.branchesInfo.values.toList().elementAt(i)
                            ),
                          displayAddButton(context),
                        ],
                      ),
                    )
                  ]
              ),
            );
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }

  Widget displayAddButton(BuildContext context){
    return InkWell(
      onTap: () {
        context.bloc<BranchCubit>().createNewBranch();
      },
      child: Container(
        margin: EdgeInsets.only(right: 100),
        decoration: BoxDecoration(
          color: Colors.teal,
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
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget displayAllTaskInfo(Map<int, int> allBranchesProgressInfo){
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  'Все задания',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                    'Завершено ${allBranchesProgressInfo.keys.toList().first} задач из ${allBranchesProgressInfo.values.toList().first}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: displayHorizontalProgressBar(allBranchesProgressInfo),
              ),
            ],
          ),
          SizedBox(
            width: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(branches_info_image),
          ),
        ],
      ),
    );
  }

  Widget displayHorizontalProgressBar(Map<int, int> allBranchesProgress){
    double progress;
    if (allBranchesProgress.values.toList().first == 0)
      progress = 0;
    else
      progress = allBranchesProgress.keys.toList().first/allBranchesProgress.values.toList().first;
    return HorizontalProgressBar(progress: progress);
  }


  Widget displayProgressInCircularBar(double completedProgress, Color completedColor){
    return CircleProgressBar(
        completedColor: completedColor,
        progress: completedProgress
    );
  }

  double calculateProgress(Map<dynamic, dynamic> branchInfo){
    if (branchInfo.values.toList().first == 0)
      return 1;
    return branchInfo.keys.toList().first/branchInfo.values.toList().first;
  }

  Map<int, int> calculateAllTasksProgress(Map<Map<String, String>, Map<dynamic, dynamic>> branchesTaskInfo){
    int allTasksCount = 0;
    int completedTasksCount = 0;
    for (int i = 0; i<branchesTaskInfo.length; i++){
      completedTasksCount += branchesTaskInfo.values.toList().elementAt(i).keys.toList().first;
      allTasksCount += branchesTaskInfo.values.toList().elementAt(i).values.toList().first;
    }
    return {completedTasksCount : allTasksCount};
  }

  Widget displaySpecificBranchInfo(BuildContext context, String id, String branchName, Map<dynamic, dynamic> branchInfo){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context1) => TaskPage(
            updateBranchesInfo: () {
              context.bloc<BranchCubit>().updateBranchesInfo();
              },
            id: id)
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
              child: displayProgressInCircularBar(
                calculateProgress(branchInfo),
                branchInfo.keys.toList().last,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                '${branchName}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                '${branchInfo.values.toList().first} задач(и)',
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
                          color: branchInfo.values.toList().last,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      margin: EdgeInsets.fromLTRB(12, 2, 4, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        child: Text(
                          '${branchInfo.keys.toList().first} Сделано',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: branchInfo.keys.toList().last,
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
                          '${branchInfo.values.toList().first
                      - branchInfo.keys.toList().first} осталось',
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

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
