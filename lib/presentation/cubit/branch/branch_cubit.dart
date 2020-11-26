import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/all_branch_info.dart';
import 'package:flutter_internship_v2/data/models/one_branch_info.dart';
import 'package:flutter_internship_v2/domain/interactors/branch_interactor.dart';


part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState>{
  final BranchInteractor _branchInteractor;

  BranchCubit(this._branchInteractor) : super(BranchInitialState());

  Future<void> getBranchesInfo() async {
    emit(BranchLoadingState());
    await _branchInteractor.initiateBranches();
    final allBranchesTasksInfo = await _branchInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _branchInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  Future<void> updateBranchesInfo() async {
    final allBranchesTasksInfo = await _branchInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _branchInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  Future<void> createNewBranch(String branchName) async {
    await _branchInteractor.createNewBranch(branchName);
    final allBranchesTasksInfo = await _branchInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _branchInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  Future<void> removeBranch(String branchID) async {
    await _branchInteractor.removeBranch(branchID);
    final allBranchesTasksInfo = await _branchInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _branchInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

}