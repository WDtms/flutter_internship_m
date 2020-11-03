import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/task_list.dart';
import 'package:rxdart/rxdart.dart';

class TaskRepository{
  final TaskList taskList;
  final BehaviorSubject<List<TaskModel>> _subject;
  bool _loaded = false;

  TaskRepository(this.taskList, {List<TaskModel> seed})
      : _subject = BehaviorSubject<List<TaskModel>>.seeded(seed ?? []);


  List<TaskModel> get snapshot => _subject.value ?? [];

  Stream<List<TaskModel>> get tasks {
    if (!_loaded) _loadTasks();

    return _subject.stream;
  }

  Future<void> updateTask(TaskModel task, int index) async {
    final tasks = _subject.value;
    tasks[index] = task;
    _subject.add(tasks);
  }

  void deleteInnerTask(TaskModel task, int index,  int innerIndex){
    final taskList = _subject.value;
    taskList[index].innerTasks.removeAt(innerIndex);
    _subject.add(taskList);
  }

  void deleteTask(TaskModel task){
    final taskList = _subject.value;
    taskList.remove(task);
    _subject.add(taskList);
  }

  void createNewInnerTask(int index, String value){
    final _newInnerTask = InnerTask(title: value);
    final taskList = _subject.value;
    taskList[index].innerTasks.add(_newInnerTask);
    _subject.add(taskList);
  }

  void createNewTask(String value){
    final _newTask = TaskModel(title: value, innerTasks: []);
    final taskList = _subject.value;
    taskList.add(_newTask);
    _subject.add(taskList);
  }

  void _loadTasks(){
    _loaded = true;

    taskList.getFirstTaskList().then((tasks) => _subject.add(tasks));
  }
}