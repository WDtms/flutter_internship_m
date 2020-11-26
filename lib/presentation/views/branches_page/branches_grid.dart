
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/repository/branch_repository.dart';
import 'package:flutter_internship_v2/domain/interactors/branch_interactor.dart';
import 'package:flutter_internship_v2/presentation/cubit/branch/branch_cubit.dart';

import 'all_branch_card.dart';
import 'branch_create.dart';
import 'one_branch_card.dart';

class BranchesInfoDisplay extends StatefulWidget {

  @override
  _BranchesInfoDisplayState createState() => _BranchesInfoDisplayState();
}

class _BranchesInfoDisplayState extends State<BranchesInfoDisplay> {

  BranchCubit cubit;

  @override
  void initState() {
    cubit = BranchCubit(BranchInteractor(branchRepository: BranchRepository()));
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
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        crossAxisCount: 2,
                        children: <Widget>[
                          for (int i = 0; i<state.allBranchesInfo.length; i++)
                            OneBranchCard(
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
        showDialog(
          context: context,
          builder: (context0) {
            return CreateBranchForm(
              createBranch: (String branchName) {
                cubit.createNewBranch(branchName);
              },
            );
          }
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 90),
        decoration: BoxDecoration(
          color: Color(0xff01A39D),
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
