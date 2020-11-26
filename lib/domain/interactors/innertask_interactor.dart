
import 'package:flutter_internship_v2/data/models/inner_task.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/innertask_repository.dart';
import 'package:uuid/uuid.dart';

class InnerTaskInteractor {

  final InnerTaskRepository innerTaskRepository;

  InnerTaskInteractor({this.innerTaskRepository});

  Future<Task> getTask(String branchID, int indexTask) async {
    return innerTaskRepository.getTask(branchID, indexTask);
  }


  Future<void> createNewInnerTask(String branchID, int indexTask, String innerTaskName) async {
    await innerTaskRepository.createNewInnerTask(
      branchID,
      indexTask,
      InnerTask(
        id: Uuid().v4(),
        title: innerTaskName,
      )
    );
  }


  Future<void> deleteInnerTask(String branchID, int indexTask, int indexInnerTask) async {
    await innerTaskRepository.deleteInnerTask(branchID, indexTask, indexInnerTask);
  }


  Future<void> editInnerTask(String branchID, int indexTask, int innerTaskIndex, InnerTask innerTask) async {
    await innerTaskRepository.editInnerTask(branchID, indexTask, innerTaskIndex, innerTask);
  }

  Future<void> editTask(String branchID, int indexTask, Task task) async {
    await innerTaskRepository.editTask(branchID, indexTask, task);
  }

  Future<void> deleteTask(String branchID, int taskIndex) async {
    await innerTaskRepository.deleteTask(branchID, taskIndex);
  }

}