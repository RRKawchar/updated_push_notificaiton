import 'dart:convert';
import 'package:get/get.dart';
import 'package:push_notification_check/src/core/helper/helper_method.dart';
import 'package:push_notification_check/src/core/service/push_notification_service.dart';
import 'package:push_notification_check/src/core/service/token_service.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController{

  RxString token="".obs;

  @override
  void onInit() {
    super.onInit();
     getDeviceToken();
    PushNotificationService.requestNotificationPermission();
  }

  getDeviceToken()async{
   token.value=await TokenService.getDeviceToken();
   kPrint("The Device Token :: ${token.value}");
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
          "story_id": "story_12345"
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
      print("Notification send successfully!");
    }else{
      print("Notification send Filed! : ${response.statusCode}");
    }

  }




}