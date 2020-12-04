import 'package:flutter/material.dart';

class OneBranchInfo{

  //Модель для отображения всей информации на карточке одной ветки

  //ID ветки
  final String id;
  //
  //Название ветки
  final String title;
  //
  //Количество завершенных задач
  final int countCompletedTasks;
  //
  //Количество незавершенных задач
  final int countUnCompletedTasks;
  //
  //Главный цвет темы, используемый так же для анимации
  final Color completedColor;
  //
  //Второй цвет темы
  final Color backGroundColor;

  //Высчитывание всего прогресса ветки
  double get progress => (countCompletedTasks+countUnCompletedTasks) == 0? 0 :
  countCompletedTasks/(countUnCompletedTasks+countCompletedTasks);

  OneBranchInfo({
    this.id,
    this.title,
    this.countCompletedTasks,
    this.countUnCompletedTasks,
    this.completedColor,
    this.backGroundColor,
  });

}