
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/innertask_repository.dart';
import 'package:uuid/uuid.dart';

class InnerTaskInteractor {

  final InnerTaskRepository innerTaskRepository;

  InnerTaskInteractor({this.innerTaskRepository});

  Future<Task> getTask(String branchID, String taskID) async {
    return innerTaskRepository.getTask(branchID, taskID);
  }


  Future<void> createNewInnerTask(String branchID, String taskID, String innerTaskName) async {
    await innerTaskRepository.createNewInnerTask(
      branchID,
      taskID,
      InnerTask(
        id: Uuid().v4(),
        title: innerTaskName,
      )
    );
  }


  Future<void> deleteInnerTask(String branchID, String taskID, String innerTaskID) async {
    await innerTaskRepository.deleteInnerTask(branchID, taskID, innerTaskID);
  }


  Future<void> editInnerTask(String branchID, String taskID, String innerTaskID, InnerTask innerTask) async {
    await innerTaskRepository.editInnerTask(branchID, taskID, innerTaskID, innerTask);
  }

  Future<void> editTask(String branchID, Task task) async {
    await innerTaskRepository.editTask(branchID, task);
  }

  Future<void> deleteTask(String branchID, String taskID) async {
    await innerTaskRepository.deleteTask(branchID, taskID);
  }

}