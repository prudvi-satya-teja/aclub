import 'package:flutter/material.dart';

class AddClubScreen extends StatelessWidget {
  const AddClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController clubNameController = TextEditingController();
    final TextEditingController clubDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Club'),
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
                final clubName = clubNameController.text.trim();
                final clubDescription = clubDescriptionController.text.trim();

                if (clubName.isEmpty || clubDescription.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required!')),
                  );
                  return;
                }

                // Save club logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$clubName added successfully!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Save Club'),
            ),
          ],
        ),
      ),
    );
  }
}
