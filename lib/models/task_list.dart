import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/models/task.dart';

class TaskList{

  bool isHidden = false;

  List<TaskModel> createNewInnerTask(int index, String value) {
    _taskList[index].innerTasks.add(InnerTask(title: value));
    return _taskList;
  }

  List<TaskModel> addDateToComplete(int index, DateTime dateTime){
    _taskList[index].dateToComplete = dateTime;
    return _taskList;
  }

  List<TaskModel> editTaskName(int index, String value) {
    _taskList[index].title = value;
    return _taskList;
  }

  List<TaskModel> getFirstTaskList() {
    return _taskList;
  }

  List<TaskModel> createNewTask(String value) {
    _taskList.add(TaskModel(title: value, innerTasks: [], dateOfCreation: DateTime.now(), dateToComplete: null));
    return _taskList;
  }

  List<TaskModel> toggleTaskComplete(int index) {
    _taskList[index].isDone = !_taskList[index].isDone;
    return _taskList;
  }

  List<TaskModel> deleteTask(int index) {
    _taskList.removeAt(index);
    return _taskList;
  }


  List<TaskModel> deleteAllCompletedTasks() {
    _taskList.removeWhere((task) => task.isDone == true);
    return _taskList;
  }

  List<TaskModel> toggleInnerTaskComplete(int index, int innerIndex) {
    _taskList[index].innerTasks[innerIndex].isDone = !_taskList[index].innerTasks[innerIndex].isDone;
    return _taskList;
  }

  List<TaskModel> deleteInnerTask(int index, int innerIndex) {
    _taskList[index].innerTasks.removeAt(innerIndex);
    return _taskList;
  }

  List<TaskModel> _taskList = [
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
          title: 'Что-то там',
        ),
        InnerTask(
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
}