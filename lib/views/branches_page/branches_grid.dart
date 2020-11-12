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

  Widget displaySpecificBranchInfo(String id, String branchName, Map<dynamic, dynamic> branchInfo){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(id: id)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: <Widget>[
            displayProgressInCircularBar(),
            Text(
              '${branchName}'
            ),
            Text(
              '${branchInfo.values.toList().first} задач'
            ),
            Row(
              children: <Widget>[
                Text('${branchInfo.keys.toList().first} Сделано'),
                Text('${branchInfo.values.toList().first
                - branchInfo.keys.toList().first} осталось'),
              ],
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
