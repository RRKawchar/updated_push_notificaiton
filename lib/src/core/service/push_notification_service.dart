import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification_check/src/core/helper/helper_method.dart';
import 'package:push_notification_check/src/core/service/local_notification_service.dart';

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Firebase Init Notification
  /// This method work when app will have foreground or will have open
  static void firebaseInitNotification() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        kPrint('Got a message whilst in the foreground!');
        kPrint('Message data: ${message.data}');
        LocalNotificationService.handleForegroundNotification(message);
        // if (message.notification != null) {
        //   kPrint('Message also contained a notification: ${message.notification}');
        //
        //   /// This showNotification Method is very important to show notification when app will have open
        //     LocalNotificationService.handleForegroundNotification(message);
        // }
      },
    );
  }


/// set up Interact Message
  /// This method work when app is opened via a click notification
  static Future<void> setupInteractMessage() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    RemoteMessage? initializeMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initializeMessage != null) {
      LocalNotificationService.handleForegroundNotification(initializeMessage);

      kPrint("Check Setup Interact Message: ${initializeMessage.data}");
      // LocalNotificationService.handleForegroundNotification(initializeMessage);
       String payload = jsonEncode(initializeMessage.data);
      LocalNotificationService.handleNavigationMessage(payload);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("Check Setup onMessageOpenedApp Message: ${message.data}");
        LocalNotificationService.handleForegroundNotification(message);
        String payload = jsonEncode(message.data);
        LocalNotificationService.handleNavigationMessage(payload);
      },
    );
  }



  /// This method is necessary for iOS because, by default,
  /// notifications are not shown in the foreground.
  /// This ensures that the user still receives visual or audible cues even if the app is open.
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
      kPrint("User granted provisional permission: temporary permission");
    } else {
      kPrint("User denied permission");
    }
  }

}
