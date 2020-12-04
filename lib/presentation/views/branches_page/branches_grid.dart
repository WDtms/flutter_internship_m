
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/repository/branch_repository.dart';
import 'package:flutter_internship_v2/domain/interactors/branch_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/branch/branch_cubit.dart';
import 'all_branch_card.dart';
import 'branch_create.dart';
import 'one_branch_card.dart';

class BranchesInfoDisplay extends StatefulWidget {

  @override
  _BranchesInfoDisplayState createState() => _BranchesInfoDisplayState();
}

class _BranchesInfoDisplayState extends State<BranchesInfoDisplay> {

  BranchCubit _cubit;

  @override
  void initState() {
    _cubit = BranchCubit(BranchInteractor(branchRepository: BranchRepository()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<BranchCubit, BranchState>(
        builder: (context, state) {
          if (state is BranchInitialState){
            _cubit.getBranchesInfo();
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6200EE)),
                )
            );
          } else if (state is BranchInUsageState){
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                    child: AllBranchCard(allBranchesProgressInfo: state.allBranchesTasksInfo),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                    child: Text(
                      'Ветки задач',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: <Widget>[
                      for (int i = 0; i<state.allBranchesInfo.length; i++)
                        OneBranchCard(
                          branchInfo: state.allBranchesInfo[i],
                        ),
                      displayAddButton(context),
                    ],
                  ),
                )
              ],
            );
          }
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6200EE)),
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
              createBranch: (String branchName, Map<Color, Color> theme) {
                _cubit.createNewBranch(branchName, theme);
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
    _cubit.close();
    super.dispose();
  }
}
