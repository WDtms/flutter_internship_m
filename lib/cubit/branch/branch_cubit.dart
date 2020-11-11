import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/repository/interactor.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState>{
  final TaskInteractor _taskRepositoryAlpha;

  BranchCubit(this._taskRepositoryAlpha) : super(BranchInitialState());


}