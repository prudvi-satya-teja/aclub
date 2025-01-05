import 'package:flutter/material.dart';

class FAQDetailsScreen extends StatelessWidget {
  final int faqId;

  const FAQDetailsScreen({Key? key, required this.faqId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQ Title $faqId',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            const Text(
              'This is the detailed explanation for the selected FAQ. '
                  'You can replace this placeholder with your data.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
