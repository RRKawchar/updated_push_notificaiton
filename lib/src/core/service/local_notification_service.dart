import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:push_notification_check/src/features/details/view/pages/details_page.dart';
import 'package:push_notification_check/src/features/home/model/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class LocalNotificationService {
  static  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(NotificationResponse response){
          handleNavigationMessage(response.payload);
      }
    );
    _createNotificationChannel();
  }


  /// crate notification channel
  static void _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      description: 'This channel is used for important notifications.',
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }


  /// this method for showing notification in local devices
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
    await _flutterLocalNotificationsPlugin.show(
      0,
      notification!.title,
      notification.body,
      platformDetails,
      payload: payload
    );
  }


  /// this method for show image in notification
  static Future<void> showNotificationWithImage(RemoteMessage message) async {
    _createNotificationChannel();

    final imageUrl = message.data['image'];
    if (imageUrl != null) {
      String? imagePath = await _downloadAndSavePicture(
          imageUrl, 'notification_image.jpg');
      if (imagePath != null) {
        final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel_id', 'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          styleInformation: BigPictureStyleInformation(
            FilePathAndroidBitmap(imagePath),
            contentTitle: message.data['name'],
            summaryText: '',
          ),
        );

        final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);
        final payload=jsonEncode(message.data);
        await _flutterLocalNotificationsPlugin.show(
          0,
          message.data['name'],
          message.data['about'],
          platformChannelSpecifics,
          payload: payload
        );
      }
    }
  }


  /// for show image convert image for notification
  static Future<String?> _downloadAndSavePicture(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = path.join(directory.path, fileName);
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      return null;
    }
  }


  static void handleNavigationMessage(String? payload) {
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      NotificationModel notificationModel = NotificationModel.fromJson(data);
      Get.to(() => DetailsPage(notificationModel: notificationModel));
    }
  }


  static void handleForegroundNotification(RemoteMessage message){

    if (message.data.isNotEmpty) {

      /// here if well will need image in notification then we will use
        showNotificationWithImage(message);
        // showNotification(message);
    }
  }




}


