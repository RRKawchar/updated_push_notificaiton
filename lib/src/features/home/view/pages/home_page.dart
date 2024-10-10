import 'package:flutter/material.dart';
import 'package:push_notification_check/src/features/home/view/widgets/send_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             SendButton()
            ],
          )
        ],
      ),
    );
  }
}
