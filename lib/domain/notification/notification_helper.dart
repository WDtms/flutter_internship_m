import 'package:flutter/services.dart';
import 'package:flutter_internship_v2/data/models/task.dart';


class NotificationHelper{

  static const platform = MethodChannel('internship/notifications');

  static Future<void> scheduleNotification(Task task) async {
    return await platform.invokeMethod('scheduleNotification', {
      "task_id": task.id,
      "title": task.title,
      "time_millis": task.notificationTime,
    });
  }

}