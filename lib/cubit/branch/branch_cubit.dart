import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/branch_repository.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState>{
  final TaskRepositoryAlpha _taskRepositoryAlpha;

  BranchCubit(this._taskRepositoryAlpha) : super(BranchInitialState());

  Future<void> getBranches() async {
    emit(BranchLoadingState());
    final _branches = _taskRepositoryAlpha.getBranches();
    emit(BranchInUsageState(branches: _branches));
  }

  Future<void> createNewBranch() async {
    final _branches = _taskRepositoryAlpha.createNewBranch();
    emit(BranchInUsageState(branches: _branches));
  }

}