import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:push_notification_check/src/core/helper/helper_method.dart';
import 'package:push_notification_check/src/core/service/push_notification_service.dart';
import 'package:push_notification_check/src/core/service/token_service.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController{

  RxString token="".obs;

  @override
  void onInit() async{
    super.onInit();
     getDeviceToken();
     getAccessToken();
    PushNotificationService.requestNotificationPermission();

    if (Platform.isIOS) {
      await PushNotificationService.setForegroundIosMessageOptions();
    }
    await PushNotificationService.setupInteractMessage();
    PushNotificationService.firebaseInitNotification();

  }

  getDeviceToken()async{
   token.value=await TokenService.getDeviceToken();
   kPrint("The Device Token :: ${token.value}");
  }

  getAccessToken()async{
    final String accessToken = await TokenService.getAccessToken();
    kPrint("Get Access Token for bearer token: $accessToken");
  }

  Future<void> sendNotification()async {
    final String accessToken = await TokenService.getAccessToken();
    kPrint("Get Access Token for bearer token: $accessToken");
    String endpointCloudMessaging = "https://fcm.googleapis.com/v1/projects/push-notification-check-537d4/messages:send";

    final Map<String, dynamic> message = {
      "message": {
        "token": token.value,
        "notification": {
          "body": "This is an FCM notification message!",
          "title": "FCM Message"
        },
        "data": {
          "screenId": "story_12345",
          "name": "Riyazur Rohman Kawchar",
          "phone": "01888610543",
          "about": "Software Engineer",
          "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjIxYgirGsehVewxjdCfN7-d1M05HyK5uArRKC4Df4QPfi1nWTLCvYrijowA&s"
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if(response.statusCode==200){
      kPrint("Notification send successfully!");
    }else{
      kPrint("Notification send Filed! : ${response.statusCode}");
    }

  }




}