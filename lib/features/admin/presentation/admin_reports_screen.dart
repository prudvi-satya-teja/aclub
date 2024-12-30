import 'package:flutter/material.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('User Registrations'),
              subtitle: const Text('Total: 500'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to detailed report
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Active Clubs'),
              subtitle: const Text('Total: 30'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to detailed report
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Events Organized'),
              subtitle: const Text('Total: 150'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to detailed report
              },
            ),
          ),
        ],
      ),
    );
  }
}
