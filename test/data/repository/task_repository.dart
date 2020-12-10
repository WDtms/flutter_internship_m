import 'package:flutter_internship_v2/data/database/db_wrappers/task_db_wrapper.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/task_repository.dart';
import 'package:flutter_internship_v2/data/storage/task_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class TaskDBMock extends Mock implements TaskDBStorage{}

class LocalStorageTaskMock extends Mock implements LocalStorageTaskWrapper{}

void main() {

  group('Репозиторий задач', () {

    TaskRepository _taskRepository;
    TaskDBStorage _taskDBStorage;
    LocalStorageTaskWrapper _taskWrapper;

    setUpAll(() {
      _taskDBStorage = TaskDBMock();
      _taskWrapper = LocalStorageTaskMock();
      _taskRepository = TaskRepository(taskDBStorage: _taskDBStorage, taskWrapper: _taskWrapper);
    });

    final _branchID = 'branchID';
    final _taskID = 'id1';
    final _taskIDList = ['id1', 'id2'];

    final _taskList = {
      'id1' : Task('id1', 'title1', {}, [], DateTime.now().millisecondsSinceEpoch,),
      'id2' : Task('id2', 'title2', {}, [], DateTime.now().millisecondsSinceEpoch,),
    };

    final _task = Task('id3', 'title3', {}, [], DateTime.now().millisecondsSinceEpoch,);

    test('Получение списка задач', () {
      _taskRepository.getTaskList(_branchID);
      verify(_taskWrapper.getTaskList(_branchID));
    });

    test('Создание новой задачи', () async {
      await _taskRepository.createNewTask(_branchID, _task);
      verify(_taskWrapper.createNewTask(_branchID, _task));
      verify(_taskDBStorage.insertObject(_task.toMap(_branchID)));
    });

    test('Обновление полей задачи', () async {
      await _taskRepository.editTask(_branchID, _task);
      verify(_taskWrapper.editTask(_branchID, _task));
      verify(_taskDBStorage.updateObject(_task.toMap(_branchID)));
    });

    test('Удаление задачи', () async {
      when(_taskWrapper.getTaskList(_branchID)).thenAnswer((_) => _taskList);
      await _taskRepository.deleteTask(_branchID, _taskID);
      verify(_taskWrapper.deleteTask(_branchID, _taskID));
      verify(_taskDBStorage.deleteObject(_taskID));
    });

    test('Удаление всех завершенных задач', () async {
      await _taskRepository.deleteAllCompletedTasks(_branchID, _taskIDList);
      verify(_taskWrapper.deleteAllCompletedTasks(_branchID));
      verify(_taskDBStorage.deleteAllCompletedTasks(_branchID, _taskIDList));
    });

    test('Получение задачи', () {
      _taskRepository.getTask(_branchID, _taskID);
      verify(_taskWrapper.getTask(_branchID, _taskID));
    });

  });

}