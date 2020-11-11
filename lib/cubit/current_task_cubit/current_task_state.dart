

part of 'current_task_cubit.dart';

@immutable
abstract class CurrentTaskState{
}

class CurrentTaskInitialState extends CurrentTaskState {
}

class CurrentTaskLoadingState extends CurrentTaskState {
}

class CurrentTaskInUsageState extends CurrentTaskState {
  final TaskModel task;

  CurrentTaskInUsageState({this.task});
}