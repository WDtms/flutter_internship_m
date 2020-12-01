
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/task_repository.dart';
import 'package:uuid/uuid.dart';

class TaskInteractor {

  final TaskRepository taskRepository;

  TaskInteractor({this.taskRepository});

  Future<Map<String, Task>> getTaskList(String branchID) async {
    return taskRepository.getTaskList(branchID);
  }

  Future<void> editTask(String branchID, Task task) async {
    await taskRepository.editTask(branchID, task);
  }

  Future<void> createNewTask(String branchID, String taskName, DateTime dateToComplete, DateTime notificationTime) async {
    await taskRepository.createNewTask(
        branchID,
        Task(
          id: Uuid().v4(),
          title: taskName,
          dateOfCreation: DateTime.now(),
          dateToComplete: dateToComplete,
          notificationTime: notificationTime,
          innerTasks: {},
          imagesPath: [],
        )
    );
  }

  Future<void> deleteTask(String branchID, String taskID) async {
    await taskRepository.deleteTask(branchID, taskID);
  }

  Future<void> deleteAllCompletedTasks(String branchID) async {
    await taskRepository.deleteAllCompletedTasks(branchID);
  }

}