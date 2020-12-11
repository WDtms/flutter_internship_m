
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
  final FilterParameters filterParameters;

  TaskInUsageState({this.taskList, this.filterParameters});
}