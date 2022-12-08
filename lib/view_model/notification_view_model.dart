import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationViewModel {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
//image for notification in android.
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("mipmap/ic_launcher");
//initilazie of notification
  void initializeNotification() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

//notification title and body
  void sendNotification(
    String title,
    String body,
  ) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }
}
