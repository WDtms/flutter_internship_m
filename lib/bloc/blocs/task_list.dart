import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/repository/task_repository.dart';

class TaskListBloc{
  final TaskRepository _taskRepository;

  TaskListBloc(this._taskRepository);

  Stream<List<TaskModel>> get tasks {
    return _taskRepository.tasks;
  }

  void addNewTask(String value) => _taskRepository.createNewTask(value);
  void deleteTask(TaskModel task) => _taskRepository.deleteTask(task);
  void deleteInnerTask(TaskModel task, int index, int innerIndex) => _taskRepository.deleteInnerTask(task, index, innerIndex);
  void createInnerTask(int index, String value) => _taskRepository.createNewInnerTask(index, value);

  void toggleTaskComplete(TaskModel task, int index) async {
    final toggled = task.toggleComplete(task);
    return await _taskRepository.updateTask(toggled, index);
  }

  void editTaskName(TaskModel task, int index, String value) async {
    final taskNameEdited = task.editTaskName(task, value);
    return await _taskRepository.updateTask(taskNameEdited, index);
  }

  void toggleInnerTaskComplete(TaskModel task, int index, int innerIndex) async {
    final innerToggled = task.toggleInnerComplete(task, innerIndex);
    return await _taskRepository.updateTask(innerToggled, index);
  }

}