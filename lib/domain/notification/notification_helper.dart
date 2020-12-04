import 'package:flutter/services.dart';
import 'package:flutter_internship_v2/data/models/task.dart';


class NotificationHelper{

  //Канал для работы с платформой
  static const platform = MethodChannel('internship/notifications');

  //Создание уведомления
  static Future<void> scheduleNotification(Task task) async {
    return await platform.invokeMethod('scheduleNotification', {
      "task_id": task.id,
      "title": task.title,
      "time_millis": task.notificationTime,
    });
  }

  //Удаление уведомления
  static Future<void> cancelNotification(Task task) async {
    return await platform.invokeMethod('cancelNotification', {
      "task_id": task.id,
      "title": task.title,
      "time_millis": task.notificationTime,
    });
  }

}