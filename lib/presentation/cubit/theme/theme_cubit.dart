import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/repository/theme_repository.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  final ThemeRepository _themeRepository;

  ThemeCubit(this._themeRepository) : super (ThemeInitialState());

  Future<void> getThemeBranch(String branchID) async {
    emit(ThemeLoadingState());
    final theme = await _themeRepository.getBranchTheme(branchID);
    emit(ThemeUsageState(theme: theme));
  }

  Future<void> changeTheme(String branchID, Map<Color, Color> newTheme) async {
    await _themeRepository.changeTheme(branchID, newTheme);
    final theme = await _themeRepository.getBranchTheme(branchID);
    emit(ThemeUsageState(theme: theme));
  }

}