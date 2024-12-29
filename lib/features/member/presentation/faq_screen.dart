import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('How to join a club?'),
            subtitle: Text('You can join any club through the app.'),
          ),
          ListTile(
            title: Text('How to create a club?'),
            subtitle: Text('Only admins can create clubs.'),
          ),
        ],
      ),
    );
  }
}
