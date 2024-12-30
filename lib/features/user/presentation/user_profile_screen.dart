import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile_placeholder.png"),
            ),
            const SizedBox(height: 16),
            const Text("User Name", style: TextStyle(fontSize: 20)),
            const Text("user@example.com"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/editProfile");
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
