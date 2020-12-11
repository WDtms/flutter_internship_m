import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/innertask_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockInnerTaskInteractor extends Mock implements InnerTaskInteractor{}

void main() {

  group('current task cubit', () {

    InnerTaskInteractor _innerTaskInteractor;

    final _currentBranchID = 'currentBranchID';
    final _currentTaskID = 'currentTaskID';
    final _task = Task('id1', 'title1', {}, [], 1, 1, false);

    setUpAll(() {
      _innerTaskInteractor = MockInnerTaskInteractor();
    });

    blocTest(
        'Получение задачи',
        build: () {
          when(_innerTaskInteractor.getTask(any, any)).thenReturn(_task);
          return CurrentTaskCubit(_innerTaskInteractor, _currentBranchID, _currentTaskID);
        },
        act: (CurrentTaskCubit cubit) => cubit.getTask(),
        expect: [
          isA<CurrentTaskLoadingState>(),
          isA<CurrentTaskInUsageState>(),
        ],
        verify: (_) {
          verify(_innerTaskInteractor.getTask(any, any));
        },
    );

    blocTest(
      'Создание внутренней задачи',
      build: () {
        when(_innerTaskInteractor.createNewInnerTask(any, any, any)).thenReturn(null);
        when(_innerTaskInteractor.getTask(any, any)).thenReturn(_task);
        return CurrentTaskCubit(_innerTaskInteractor, _currentBranchID, _currentTaskID);
      },
      act: (CurrentTaskCubit cubit) => cubit.createNewInnerTask('innerTaskName'),
      expect: [
        isA<CurrentTaskInUsageState>(),
      ],
      verify: (_) {
        verify(_innerTaskInteractor.createNewInnerTask(any, any, any));
        verify(_innerTaskInteractor.getTask(any, any));
      },
    );

    blocTest(
      'Удаление внутренней задачи',
      build: () {
        when(_innerTaskInteractor.deleteInnerTask(any, any, any)).thenReturn(null);
        when(_innerTaskInteractor.getTask(any, any)).thenReturn(_task);
        return CurrentTaskCubit(_innerTaskInteractor, _currentBranchID, _currentTaskID);
      },
      act: (CurrentTaskCubit cubit) => cubit.deleteInnerTask('innerTaskID'),
      expect: [
        isA<CurrentTaskInUsageState>(),
      ],
      verify: (_) {
        verify(_innerTaskInteractor.deleteInnerTask(any, any, any));
        verify(_innerTaskInteractor.getTask(any, any));
      },
    );

    blocTest(
      'Удаление задачи',
      build: () {
        when(_innerTaskInteractor.deleteTask(any, any)).thenReturn(null);
        return CurrentTaskCubit(_innerTaskInteractor, _currentBranchID, _currentTaskID);
      },
      act: (CurrentTaskCubit cubit) => cubit.deleteTask(),
      expect: [],
      verify: (_) {
        verify(_innerTaskInteractor.deleteTask(any, any));
      },
    );

  });

}