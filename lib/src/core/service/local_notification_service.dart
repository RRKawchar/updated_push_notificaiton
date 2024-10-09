

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:push_notification_check/src/features/details/view/pages/details_page.dart';
import 'package:push_notification_check/src/features/home/model/notification_model.dart';

class LocalNotificationService {
  static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 static void initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
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
          handleNavigationMessage(response.payload);
      }

    );
  }

  static void showNotification(RemoteMessage message) async {
    final notification = message.notification;
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id', 'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails=DarwinNotificationDetails(
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails,iOS:iosDetails,);
    final payload = jsonEncode(message.data);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification!.title,
      notification.body,
      platformDetails,
      payload: payload
    );
  }


  static void handleNavigationMessage(String? payload) {
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      NotificationModel notificationModel = NotificationModel.fromJson(data);
      Get.to(() => DetailsPage(notificationModel: notificationModel));
    }

  }


  static void handleForegroundNotification(RemoteMessage message){
    if (message.notification != null) {
      showNotification(message);
    }
  }




}