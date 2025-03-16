import 'package:flutter/material.dart';
import 'package:aclub/auth/authService.dart';
import 'package:aclub/rollno.dart';
import 'dart:convert'; // Import to decode JSON

class ClubMembersList extends StatefulWidget {
  @override
  State<ClubMembersList> createState() => _ClubMembersListState();
}

class _ClubMembersListState extends State<ClubMembersList> {
  List<dynamic> members = [];
  AuthService authService = AuthService();

  void getClubMembers() async {
    final response = await authService.getAllClubMembers(Shared().clubId);
    if (response.containsKey('status') && response['status'] == "Success") {
      if (mounted) {
        setState(() {
          members = response['users'];
        });
      }
    }
  }

void showDeleteDialog(BuildContext context, String memberName, String rollNo, String role) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Member"),
        content: Text("Are you sure you want to delete $memberName?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close the dialog

              // Send delete request
              final response = await authService.deleteClubMember(rollNo, role);

              if (response.containsKey('status') && response['status'] == "true") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(response['msg']),
                  ),
                );

                // Remove deleted member from list
                setState(() {
                  members.removeWhere((member) => member['rollno'] == rollNo);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(response['msg'] ?? "Failed to delete member."),
                  ),
                );
              }
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}


  @override
  void initState() {
    super.initState();
    getClubMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Members', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF040737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: members.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF040737),
                      child: Text(
                        member['name']?.substring(0, 1).toUpperCase() ?? 'U',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      member['name'] ?? 'Unknown',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Roll No: ${member['rollno']}'),
                        Text('Phone: ${member['phoneNo'] ?? 'N/A'}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDeleteDialog(context, member['name'] ?? 'this member', member['rollno'], member['role']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
