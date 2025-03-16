import 'package:flutter/material.dart';
import 'event_selection.dart';
import 'club_memebers_list.dart';
import 'add_user_deatils.dart';
import 'update_user_deatils.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF040737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildCard('Event Creation', Icons.event, context, EventCreation()),
            _buildCard('Club Members', Icons.group, context,ClubMembersList()),
            _buildCard('Add User', Icons.person_add, context,UserDetails()),
            _buildCard('Update User', Icons.edit_note, context, UpdateUserDetails ()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      String title, IconData icon, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.7),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color:Color(0xFF040737) ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF040737),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
