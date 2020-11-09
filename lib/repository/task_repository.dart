
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/models/task_list.dart';

abstract class TaskRepository{

  Future<List<TaskModel>> getTaskList();

  Future<List<TaskModel>> createNewTask(String value);

  Future<List<TaskModel>> toggleTaskComplete(int index);

  Future<List<TaskModel>> deleteTask(int index);

  Future<List<TaskModel>> deleteAllCompletedTasks();

  Future<List<TaskModel>> toggleInnerTaskComplete(int index, int innerIndex);

  Future<List<TaskModel>> deleteInnerTask(int index, int innerIndex);

  Future<List<TaskModel>> createNewInnerTask(int index, String value);

  Future<List<TaskModel>> editTaskName(int index, String value);

  Future<List<TaskModel>> addDateToComplete(int index, DateTime dateTime);

}

class FakeTaskRepository implements TaskRepository{

  final TaskList taskList;

  FakeTaskRepository({this.taskList});

  Future<List<TaskModel>> addDateToComplete(int index, DateTime dateTime) async {
    return taskList.addDateToComplete(index, dateTime);
  }

  Future<List<TaskModel>> editTaskName(int index, String value) async {
    return taskList.editTaskName(index, value);
  }

  Future<List<TaskModel>> createNewInnerTask(int index, String value) async {
    return taskList.createNewInnerTask(index, value);
  }

  Future<List<TaskModel>> deleteInnerTask(int index, int innerIndex) async {
    return taskList.deleteInnerTask(index, innerIndex);
  }

  Future<List<TaskModel>> toggleInnerTaskComplete(int index, int innerIndex) async {
    return taskList.toggleInnerTaskComplete(index, innerIndex);
  }

  @override
  Future<List<TaskModel>> getTaskList() async {
    return taskList.getFirstTaskList();
  }

  @override
  Future<List<TaskModel>> createNewTask(String value) async {
    return taskList.createNewTask(value);
  }

  Future<List<TaskModel>> toggleTaskComplete(int index) async {
    return taskList.toggleTaskComplete(index);
  }

  Future<List<TaskModel>> deleteTask(int index) async {
    return taskList.deleteTask(index);
  }

  Future<List<TaskModel>> deleteAllCompletedTasks() async {
    return taskList.deleteAllCompletedTasks();
  }


}