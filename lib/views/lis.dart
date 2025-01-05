import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda UI',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const AgendaScreen(),
    );
  }
}

// Agenda Screen with ListView
class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> agendaItems = [
    {
      'title': '404: Impuestos no Encontrados',
      'speaker': 'Jimmy Dolores',
      'time': '10:15 AM',
      'duration': '25 Mins',
      'profile': 'assets/Profile.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'Angular Perú',
    },
    {
      'title': 'Desarrollo móvil con Flutter',
      'speaker': 'Hansy Smitch',
      'time': '3:00 PM',
      'duration': '25 Mins',
      'profile': 'assets/Profile.png',
      'social': ['facebook', 'linkedin'],
      'organization': 'Flutter Perú',
    },
    {
      'title': 'Inteligencia Artificial en Apps',
      'speaker': 'Santiago Carrillo',
      'time': '4:00 PM',
      'duration': '25 Mins',
      'profile': 'assets/Profile.png',
      'social': ['web'],
      'organization': 'GDE Colombia',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget buildAgendaCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(data: item),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(item['profile']),
          ),
          title: Text(
            item['title'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${item['duration']} | ${item['time']}'),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Web', icon: Icon(Icons.web)),
            Tab(text: 'Mobile', icon: Icon(Icons.phone_android)),
            Tab(text: 'More', icon: Icon(Icons.more_horiz)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: agendaItems.length,
            itemBuilder: (context, index) {
              return buildAgendaCard(agendaItems[index]);
            },
          ),
          const Center(child: Text('No items available')),
          const Center(child: Text('More content coming soon')),
        ],
      ),
    );
  }
}

// Detail Screen
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailScreen({super.key, required this.data});

  Widget buildSocialIcons(List<String> social) {
    final Map<String, IconData> icons = {
      'facebook': Icons.facebook,
      'instagram': Icons.airplanemode_on_outlined,
      'linkedin': Icons.camera_alt,
      'web': Icons.language,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: social
          .map(
            (platform) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(icons[platform], size: 36, color: Colors.grey[700]),
        ),
      )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['speaker'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(data['profile']),
            ),
            const SizedBox(height: 16),
            Text(
              data['organization'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            buildSocialIcons(data['social']),
          ],
        ),
      ),
    );
  }
}
