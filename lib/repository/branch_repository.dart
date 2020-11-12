import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskRepositoryAlpha{
  final List<List<TaskModel>> branches = List<List<TaskModel>>();

  TaskRepositoryAlpha(){
    createStartPuck();
  }

  void createStartPuck(){
    List<TaskModel> branch = [
      TaskModel(
        title: "Дорисовать дизайн",
        innerTasks: [],
        dateOfCreation: DateTime.now(),
        dateToComplete: null,
      ),
      TaskModel(
        title: "Дописать тз на стажировку",
        innerTasks: [
          InnerTask(
            id: Uuid().v4(),
            title: 'Что-то там',
          ),
          InnerTask(
              id: Uuid().v4(),
              title: 'и еще вот это'
          )
        ],
        dateOfCreation: DateTime.now(),
        dateToComplete: null,
      ),
      TaskModel(
        title: "Дописать план",
        innerTasks: [],
        dateOfCreation: DateTime.now(),
        dateToComplete: null,
      ),
    ];
    branches.add(branch);
  }

  Future<List<List<TaskModel>>> getBranches() async {
    return branches;
  }

  Future<List<List<TaskModel>>> createNewBranch() async {
    List<TaskModel> branch = List<TaskModel>();
    branches.add(branch);
    return branches;
  }

  Future<List<List<TaskModel>>> toggleTaskComplete(String taskID) async {

    return branches;
  }
}