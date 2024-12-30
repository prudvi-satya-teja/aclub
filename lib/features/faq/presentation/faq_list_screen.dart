import 'package:flutter/material.dart';

class FAQListScreen extends StatelessWidget {
  const FAQListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with your data length
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('FAQ Title $index'),
            subtitle: Text('Short description of FAQ $index'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/faq-details', arguments: index);
            },
          );
        },
      ),
    );
  }
}
