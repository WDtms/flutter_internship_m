
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/domain/interactors/branch_interactor.dart';
import 'package:flutter_internship_v2/domain/models/all_branch_info.dart';
import 'package:flutter_internship_v2/domain/models/one_branch_info.dart';


part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState>{

  final BranchInteractor _branchInteractor;

  BranchCubit(this._branchInteractor) : super(BranchInitialState());

  //Получение всей информации для отображения на главной странице
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

  //Обновления всей информации на главной странице (колбек)
  Future<void> updateBranchesInfo() async {
    final allBranchesTasksInfo = await _branchInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _branchInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  //Создание новой ветки
  Future<void> createNewBranch(String branchName, Map<Color, Color> theme) async {
    await _branchInteractor.createNewBranch(branchName, theme);
    final allBranchesTasksInfo = await _branchInteractor.getAllBranchesTasksInfo();
    final branchesInfo = await _branchInteractor.getAllBranchesInfo();
    emit(BranchInUsageState(
      allBranchesInfo: branchesInfo,
      allBranchesTasksInfo: allBranchesTasksInfo,
    ));
  }

  //Удаление ветки
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