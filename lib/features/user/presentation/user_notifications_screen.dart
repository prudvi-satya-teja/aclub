import 'package:flutter/material.dart';

class UserNotificationsScreen extends StatelessWidget {
  const UserNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      "Notification 1: Event reminder",
      "Notification 2: Club meeting",
      "Notification 3: New club added",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
            leading: const Icon(Icons.notifications),
          );
        },
      ),
    );
  }
}
