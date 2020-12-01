

import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';

import 'inner_task.dart';

class Task{

  String id;
  String title;
  bool isDone;
  String description;
  DateTime dateOfCreation;
  DateTime dateToComplete;
  DateTime notificationTime;
  Map<String, InnerTask> innerTasks;
  List<String> imagesPath;

  Task({this.id, this.title, this.isDone = false, this.innerTasks, this.dateOfCreation, this.dateToComplete, this.notificationTime, this.description = "", this.imagesPath});

  Map<String, dynamic> toMap(String branchID) {
    return {
      DBConstants.taskId : id,
      DBConstants.taskTitle: title,
      DBConstants.taskIsDone: isDone ? 1 : 0,
      DBConstants.taskDescription: description,
      DBConstants.branchId: branchID,
      DBConstants.taskDateOfCreation: dateOfCreation.millisecondsSinceEpoch,
      DBConstants.taskDateToComplete: dateToComplete == null ? 0 : dateToComplete.millisecondsSinceEpoch,
      DBConstants.taskNotificationTime: notificationTime == null ? 0 : notificationTime.millisecondsSinceEpoch,
      DBConstants.taskImages: _encodeImagesToDB(imagesPath),
    };
  }

  Task fromMap(Map<String, dynamic> row) {
    return Task(
      id: row[DBConstants.taskId],
      title: row[DBConstants.taskTitle],
      isDone: row[DBConstants.taskIsDone] == 1 ? true : false,
      dateToComplete: row[DBConstants.taskDateToComplete] == 0 ? null
          : DateTime.fromMillisecondsSinceEpoch(row[DBConstants.taskDateToComplete]),
      dateOfCreation: DateTime.fromMillisecondsSinceEpoch(row[DBConstants.taskDateOfCreation]),
      notificationTime: row[DBConstants.taskNotificationTime] == 0 ? null
          : DateTime.fromMillisecondsSinceEpoch(row[DBConstants.taskNotificationTime]),
      innerTasks: {},
      description: row[DBConstants.taskDescription],
      imagesPath: _decodeImagesFromDB(row[DBConstants.taskImages]),
    );
  }

  List<String> _decodeImagesFromDB(String images){
    if (images == "")
      return List<String>();
    List<String> imagesList = images.split("*");
    return imagesList;
  }

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

  Task copyWith({
    String id,
    String title,
    bool isDone,
    DateTime dateOfCreation,
    DateTime dateToComplete,
    DateTime notificationTime,
    List<InnerTask> innerTasks,
    String description,
    List<String> imagesPath,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      dateOfCreation: dateOfCreation ?? this.dateOfCreation,
      dateToComplete: dateToComplete ?? this.dateToComplete,
      notificationTime: notificationTime ?? this.notificationTime,
      innerTasks: innerTasks ?? this.innerTasks,
      description: description ?? this.description,
      imagesPath: imagesPath ?? this.imagesPath,
    );
  }

}