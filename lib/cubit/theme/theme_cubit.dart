import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  final TaskInteractor _taskInteractor;

  ThemeCubit(this._taskInteractor) : super (ThemeInitialState());

  Future<void> getThemeBranch(String id) async {
    emit(ThemeLoadingState());
    final theme = await _taskInteractor.getBranchTheme(id);
    emit(ThemeUsageState(theme: theme));
  }

  Future<void> setThemeBranch(String id, Map<Color, Color> theme) async {
    final newTheme = await _taskInteractor.setBranchTheme(id, theme);
    emit(ThemeUsageState(theme: newTheme));
  }


}