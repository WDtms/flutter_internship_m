import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';
import 'inner_task.dart';

class Task{

  //Обязательные поля задачи
  //
  //ID
  final String id;
  //
  //Массив внутренних задач
  final Map<String, InnerTask> innerTasks;
  //
  //Дата создания
  final int dateOfCreation;
  //
  //Список путей к картинкам
  final List<String> imagesPath;
  //
  //Текст задачи
  String title;


  //Необязательные поля задачи
  //
  //Флаг, сигнализирующий о том, выполнена задача или нет
  bool isDone;
  //
  //Заметки к задаче
  String description;
  //
  //Дата завершения задачи
  int dateToComplete;
  //
  //Время, в которое появится уведомление
  int notificationTime;
  //
  //Заглавная картинка задачи
  String selectedImage;


  //Конструктор
  Task(this.id, this.title, this.innerTasks, this.imagesPath, this.dateOfCreation,
      {this.isDone = false, this.dateToComplete, this.notificationTime, this.description = "", this.selectedImage = ""});


  /*
  Преобразование объекта в Map для последующей
  отправки в базу данных
   */
  Map<String, dynamic> toMap(String branchID) {
    return {
      DBConstants.taskId : id,
      DBConstants.taskTitle: title,
      DBConstants.taskIsDone: isDone ? 1 : 0,
      DBConstants.taskDescription: description,
      DBConstants.branchId: branchID,
      DBConstants.taskDateOfCreation: dateOfCreation,
      DBConstants.taskDateToComplete: dateToComplete,
      DBConstants.taskNotificationTime: notificationTime,
      DBConstants.taskImages: _encodeImagesToDB(imagesPath),
      DBConstants.taskSelectedImage: selectedImage
    };
  }

  /*
  Преобразование списка всей галлереи картинок (если быть точнее - список
  всех путей к картинкам) одной задачи в строку, с разделением путей символом
   "*", для хранения оной в базе данных
   */
  String _encodeImagesToDB(List<String> imagesPath) {
    String allPath = "";
    for (int i = 0; i<imagesPath.length; i++){
      if (i == imagesPath.length - 1)
        allPath += imagesPath.elementAt(i);
      else
        allPath += imagesPath.elementAt(i)+"*";
    }
    return allPath;
  }


  /*
  Преобразование строки таблицы, полученной из базы
  данных в объект
   */
  factory Task.fromMap(Map<String, dynamic> row) {
    return Task(
      row[DBConstants.taskId],
      row[DBConstants.taskTitle],
      {},
      _decodeImagesFromDB(row[DBConstants.taskImages]),
      row[DBConstants.taskDateOfCreation],
      isDone: row[DBConstants.taskIsDone] == 1 ? true : false,
      dateToComplete: row[DBConstants.taskDateToComplete],
      notificationTime: row[DBConstants.taskNotificationTime],
      description: row[DBConstants.taskDescription],
      selectedImage: row[DBConstants.taskSelectedImage],
    );
  }

  /*
  Преобразование строки, полученной из базы данных, в список путей к картинкам
  одной задачи.
   */
  static List<String> _decodeImagesFromDB(String images){
    if (images == "")
      return List<String>();
    List<String> imagesList = images.split("*");
    return imagesList;
  }

  /*
  Функция, используемая для изменения задачи по какому-то одному аргументу, не
  меняя все остальные аргументы.
   */
  Task copyWith({
    String id,
    String title,
    bool isDone,
    int dateOfCreation,
    int dateToComplete,
    int notificationTime,
    List<InnerTask> innerTasks,
    String description,
    List<String> imagesPath,
    String selectedImage,
  }) {
    return Task(
      id ?? this.id,
      title ?? this.title,
      innerTasks ?? this.innerTasks,
      imagesPath ?? this.imagesPath,
      dateOfCreation ?? this.dateOfCreation,
      isDone: isDone ?? this.isDone,
      dateToComplete: dateToComplete ?? this.dateToComplete,
      notificationTime: notificationTime ?? this.notificationTime,
      description: description ?? this.description,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }

}