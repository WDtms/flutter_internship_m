
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/branch.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/data/repository/branch_repository.dart';
import 'package:flutter_internship_v2/domain/models/all_branch_info.dart';
import 'package:flutter_internship_v2/domain/models/one_branch_info.dart';
import 'package:uuid/uuid.dart';

class BranchInteractor {

  final BranchRepository branchRepository;

  BranchInteractor({this.branchRepository});

  //Инициализация всей информации, при наличии ее в базе данных
  Future<void> initiateBranches() async {
    await branchRepository.initializeBranches();
  }

  //Создание новой ветки
  Future<void> createNewBranch(String branchName, Map<Color, Color> theme) async{
    await branchRepository.createNewBranch(
        Branch(
          Uuid().v4(),
          branchName,
          {},
          theme,
        )
    );
  }

  //Удаление ветки
  Future<void> removeBranch(String branchID) async {
    await branchRepository.deleteBranch(branchID);
  }

  /*
  Получение всей нужной информации и преобразование ее в модель
  для ее отображения на главной странице в карточке информации по всем веткам
   */
  AllBranchesInfo getAllBranchesTasksInfo() {
    Map<String, Branch> branches = branchRepository.getAllBranches();
    int countAllCompleted = 0;
    int countAllUnCompleted = 0;
    for (int i = 0; i<branches.length; i++){
      Map<int, int> tasksInfo = _calculateTaskInfo(branches.values.toList().elementAt(i).taskList);
      countAllCompleted += tasksInfo.keys.toList().first;
      countAllUnCompleted += tasksInfo.values.toList().first;
    }
    return AllBranchesInfo(
      countAllCompleted,
      countAllUnCompleted,
    );
  }

  /*
  Получение всей нужной информации и преобразование ее в список моделей
  для последующего отображения в карточке одной ветки
   */
  List<OneBranchInfo> getAllBranchesInfo() {
    Map<String, Branch> branches = branchRepository.getAllBranches();
    List<OneBranchInfo> branchesInfo = List<OneBranchInfo>();
    for (int i = 0; i<branches.length; i++){
      Branch branch = branches.values.toList().elementAt(i);
      Map<int, int> tasksInfo = _calculateTaskInfo(branch.taskList);
      branchesInfo.add(
          OneBranchInfo(
            branch.id,
            branch.title,
            tasksInfo.keys.toList().first,
            tasksInfo.values.toList().first,
            branch.theme.keys.toList().first,
            branch.theme.values.toList().first,
          )
      );
    }
    return branchesInfo;
  }


  //Высчитывание информации по всем веткам
  Map<int, int> _calculateTaskInfo(Map<String, Task> taskList){
    int countCompleted = 0;
    int countUncompleted = 0;
    for (int i = 0; i<taskList.length; i++){
      if (taskList.values.toList().elementAt(i).isDone)
        countCompleted++;
      else
        countUncompleted++;
    }
    return {countCompleted : countUncompleted};
  }

}