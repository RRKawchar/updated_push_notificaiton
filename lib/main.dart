import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_check/src/core/service/local_notification_service.dart';
import 'package:push_notification_check/src/core/service/push_notification_service.dart';
import 'package:push_notification_check/src/features/home/view/pages/home_page.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
       await Firebase.initializeApp();
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
  //LocalNotificationService.showNotification(message.notification!);
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB1NzYftoUqNbXA5akJHulXXC32ioAKib0",
        appId: "1:837749515291:android:b69eb85e6e652c38f9c4be",
        messagingSenderId: "837749515291",
        projectId: "push-notification-check-537d4",
      )
  ):
  await Firebase.initializeApp();

  LocalNotificationService.initializeLocalNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}


