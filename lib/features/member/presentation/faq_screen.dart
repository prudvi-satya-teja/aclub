import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual FAQ count
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text('Question $index'),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Answer for the question goes here.'),
              ),
            ],
          );
        },
      ),
    );
  }
}
