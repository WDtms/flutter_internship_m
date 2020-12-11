
part of 'task_cubit.dart';

@immutable
abstract class TaskState{

}

class TaskInitialState extends TaskState{

}

class TaskLoadingState extends TaskState{

}

class TaskInUsageState extends TaskState{
  final List<TaskCardInfo> taskList;
  final bool isHidden;
  final bool isNewest;

  TaskInUsageState({this.taskList, this.isHidden, this.isNewest});
}