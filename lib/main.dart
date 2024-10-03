import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:push_notification_check/src/core/service/local_notification_service.dart';
import 'package:push_notification_check/src/core/service/push_notification_service.dart';
import 'package:push_notification_check/src/features/home/view/pages/home_page.dart';

// Initialize the FlutterLocalNotificationsPlugin
 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
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


  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // initializeNotifications();
  LocalNotificationService.initializeNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      showNotification(message.notification!);
    }
  });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //     showNotification(message.notification!);
  //   }
  // });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

// Show notification using flutter_local_notifications when app is in foreground
void showNotification(RemoteNotification notification) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id', 'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
    0,
    notification.title,
    notification.body,
    platformDetails,
  );
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


