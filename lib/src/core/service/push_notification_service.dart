import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification_check/src/core/helper/helper_method.dart';
import 'package:push_notification_check/src/core/service/local_notification_service.dart';


/// if notification show from data object then not give notification object in notification body. only will be data
/// like this
// {
//       "message": {
//         "token": "fivakDDmTDOSihMPrbyggo:APA91bGYXkf_szkrupjuxR4vSiA583IUPQXGhzo2Ja0eEK9tO9eNrs23siEHvDjJAqV5_R6Vy149vM6yXIZqSyWGYgI4PR2JfLqofI67-WatebQtEi7eactlYbjZYZ1kDWOt4bD0nht3",
//         "data": {
//           "title": "Data Message",
//           "body": "This is a data-only message",
//           "storyId": "story_12345",
//           "name": "Riyazur Rohman Kawchar",
//           "phone": "01888610543",
//           "about": "Software Engineer",
//           "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjIxYgirGsehVewxjdCfN7-d1M05HyK5uArRKC4Df4QPfi1nWTLCvYrijowA&s"
//         }
//       }
//     }


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
      },
    );
  }


/// set up Interact Message
  /// This method work when app is opened via a click notification
  static Future<void> setupInteractMessage() async {
    // Enable automatic FCM initialization
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // Handle the case when the app is opened from a terminated state
    RemoteMessage? initializeMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initializeMessage != null && initializeMessage.data.isNotEmpty) {
      kPrint("App opened from terminated state with data message: ${initializeMessage.data}");
      LocalNotificationService.handleForegroundNotification(initializeMessage);
      String payload = jsonEncode(initializeMessage.data);
      LocalNotificationService.handleNavigationMessage(payload);
    }

    // Handle messages when the app is opened via notification click (background state)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      kPrint("App opened via notification click with data message: ${message.data}");
      LocalNotificationService.handleForegroundNotification(message);
      String payload = jsonEncode(message.data);
      LocalNotificationService.handleNavigationMessage(payload);
    });
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
