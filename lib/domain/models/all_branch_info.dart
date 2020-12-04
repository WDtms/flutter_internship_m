class AllBranchesInfo {

  //Модель для отображения всей информации на главной странице в карточке инфы по всем задачам

  //Все завершенные задачи
  final int countAllCompleted;
  //
  //Все незавершенные задачи
  final int countAllUncompleted;

  AllBranchesInfo({this.countAllCompleted, this.countAllUncompleted});

  //Высчитывание прогресса для анимации прогрессбара
  double get progress => (countAllCompleted+countAllUncompleted) == 0? 0 : countAllCompleted/(countAllCompleted+ countAllUncompleted);

}