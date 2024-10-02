import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');

  static initNotification() async {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    );
  }

  static showLocalNotification(String title, String body,String payload) {
    const androidNotificationDetail = AndroidNotificationDetails(
      '0',
      'general' ,
      priority: Priority.high,
      autoCancel: false,
      fullScreenIntent: true,
      enableVibration: true,
      importance: Importance.high,
      playSound: true,
    );
    const iosNotificatonDetail = DarwinNotificationDetails();
    const  notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,

    );
    flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails,payload: payload);
  }
}