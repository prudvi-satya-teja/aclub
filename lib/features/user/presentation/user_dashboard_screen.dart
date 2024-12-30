import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to the User Dashboard!"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/userClubsList");
              },
              child: const Text("View Clubs"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/userNotifications");
              },
              child: const Text("Notifications"),
            ),
          ],
        ),
      ),
    );
  }
}
