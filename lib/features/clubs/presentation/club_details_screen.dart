import 'package:flutter/material.dart';

class ClubDetailsScreen extends StatelessWidget {
  const ClubDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String clubName = args['clubName'] ?? 'Club';

    return Scaffold(
      appBar: AppBar(
        title: Text('$clubName Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to $clubName!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Organizers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('John Doe, Jane Smith'),
            const SizedBox(height: 16),
            const Text(
              'Members: 50',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You have joined the club!')),
                );
              },
              child: const Text('Join Club'),
            ),
          ],
        ),
      ),
    );
  }
}
