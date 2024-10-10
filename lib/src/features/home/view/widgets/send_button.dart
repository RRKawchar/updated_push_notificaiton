import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_check/src/features/home/controller/home_controller.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return ElevatedButton(
      onPressed: () {
        homeController.sendNotification();
      },
      child: const Text("Send Notification"),
    );
  }
}
