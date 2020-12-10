import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/domain/interactors/task_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/task/task_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTaskInteractor extends Mock implements TaskInteractor{}

void main() {

  group('taskCubit', () {

    TaskInteractor _taskInteractor;

    final _branchID = 'branchID';
    final _taskID = 'id1';
    final _task = Task(_taskID, 'title1', {}, [], 1);
    final _taskList = {
      _taskID : _task
    };

    setUpAll(() {
      _taskInteractor = MockTaskInteractor();
    });

    blocTest<TaskCubit, TaskState>(
      'Получение списка задач по айди',
      build: () {
        when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
        return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
        },
      act: (TaskCubit cubit) => cubit.getTasks(),
      expect: [
        isA<TaskLoadingState>(),
        isA<TaskInUsageState>(),
      ],
      verify: (_) => verify(_taskInteractor.getTaskList(any))
    );

    blocTest<TaskCubit, TaskState>(
        'Редактирование задачи',
        build: () {
          when(_taskInteractor.editTask(any, any)).thenReturn(null);
          when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
          return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
        },
        act: (TaskCubit cubit) => cubit.editTask(_taskID, _task),
        expect: [
          isA<TaskInUsageState>(),
        ],
        verify: (_) {
          verify(_taskInteractor.getTaskList(any));
          verify(_taskInteractor.editTask(any, any));
        },
    );

    blocTest<TaskCubit, TaskState>(
      'Создание новой задачи',
      build: () {
        when(_taskInteractor.createNewTask(any, any, any, any)).thenReturn(null);
        when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
        return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
      },
      act: (TaskCubit cubit) => cubit.createNewTask(DateTime.now(), DateTime.now(), 'taskName'),
      expect: [
        isA<TaskInUsageState>(),
      ],
      verify: (_) {
        verify(_taskInteractor.getTaskList(any));
        verify(_taskInteractor.createNewTask(any, any, any, any));
      },
    );

    blocTest<TaskCubit, TaskState>(
      'Удаление задачи',
      build: () {
        when(_taskInteractor.deleteTask(any, any)).thenReturn(null);
        when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
        return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
      },
      act: (TaskCubit cubit) => cubit.deleteTask(_taskID),
      expect: [
        isA<TaskInUsageState>(),
      ],
      verify: (_) {
        verify(_taskInteractor.getTaskList(any));
        verify(_taskInteractor.deleteTask(any, any));
      },
    );

    blocTest<TaskCubit, TaskState>(
      'Удаление задачи',
      build: () {
        when(_taskInteractor.deleteTask(any, any)).thenReturn(null);
        when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
        return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
      },
      act: (TaskCubit cubit) => cubit.deleteTask(_taskID),
      expect: [
        isA<TaskInUsageState>(),
      ],
      verify: (_) {
        verify(_taskInteractor.getTaskList(any));
        verify(_taskInteractor.deleteTask(any, any));
      },
    );

    blocTest<TaskCubit, TaskState>(
      'Удаление всех завершенных задач',
      build: () {
        when(_taskInteractor.deleteAllCompletedTasks(any)).thenReturn(null);
        when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
        return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
      },
      act: (TaskCubit cubit) => cubit.deleteAllCompletedTasks(),
      expect: [
        isA<TaskInUsageState>(),
      ],
      verify: (_) {
        verify(_taskInteractor.getTaskList(any));
        verify(_taskInteractor.deleteAllCompletedTasks(any));
      },
    );

    blocTest<TaskCubit, TaskState>(
        'Обновление информации на страницы с колбэка другой страницы',
        build: () {
          when(_taskInteractor.getTaskList(any)).thenReturn(_taskList);
          return TaskCubit(taskInteractor: _taskInteractor, currentBranchID: _branchID);
        },
        act: (TaskCubit cubit) => cubit.updateTaskList(),
        expect: [
          isA<TaskInUsageState>(),
        ],
        verify: (_) => verify(_taskInteractor.getTaskList(any))
    );

  });

}