import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/branch/branch_cubit.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';
import 'package:flutter_internship_v2/repository/repository.dart';

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
            return  Column(
                children: <Widget>[
                  displayAllTaskInfo(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: <Widget>[
                        for (int i = 0; i<state.branchesInfo.length; i++)
                          displaySpecificBranchInfo(
                              context,
                              state.branchesInfo.keys.toList().elementAt(i).keys.first,
                              state.branchesInfo.keys.toList().elementAt(i).values.first,
                              state.branchesInfo.values.toList().elementAt(i)
                          ),
                        displayAddButton(),
                      ],
                    ),
                  )
                ]
            );
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }

  Widget displayAddButton(){
    return Container();
  }

  Widget displayAllTaskInfo(){
    return Container();
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
        padding: EdgeInsets.all(14),
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
            displayProgressInCircularBar(),
            Text(
              '${branchName}',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${branchInfo.values.toList().first} задач(и)',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff979797),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      margin: EdgeInsets.only(right: 3),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        child: Text(
                          '${branchInfo.keys.toList().first} Сделано',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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

  Widget displayProgressInCircularBar(){
    return Container();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
