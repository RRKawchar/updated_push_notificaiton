import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;


class TokenService{

  static Future<String> getAccessToken()async{


    List<String> scopes=[
      "https://www.googleapis.com/auth/firebase.messaging"
    ];


    http.Client client =await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );


    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();


    return credentials.accessToken.data;
  }



  static Future<String> getDeviceToken()async{
   String? token=await FirebaseMessaging.instance.getToken();
   return token!;
  }









}
