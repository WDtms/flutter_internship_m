import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/models/theme_list.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  final ThemeList _themeList;

  ThemeCubit(this._themeList) : super (ThemeInitialState());

  Future<void> changeTheme(int value) async {
    final newTheme = _themeList.changeAndGetCurrentTheme(value);
    emit(ThemeChangedState(theme: newTheme));
  }

}