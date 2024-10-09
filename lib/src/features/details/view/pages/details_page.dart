import 'package:flutter/material.dart';
import 'package:push_notification_check/src/features/home/model/notification_model.dart';

class DetailsPage extends StatelessWidget {
  final NotificationModel notificationModel;

  const DetailsPage({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notificationModel.name ?? 'No Name Provided'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Story ID:',
            ),
            Text(notificationModel.storyId ?? 'No Story ID',),
            const SizedBox(height: 16),
            const Text(
              'Name:',
            ),
            Text(notificationModel.name ?? 'No Name',),
            const SizedBox(height: 16),
            const Text(
              'Phone:',
            ),
            Text(notificationModel.phone ?? 'No Phone',),
            const SizedBox(height: 16),
            const Text(
              'About:',
            ),
            Text(notificationModel.about ?? 'No About Information',),
            const SizedBox(height: 16),
            if (notificationModel.image != null)
              Image.network(notificationModel.image!),
          ],
        ),
      ),
    );
  }
}
