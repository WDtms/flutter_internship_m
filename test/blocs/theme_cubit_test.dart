import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_internship_v2/data/repository/theme_repository.dart';
import 'package:flutter_internship_v2/presentation/bloc/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockThemeRepository extends Mock implements ThemeRepository{}

void main() {

  group('Theme cubit', () {

    ThemeRepository _themeRepository;

    setUpAll(() {
      _themeRepository = MockThemeRepository();
    });

    blocTest(
      'Получение цветовой темы',
      build: () {
        when(_themeRepository.getBranchTheme(any)).thenReturn(themes[0]);
        return ThemeCubit(_themeRepository, 'id');
        },
      act: (ThemeCubit cubit) => cubit.getThemeBranch(),
      expect: [
        isA<ThemeLoadingState>(),
        isA<ThemeUsageState>(),
      ],
      verify: (_) {
        verify(_themeRepository.getBranchTheme(any));
      },
    );

    blocTest(
      'Смена цветовой темы',
      build: () {
        when(_themeRepository.getBranchTheme(any)).thenReturn(themes[0]);
        when(_themeRepository.changeTheme(any, any)).thenReturn(null);
        return ThemeCubit(_themeRepository, 'id');
      },
      act: (ThemeCubit cubit) => cubit.changeTheme(themes[0]),
      expect: [
        isA<ThemeUsageState>(),
      ],
      verify: (_) {
        verify(_themeRepository.getBranchTheme(any));
        verify(_themeRepository.changeTheme(any, any));
      },
    );

  });

}