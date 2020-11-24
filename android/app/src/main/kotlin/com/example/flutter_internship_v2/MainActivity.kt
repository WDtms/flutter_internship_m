package com.example.flutter_internship_v2

import android.app.AlarmManager
import android.app.Notification
import android.app.PendingIntent
import android.content.Intent
import androidx.annotation.NonNull
import androidx.core.app.NotificationCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    companion object{
        private const val FLUTTER_CHANNEL = "internship/notifications"
        const val NOTIFICATION_CHANNEL_ID = "TASK_CHANNEL_ID"
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, FLUTTER_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "scheduleNotification" -> {
                    val taskId = call.argument<String>("task_id")!!
                    val title = call.argument<String>("title")!!
                    val time = call.argument<Long>("time_millis")!!
                    val notification = getNotification(title, time)

                    val id = taskId.hashCode()
                    scheduleNotification(notification, id, time)
                    return@setMethodCallHandler result.success(true)
                }
                "cancelNotification" -> {
                    val taskId = call.argument<String>("task_id")!!
                    val title = call.argument<String>("title")!!
                    val time = call.argument<Long>("time_millis")!!
                    val notification = getNotification(title, time)

                    val id = taskId.hashCode()
                    cancelNotification(notification, id)
                    return@setMethodCallHandler result.success(true)
                }
                else -> {
                    return@setMethodCallHandler result.notImplemented()
                }
            }
        }
    }

    private fun scheduleNotification(notification: Notification, id: Int, time_millis: Long) {
        val alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
        alarmManager[AlarmManager.RTC_WAKEUP, time_millis] = getNotificationPendingIntent(notification, id)
    }

    private fun cancelNotification(notification: Notification, id: Int) {
        val alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
        alarmManager.cancel(getNotificationPendingIntent(notification, id))
    }

    private fun getNotificationPendingIntent(notification: Notification, id: Int): PendingIntent {
        val notificationIntent = Intent(this, NotificationPublisher::class.java)
        notificationIntent.putExtra(NotificationPublisher.NOTIFICATION_ID, id)
        notificationIntent.putExtra(NotificationPublisher.NOTIFICATION, notification)
        return PendingIntent.getBroadcast(this, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)
    }

    private fun getNotification(content: String, time: Long): Notification {
        val notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
                .setContentTitle("Напоминание о задаче")
                .setContentText(content)
                .setAutoCancel(true)
                .setSmallIcon(R.drawable.icon)
                .setWhen(time)
                .setShowWhen(true)
        return notification.build()
    }
}