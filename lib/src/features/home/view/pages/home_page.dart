import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_check/src/features/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){


                 homeController.sendNotification();


              }, child:const Text("Send Notification")),
            ],
          )
        ],
      ),
    );
  }
}
