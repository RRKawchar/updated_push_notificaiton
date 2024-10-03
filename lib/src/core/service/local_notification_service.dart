

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 static void initializeNotifications() {
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
      onDidReceiveNotificationResponse:(payload){

      }

    );
  }

}