

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:push_notification_check/src/features/details/view/pages/details_page.dart';

class LocalNotificationService {
  static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 static void initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher',);
    const DarwinInitializationSettings initializationSettingsIos=DarwinInitializationSettings(
        defaultPresentAlert: true,
        defaultPresentBadge: true,
         requestAlertPermission: true,
          requestSoundPermission: true,

    );
    const InitializationSettings initializationSettings = InitializationSettings(

        android: initializationSettingsAndroid,
        iOS:initializationSettingsIos,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(NotificationResponse response){
          _handleNavigationMessage(response.payload);
      }

    );
  }

  static void showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id', 'channel_name',
      importance: Importance.max,
      priority: Priority.high,


    );

    const DarwinNotificationDetails iosDetails=DarwinNotificationDetails(
      presentSound: true,

    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails,iOS:iosDetails,);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformDetails,
    );
  }


  static void _handleNavigationMessage(String? payload) {
    Get.to(()=>const DetailsPage());
  }


  static void handleForegroundNotification(RemoteMessage message){
    if (message.notification != null) {
      showNotification(message.notification!);
    }
  }




}