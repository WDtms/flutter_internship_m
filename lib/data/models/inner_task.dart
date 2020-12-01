


import 'package:flutter_internship_v2/presentation/constants/db_constants.dart';

class InnerTask{

  String id;
  String title;
  bool isDone;

  InnerTask({this.id, this.title, this.isDone = false});

  Map<String, dynamic> toMap(String branchID, String taskID) {
    return {
      DBConstants.innerTaskId : id,
      DBConstants.innerTaskTitle: title,
      DBConstants.innerTaskIsDone: isDone ? 1 : 0,
      DBConstants.branchId: branchID,
      DBConstants.taskId: taskID,
    };
  }

  InnerTask fromMap(Map<String, dynamic> row){
    return InnerTask(
      id: row[DBConstants.innerTaskId],
      title: row[DBConstants.innerTaskTitle],
      isDone: row[DBConstants.innerTaskIsDone] == 1 ? true : false,
    );
  }

  InnerTask copyWith({
    String id,
    String title,
    bool isDone,
  }) {
    return InnerTask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}