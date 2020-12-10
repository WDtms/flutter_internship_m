import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/repository/theme_repository.dart';
import 'package:flutter_internship_v2/data/storage/theme_wrapper.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class BranchDBMock extends Mock implements BranchDBStorage {}

class ThemeMock extends Mock implements ThemeWrapper {}

void main() {

  group('Репозитория тем', () {

    BranchDBStorage _branchDBStorage;
    ThemeWrapper _themeWrapper;
    ThemeRepository _themeRepository;

    setUpAll(() {
      _branchDBStorage = BranchDBMock();
      _themeWrapper = ThemeMock();
      _themeRepository = ThemeRepository(_branchDBStorage, _themeWrapper);
    });

    final _branchID = 'branchID';
    final _theme = themes[0];

    final _branch = Branch('id1','title1',{},_theme);

    test('Получение темы', () async {
      await _themeRepository.getBranchTheme(_branchID);
      verify(_themeWrapper.getBranchTheme(_branchID));
    });

    test('Смена темы', () async {
      when(_themeWrapper.getBranch(_branchID)).thenAnswer((_) => _branch);
      await _themeRepository.changeTheme(_branchID, _theme);
      verify(_themeWrapper.changeTheme(_branchID, _theme));
      verify(_branchDBStorage.updateObject(_branch.toMap()));
    });

  });

}