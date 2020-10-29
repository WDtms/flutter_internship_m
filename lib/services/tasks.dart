import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/inner_tasks.dart';

class TaskService{

  static final tasks = [
    TaskModel(
        title: "Дорисовать дизайн",
        innerTasks: []
    ),
    TaskModel(
      title: "Дописать тз на стажировку",
      innerTasks: InnerTasksService.innerTasks
    ),
    TaskModel(
        title: "Дописать план",
        innerTasks: []
    ),
  ];

}