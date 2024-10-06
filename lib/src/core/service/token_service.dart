import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;


class TokenService{

  static Future<String> getAccessToken()async{

    final serviceAccountJson={
      "type": "service_account",
      "project_id": "push-notification-check-537d4",
      "private_key_id": "7b0d23730b450bfc444e04199cd484a26dd573eb",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDa0k+38qLeYEce\n9nxHP9yMWyvnukANp3SPGD35xJ4oUOHmpeFJFAN+2QnVrZG7eq0bcO4Z+IL7VuWH\ncWf+06scbGevD+MzivKknL51yO3dwfI8mUOZfrUy7tzABkC+O6LmQ5pCo7nhABb9\nxzklWVsrX1uG0Bm9VeR2SaboJ8OGlsxgevE7hQABKFmqV6mIxOStdyGH3g823GQn\nzY7IIewGI+Xj7AwPIzP+hKDVGv9Qm4MpfivXnYpSXUQN3bbNz0/EXZy+NX88NE4r\nmu1CrweaGiIZM1Wd5seab37PjhnLrNn7plWIZjYY+uM6WMMt7kcx7iw1NFM+rvaH\nPPuGfWkdAgMBAAECggEAM8BUiTkRqs0TVO/PgZxJYUp4rkO+vVvytZryoV0OWJOU\ncZOencVldD0JVedIVZIUWa6SKUM8Wwv4mdlI0pwl1kGPHfiAb+K3MxY89ydPlkg1\nrX5D3gv497RFMgbojfUVuCaZ15PYNK3sQhW5Xqts4+uX/mC+DajAMPeHSVWKKQyV\n62M80EJVB9n0Ni3XgqDxqr/+RFzlI5AY6yLIdgvUFfci5gyfbieGBHoasfsI1e+3\nmCq1ffz0/mVx+4Pl6r5wZkF7uAv1964ECUIY5dkLQ6BtzZkYlQQq6onHQxrj0xpI\n+KvkGKElCAq2wpW6P/Z1GSZwctjrfG4KcuJyDBNVEwKBgQD5ZSEEdgPDmcG1KzbF\nt8QurlKd2KyO+ynQHEcA7danzrEH/mvElqa+7OGlNkJ2TIOeDU8lu0H91qR1PqmB\nsCXnAs3PesEiWVLBKrxWSzLhV4fVNTnIciIGeXL5XaB8qiwo4zM59y4IeTWkOIqZ\nN0bzp+J88G+mgYTMYlhIbTNl7wKBgQDgneW8MBOAsoChZ+FhVdSdZFIw4WSg0j43\n/mqSws+QEIPn7WMvd6UC2RCosF3A3hiL/xFsYw7anAmqy6NoMxYUBbx2mZ52rLkj\no5sf9PNbSs9jbVQ7s1/fK1S0/5jq4hfqx9nBGuxSooZURG8J97Lx3b5C21YZNNG4\nS8Z7xqANswKBgHFluUCVBJsgw4JD9vCp4Ss0ml4pUjTlIRr+cI6MlmjQw5AV8ByA\nP6tafDMp28h8e/AWryFB5vyrZzXkWyCb3nAOx1QKxdx/bvBkJSS7ppPtv9aDEBYD\nR1NYT53xI3Lr0Y552CYILUcvDePwzZxjFQDfGk2i6bF0/NQN94RfGtrDAoGAGbK2\n+ALgGFdT1COYa5RwUNmLdcAzzRqAt9NJyiSzrp3VGZHVSTb9EAhZmZMkBs7iLBIw\noh/rMSOtD3dg6Kj/m6bUWxVUReuY+vTa6JsTxJwYgh2eB36MN3IzrMmZazYW2mun\nBCraYtHpYHa75X4LYRSnkeqaPSQH4nf462xcH3UCgYBws1QEr27cGteXuuWsThKQ\nucYAY+tIJOSSaT8NXO6YLFXZFBiTtXM5fS9kUgYT9h8S6XZ2nmVceD3RvURhOyYt\nTkftKQer1SUI/vMqBDbljoB3s/QWiWBP+EWhqixT9sCKDkTNXhFprybZMNU5k49f\nyIepQYcq87wmHf0LdSplCQ==\n-----END PRIVATE KEY-----\n",
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