import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team UI',
      theme: ThemeData(primarySwatch: Colors.red),
      home: TeamPage(),
    );
  }
}

class TeamPage extends StatelessWidget {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Sheila Cuadros',
      role: 'Organizer',
      department: 'Diseño',
      imageUrl: 'https://via.placeholder.com/150',
      socialLinks: SocialLinks(facebook: '#', twitter: '#', linkedin: '#'),
    ),
    TeamMember(
      name: 'Ronaldo Alvarez',
      role: 'Organizer',
      department: 'Diseño',
      imageUrl: 'https://via.placeholder.com/150',
      socialLinks: SocialLinks(facebook: '#', twitter: '#', linkedin: '#'),
    ),
    TeamMember(
      name: 'Leslie Saravia',
      role: 'Organizer',
      department: 'Logística',
      imageUrl: 'https://via.placeholder.com/150',
      socialLinks: SocialLinks(facebook: '#', twitter: '#', linkedin: '#'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: teamMembers.length,
        itemBuilder: (context, index) {
          return TeamMemberCard(member: teamMembers[index]);
        },
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String role;
  final String department;
  final String imageUrl;
  final SocialLinks socialLinks;

  TeamMember({
    required this.name,
    required this.role,
    required this.department,
    required this.imageUrl,
    required this.socialLinks,
  });
}

class SocialLinks {
  final String facebook;
  final String twitter;
  final String linkedin;

  SocialLinks({required this.facebook, required this.twitter, required this.linkedin});
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember member;

  TeamMemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(member.imageUrl),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(member.role, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                      SizedBox(width: 8),
                      Text(member.department, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.backpack, color: Colors.lightBlue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.link, color: Colors.blueAccent),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
