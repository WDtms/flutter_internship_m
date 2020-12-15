import 'package:flutter_internship_v2/data/database/db_wrappers/innertask_db_wrapper.dart';
import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/innertask_repository.dart';
import 'package:flutter_internship_v2/data/storage/innertask_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class InnerTaskDBMock extends Mock implements InnerTaskDBStorage{}

class TaskDBMock extends Mock implements TaskDBStorage {}

class LocalStorageInnerTaskMock extends Mock implements LocalStorageInnerTaskWrapper {}

void main(){

  group('Репозиторий внутренних задач', () {

    InnerTaskRepository _innerTaskRepository;
    TaskDBStorage _taskDBStorage;
    InnerTaskDBStorage _innerTaskDBStorage;
    LocalStorageInnerTaskWrapper _innerTaskWrapper;

    setUpAll(() {
      _taskDBStorage = TaskDBMock();
      _innerTaskDBStorage = InnerTaskDBMock();
      _innerTaskWrapper = LocalStorageInnerTaskMock();
      _innerTaskRepository = InnerTaskRepository(
        _innerTaskDBStorage,
        _taskDBStorage,
        _innerTaskWrapper,
      );
    });

    final _branchID = 'branchID';
    final _taskID = 'taskID';
    final _innerTaskID = 'innerTaskID';

    final _innerTask = InnerTask('innerTaskID', 'title1', isDone: true);
    final _task = Task('taskID', 'title1', {_innerTaskID : _innerTask}, [], DateTime.now().millisecondsSinceEpoch, 1, false);

    test('Получение задачи', () {
      _innerTaskRepository.getTask(_branchID, _taskID);
      verify(_innerTaskWrapper.getTask(_branchID, _taskID));
    });

    test('Создание внутренней задачи', () async {
      when(_innerTaskWrapper.getTask(_branchID, _taskID)).thenAnswer((_) => _task);
      await _innerTaskRepository.createNewInnerTask(_branchID, _taskID, _innerTask);
      verify(_innerTaskWrapper.createNewInnerTask(_branchID, _taskID, _innerTask));
      verify(_innerTaskDBStorage.insertObject(_innerTask.toMap(_branchID, _taskID)));
    });

    test('Удаление внутренней задачи', () async {
      when(_innerTaskWrapper.getTask(_branchID, _taskID)).thenAnswer((_) => _task);
      when(_innerTaskWrapper.getInnerTask(any, any, any)).thenReturn(_innerTask);
      await _innerTaskRepository.deleteInnerTask(_branchID, _taskID, _innerTaskID);
      verify(_innerTaskWrapper.deleteInnerTask(_branchID, _taskID, _innerTaskID));
      verify(_innerTaskDBStorage.deleteObject(_innerTaskID));
    });

    test('Редактирование внутренней задачи', () async {
      await _innerTaskRepository.editInnerTask(_branchID, _taskID, _innerTaskID, _innerTask);
      verify(_innerTaskWrapper.editInnerTask(_branchID, _taskID, _innerTaskID, _innerTask));
      verify(_innerTaskDBStorage.updateObject(_innerTask.toMap(_branchID, _taskID)));
    });

    test('Редактирование задачи', () async {
      await _innerTaskRepository.deleteTask(_branchID, _taskID);
      verify(_innerTaskWrapper.deleteTask(_branchID, _taskID));
      verify(_taskDBStorage.deleteObject(_taskID));
    });

    test('Удаление задачи', () async {
      await _innerTaskRepository.deleteTask(_branchID, _taskID);
      verify(_innerTaskWrapper.deleteTask(_branchID, _taskID));
      verify(_taskDBStorage.deleteObject(_taskID));
    });

  });

}