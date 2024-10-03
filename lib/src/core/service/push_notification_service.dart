import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification_check/src/core/helper/helper_method.dart';
import 'package:push_notification_check/src/core/service/token_service.dart';

class PushNotificationService{
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;






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