

part of 'branch_cubit.dart';

@immutable
abstract class BranchState{
}

class BranchInitialState extends BranchState{
}

class BranchLoadingState extends BranchState{
}

class BranchInUsageState extends BranchState{
  final AllBranchesInfo allBranchesTasksInfo;
  final List<OneBranchInfo> allBranchesInfo;

  BranchInUsageState({this.allBranchesTasksInfo, this.allBranchesInfo});
}