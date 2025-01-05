import 'package:flutter/material.dart';

class ManageClubMembersScreen extends StatelessWidget {
  const ManageClubMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> members = ['Alice', 'Bob', 'Charlie', 'Diana']; // Sample data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Club Members'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return ListTile(
            title: Text(member),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () {
                // Remove member logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$member removed from club.')),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add member logic here
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Member'),
              content: TextField(
                decoration: const InputDecoration(hintText: 'Enter member name'),
                onSubmitted: (value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$value added to the club.')),
                  );
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
