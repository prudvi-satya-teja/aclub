import 'package:flutter/material.dart';

class UserClubsListScreen extends StatelessWidget {
  const UserClubsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clubs List"),
      ),
      body: ListView.builder(
        itemCount: 10, // Simulated club count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Club $index"),
            subtitle: const Text("Club description here."),
            onTap: () {
              Navigator.pushNamed(context, "/clubDetails", arguments: index);
            },
          );
        },
      ),
    );
  }
}
