import 'package:flutter/material.dart';

class ClubDetailsScreen extends StatelessWidget {
  final int clubId;

  const ClubDetailsScreen({Key? key, required this.clubId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Club Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Club Name $clubId", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            const Text("Detailed information about the club."),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back to Clubs List"),
            ),
          ],
        ),
      ),
    );
  }
}
