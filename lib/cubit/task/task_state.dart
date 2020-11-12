
part of 'task_cubit.dart';

@immutable
abstract class TaskState{

}

class TaskInitialState extends TaskState{

}

class TaskLoadingState extends TaskState{

}

class TaskInUsageState extends TaskState{
  final taskList;

  TaskInUsageState({this.taskList});
}