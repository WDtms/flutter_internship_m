import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  final TaskInteractor _taskInteractor;

  ThemeCubit(this._taskInteractor) : super (ThemeInitialState());

  Future<void> getThemeBranch(String branchID) async {
    emit(ThemeLoadingState());
    final theme = await _taskInteractor.getBranchTheme(branchID);
    emit(ThemeUsageState(theme: theme));
  }

  Future<void> changeTheme(String branchID, Map<Color, Color> newTheme) async {
    await _taskInteractor.changeTheme(branchID, newTheme);
    final theme = await _taskInteractor.getBranchTheme(branchID);
    emit(ThemeUsageState(theme: theme));
  }

}