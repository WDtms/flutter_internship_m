class DBConstants{

  //Поля и названия для базы данных

  //Названия таблиц
  static const branchTable = 'Branch';
  static const taskTable = 'Task';
  static const innerTaskTable = 'InnerTask';
  //
  //Поля таблицы веток
  static const branchId = 'branchID';
  static const branchTitle = 'branchTitle';
  static const branchTheme = 'branchTheme';
  //
  //Поля таблицы задач
  static const taskId = 'taskID';
  static const taskTitle = 'taskTitle';
  static const taskIsDone = 'taskIsDone';
  static const taskDateToComplete = 'taskDateToComplete';
  static const taskDateOfCreation = 'taskDateOfCreation';
  static const taskNotificationTime = 'taskNotificationTime';
  static const taskDescription = 'taskDescription';
  static const taskImages = 'taskImages';
  static const taskSelectedImage = 'taskSelectedImage';
  static const taskImportance = 'taskImportance';
  static const taskFavor = 'taskFavour';
  //
  //Поля таблицы внутренних задач
  static const innerTaskId = 'innerTaskID';
  static const innerTaskTitle = 'innerTaskTitle';
  static const innerTaskIsDone = 'innerTaskIsDone';

}