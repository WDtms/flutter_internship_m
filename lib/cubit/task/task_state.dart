
part of 'task_cubit.dart';

@immutable
abstract class TaskState{
  const TaskState();
}

class TaskInitialState extends TaskState{
  const TaskInitialState();
}

class TaskLoadingState extends TaskState{
  const TaskLoadingState();
}

class TaskInUsageState extends TaskState{
  final taskList;

  const TaskInUsageState({this.taskList});
}