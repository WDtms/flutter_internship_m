import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/models/all_branch_info.dart';
import 'package:flutter_internship_v2/models/one_branch_info.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState>{
  final TaskInteractor _taskInteractor;

  BranchCubit(this._taskInteractor) : super(BranchInitialState());

  Future<void> getBranchesInfo() async {
    emit(BranchLoadingState());
    await _taskInteractor.initiateBranches();
    final allBranchesTasksInfo = await _taskInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _taskInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  Future<void> updateBranchesInfo() async {
    final allBranchesTasksInfo = await _taskInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _taskInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  Future<void> createNewBranch() async {
    await _taskInteractor.createNewBranch();
    final allBranchesTasksInfo = await _taskInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _taskInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

}