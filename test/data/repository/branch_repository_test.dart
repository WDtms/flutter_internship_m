import 'package:flutter_internship_v2/data/database/db_wrappers/branch_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/repository/branch_repository.dart';
import 'package:flutter_internship_v2/data/storage/branch_wrapper.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class BranchDBMock extends Mock implements BranchDBStorage {}

class LocalStorageBranchMock extends Mock implements LocalStorageBranchWrapper{}

void main() {

  group('Репозитория веток задач', () {

    BranchRepository _branchRepository;
    BranchDBStorage _branchDBStorage;
    LocalStorageBranchWrapper _branchWrapper;

    setUpAll(() {
      _branchDBStorage = BranchDBMock();
      _branchWrapper = LocalStorageBranchMock();
      _branchRepository = BranchRepository(
          _branchDBStorage,
          _branchWrapper
      );
    });

    final _branch = Branch('id1', 'title1', {}, themes[0]);
    final _branchID = 'branchID';

    final _branches = {
      'id1' : Branch('id1', 'sayMyName', {}, themes[0]),
      'id2' : Branch('id2', 'sayMyNameAgain', {}, themes[2]),
    };

    test('Инициализация веток', () async {
      when(_branchDBStorage.initializeBranches()).thenAnswer((_) async => _branches);
      await _branchRepository.initializeBranches();
      verify(_branchWrapper.initializeBranches(any));
    });

    test('Создание ветки', () async {
      await _branchRepository.createNewBranch(_branch);
      verify(_branchWrapper.createNewBranch(_branch));
      verify(_branchDBStorage.insertObject(_branch.toMap()));
    });

    test('Удаление ветки', () async {
      await _branchRepository.deleteBranch(_branchID);
      verify(_branchWrapper.deleteBranch(_branchID));
      verify(_branchDBStorage.deleteObject(_branchID));
    });

    test('Получение всех веток', () {
      _branchRepository.getAllBranches();
      verify(_branchWrapper.getAllBranches());
    });

  });

}