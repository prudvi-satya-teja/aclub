import 'package:flutter/material.dart';

class ManageClubsScreen extends StatelessWidget {
  const ManageClubsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Clubs'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.group),
            title: Text('Club $index'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Add editing logic
              },
            ),
          );
        },
      ),
    );
  }
}
