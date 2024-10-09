import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification_check/src/core/helper/helper_method.dart';
import 'package:push_notification_check/src/core/service/local_notification_service.dart';

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static void firebaseInitNotification() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        kPrint('Got a message whilst in the foreground!');
        kPrint('Message data: ${message.data}');

        if (message.notification != null) {
          kPrint('Message also contained a notification: ${message.notification}');

          /// This showNotification Method is very important to show notification...
            LocalNotificationService.handleForegroundNotification(message);
        }
      },
    );
  }



  static Future<void> setupInteractMessage() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    RemoteMessage? initializeMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initializeMessage != null) {
      kPrint("Check Setup Interact Message: ${initializeMessage.notification}");
      String payload = jsonEncode(initializeMessage.data);
      LocalNotificationService.handleNavigationMessage(payload);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        kPrint("Check Setup onMessageOpenedApp Message: ${message.notification}");
        String payload = jsonEncode(message.data);
        LocalNotificationService.handleNavigationMessage(payload);
      },
    );
  }




  static Future<void> setForegroundIosMessageOptions() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }



  ///  Permission method
  static void requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      kPrint("user notification granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      kPrint("User granted provisional permission");
    } else {
      kPrint("User denied permission");
    }
  }

}
