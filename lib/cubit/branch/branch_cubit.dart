import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState>{
  final TaskInteractor _taskInteractor;

  BranchCubit(this._taskInteractor) : super(BranchInitialState());

  Future<void> getBranchesInfo() async {
    emit(BranchLoadingState());
    final branchesInfo = await _taskInteractor.getBranchesInfo();
    emit(BranchInUsageState(branchesInfo: branchesInfo));
  }

  Future<void> updateBranchesInfo() async {
    final branchesInfo = await _taskInteractor.getBranchesInfo();
    emit(BranchInUsageState(branchesInfo: branchesInfo));
  }

  Future<void> createNewBranch() async {
    await _taskInteractor.createNewBranch();
    final branchesInfo = await _taskInteractor.getBranchesInfo();
    emit(BranchInUsageState(branchesInfo: branchesInfo));
  }

}