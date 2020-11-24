
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/cubit/branch/branch_cubit.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';
import 'package:flutter_internship_v2/repository/repository.dart';
import 'package:flutter_internship_v2/views/branches_page/all_branch_card.dart';
import 'package:flutter_internship_v2/views/branches_page/one_branch_card.dart';

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
            cubit.getBranchesInfo();
            return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff6200EE),
                )
            );
          } else if (state is BranchInUsageState){
            return  Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AllBranchCard(allBranchesProgressInfo: state.allBranchesTasksInfo),
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
                          for (int i = 0; i<state.allBranchesInfo.length; i++)
                            OneBranchCard(
                              updateBranchesInfo: () {
                                cubit.updateBranchesInfo();
                              },
                              branchInfo: state.allBranchesInfo[i],
                            ),
                          displayAddButton(context),
                        ],
                      ),
                    )
                  ]
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff6200EE),
              )
          );
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

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
