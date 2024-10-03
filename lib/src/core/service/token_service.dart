import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;


class TokenService{

  static Future<String> getAccessToken()async{

    final serviceAccountJson={
      "type": "service_account",
      "project_id": "push-notification-check-537d4",
      "private_key_id": "5797c6d79b71c5298e2ee7ef82842a958c75342a",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDmMykaL12stdqj\nKEn4qdSafAsyxdTrFkQg2NTwLB0QPBGtRQtQWqaQEOy+dAhXy5lZ/HbnP6V+lXcG\nkCTl59Ba5vwE4cE8K8ORHNTT1SX0PnW7YhOh0W3NdjzcZL25tl201qNotcIx1fSl\nBlk8KzuWJ8Vi7o+wdWg4JqBaxZyWA9mSsMIvmg6ehk4QelDuqv3eH7vuFWOr/FQ1\nro+Q2fkH3BGfZ5hzBkbHqmBQYXUJiIhGEax4sGNJm/4xhkIivhCmR2SaLCVOE1u9\nfneQHELpdIKHJmo78wepLOT+Nz5L1wMrtsj7/ivvZSbC21LlVq/FXWqPU1crJs02\nB3ulWH3dAgMBAAECggEAMYtHSFxzY82L7duo9/zNRiZ2XooXhjU3mn4wbjSAWNMk\n1s7qXXP1L0KFQYRFm2e1bJmambCoFLNkd6QkXNrki/v0t7RC24lrwNqcr67LSWL8\nAcVdBlHFuRe+h4yjDMpEJryfVNTxo7oxuibAo+OGIo4SvHUttcO/F36wuniXd+2Z\npjRwPnZ0W7p568GQ3/JOGtKIYzGiJVi/q8DG914f0fLDr9JpcCXqfafpetHbvzV2\nY5JHhJDtpOt3rkk+1ioZ7MzqdpOtub8CEK+yxPfgqijNmiAUY5GcLeLzH7gM3elL\nnnrPOhoXYh7t8m+Htvo/nl7+u2Vu2iTrEsAIqQvAfQKBgQD6NacXno14Ue/FOSyh\nmARiww0s04su9ARreqTmX11oT5Nc7n/g0zIkuBA6TP/f4v/T1C3aOqpGA+2o9oZH\nqOS/3yA+08vF5TKkbD8hB9xTcNtZAj9Jz3B9jVD/0x2nJWARowE+HF4XrpjQjNda\nyZNnxQWpJp/6T2b+hov3zOee+wKBgQDrhvYzpvq2h48eIqbXqFa/KqtpOv2vhOW5\nD4i7NpXA59yTwcz1xsoVsNFSHyAyj4sy2y6F+wHrACXa8WeXm5Jr7nfDZSonhPXF\n5aSMzjkLlYnUgfyNT0Vcne9MAoz07g2AvQbSWSYyH510g6H1acCVlGC82KmX/1hC\njvmAhcxfBwKBgQCGTNAgXGlhANHrEZJENl18SWfD/NRDYpUQv6bNRLjVaYkWo6me\nGp5amTWUpYneOXDJ2aS28zA8HpWtUI2o3x3RY0lij7pbwXdaTAPijd6UJwqFjzA7\nRQ4DRhwJBN9wvR4AuXbMSNu0aHH71u0s/O+TDmzIa0QJTh9hVQTCAIj+iwKBgCMu\n8AxbP0yRB4Ia7w18Kik4eI6pr0fO9HompehBiTFd8YdpBfMZFQsUdNBtseObqdGZ\nCGQfUPQH+5+vPChbpw3Ue7OGoztwEz7SxTf7fm4KkqJaIJ4DX3ssZJjYMLJN9Vpr\n4l79zkTikCTdnQ4KFCjEF4deXkdEb6zRqtfWJOd1AoGBAKTr3UzUKYqNePDKWNSX\nIcNcGiELNtX8i8qBjLyChxDTEoAgOVRtEou9I+g/Rr7ErilpLz16yEM3v3ZWHMOw\nerHM+yZ5QTForB3LFW1E0DYelzdI4GFwObHpxcnI43TWPbP84hvaBQdclFyKkYqZ\ny4oEx98c5gPLEufYR8jJPpoB\n-----END PRIVATE KEY-----\n",
      "client_email": "push-notification-check-app-te@push-notification-check-537d4.iam.gserviceaccount.com",
      "client_id": "103829864163611090124",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/push-notification-check-app-te%40push-notification-check-537d4.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

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