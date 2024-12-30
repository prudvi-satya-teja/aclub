import 'package:flutter/material.dart';

class MemberClubScreen extends StatelessWidget {
  const MemberClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Clubs'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual club count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Club $index'),
            subtitle: const Text('Club Description'),
            onTap: () {
              Navigator.pushNamed(context, '/club-details');
            },
          );
        },
      ),
    );
  }
}
