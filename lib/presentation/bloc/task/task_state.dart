
part of 'task_cubit.dart';

@immutable
abstract class TaskState{

}

class TaskInitialState extends TaskState{

}

class TaskLoadingState extends TaskState{

}

class TaskInUsageState extends TaskState{
  final Map<String, Task> taskList;
  final bool isHidden;

  TaskInUsageState({this.taskList, this.isHidden});
}