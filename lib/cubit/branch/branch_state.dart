

part of 'branch_cubit.dart';

@immutable
abstract class BranchState{
  const BranchState();
}

class BranchInitialState extends BranchState{
  const BranchInitialState();
}

class BranchLoadingState extends BranchState{
  const BranchLoadingState();
}

class BranchInUsageState extends BranchState{
  final branches;

  const BranchInUsageState({this.branches});
}