import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/interactors/branch_interactor.dart';
import 'package:flutter_internship_v2/domain/models/all_branch_info.dart';
import 'package:flutter_internship_v2/domain/models/one_branch_info.dart';
import 'package:flutter_internship_v2/presentation/bloc/branch/branch_cubit.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBranchInteractor extends Mock implements BranchInteractor{}

void main() {
  
  group('Кубит всех веток', () {

    BranchInteractor _branchInteractor;

    final _allBranchesInfo = AllBranchesInfo(1, 2);
    final _oneBranchInfo = OneBranchInfo('id', 'title', 1, 2, Color(0xff121212), Color(0xff121212));
    final _branchesInfo = [
      _oneBranchInfo,
    ];

    setUpAll(() {
      _branchInteractor = MockBranchInteractor();
    });
    
    blocTest(
        'Получение всей информации для отображения на главной странице',
        build: () {
          when(_branchInteractor.initiateBranches()).thenReturn(null);
          when(_branchInteractor.getAllBranchesInfo()).thenReturn(_branchesInfo);
          when(_branchInteractor.getAllBranchesTasksInfo()).thenReturn(_allBranchesInfo);
          return BranchCubit(_branchInteractor);
          },
        act: (BranchCubit cubit) => cubit.getBranchesInfo(),
        expect: [
          isA<BranchLoadingState>(),
          isA<BranchInUsageState>(),
        ],
        verify: (_) {
          verify(_branchInteractor.initiateBranches());
          verify(_branchInteractor.getAllBranchesTasksInfo());
          verify(_branchInteractor.getAllBranchesInfo());
        }
    );

    blocTest(
        'Обновление всей информации на странице при вызова колбэка с другой страницы',
        build: () {
          when(_branchInteractor.getAllBranchesInfo()).thenReturn(_branchesInfo);
          when(_branchInteractor.getAllBranchesTasksInfo()).thenReturn(_allBranchesInfo);
          return BranchCubit(_branchInteractor);
        },
        act: (BranchCubit cubit) => cubit.updateBranchesInfo(),
        expect: [
          isA<BranchInUsageState>(),
        ],
        verify: (_) {
          verify(_branchInteractor.getAllBranchesTasksInfo());
          verify(_branchInteractor.getAllBranchesInfo());
        }
    );

    blocTest(
        'Получение всей информации для отображения на главной странице',
        build: () {
          when(_branchInteractor.createNewBranch(any, any)).thenReturn(null);
          when(_branchInteractor.getAllBranchesInfo()).thenReturn(_branchesInfo);
          when(_branchInteractor.getAllBranchesTasksInfo()).thenReturn(_allBranchesInfo);
          return BranchCubit(_branchInteractor);
        },
        act: (BranchCubit cubit) => cubit.createNewBranch('branchName', themes[0]),
        expect: [
          isA<BranchInUsageState>(),
        ],
        verify: (_) {
          verify(_branchInteractor.createNewBranch(any, any));
          verify(_branchInteractor.getAllBranchesTasksInfo());
          verify(_branchInteractor.getAllBranchesInfo());
        }
    );

    blocTest(
        'Удаление ветки',
        build: () {
          when(_branchInteractor.removeBranch(any)).thenReturn(null);
          when(_branchInteractor.getAllBranchesInfo()).thenReturn(_branchesInfo);
          when(_branchInteractor.getAllBranchesTasksInfo()).thenReturn(_allBranchesInfo);
          return BranchCubit(_branchInteractor);
        },
        act: (BranchCubit cubit) => cubit.removeBranch('branchID'),
        expect: [
          isA<BranchInUsageState>(),
        ],
        verify: (_) {
          verify(_branchInteractor.removeBranch(any));
          verify(_branchInteractor.getAllBranchesTasksInfo());
          verify(_branchInteractor.getAllBranchesInfo());
        }
    );
    
  });
  
}