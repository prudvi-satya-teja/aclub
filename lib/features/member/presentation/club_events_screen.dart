import 'package:flutter/material.dart';

class ClubEventsScreen extends StatelessWidget {
  const ClubEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Events'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual event count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Event $index'),
              subtitle: const Text('Event Details'),
            ),
          );
        },
      ),
    );
  }
}
