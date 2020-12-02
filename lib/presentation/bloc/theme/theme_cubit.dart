import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/repository/theme_repository.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  final ThemeRepository _themeRepository;
  final String currentBranchID;

  ThemeCubit(this._themeRepository, {this.currentBranchID}) : super (ThemeInitialState());

  Future<void> getThemeBranch() async {
    emit(ThemeLoadingState());
    final theme = await _themeRepository.getBranchTheme(currentBranchID);
    emit(ThemeUsageState(theme: theme));
  }

  Future<void> changeTheme(Map<Color, Color> newTheme) async {
    await _themeRepository.changeTheme(currentBranchID, newTheme);
    final theme = await _themeRepository.getBranchTheme(currentBranchID);
    emit(ThemeUsageState(theme: theme));
  }

}