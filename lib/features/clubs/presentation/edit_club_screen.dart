import 'package:flutter/material.dart';

class EditClubScreen extends StatelessWidget {
  const EditClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String clubName = args['clubName'] ?? 'Club';
    final TextEditingController clubNameController =
    TextEditingController(text: clubName);
    final TextEditingController clubDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit $clubName'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Club Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: clubNameController,
              decoration: const InputDecoration(hintText: 'Enter club name'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: clubDescriptionController,
              maxLines: 4,
              decoration: const InputDecoration(hintText: 'Enter description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final updatedName = clubNameController.text.trim();
                final updatedDescription = clubDescriptionController.text.trim();

                if (updatedName.isEmpty || updatedDescription.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required!')),
                  );
                  return;
                }

                // Update club logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$updatedName updated successfully!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Update Club'),
            ),
          ],
        ),
      ),
    );
  }
}
