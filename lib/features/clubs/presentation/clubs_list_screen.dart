import 'package:flutter/material.dart';

class ClubsListScreen extends StatelessWidget {
  const ClubsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> clubs = ['Music Club', 'Art Club', 'Coding Club', 'Sports Club'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(clubs[index]),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/club_details',
                arguments: {'clubName': clubs[index]},
              );
            },
          );
        },
      ),
    );
  }
}
