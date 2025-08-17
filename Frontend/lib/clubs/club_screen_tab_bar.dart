import '../auth/authService.dart';
// import '../events/allpastevents.dart';
import '../events/detailedallpast.dart';
import '../rollno.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:shimmer/shimmer.dart';
// import 'package:aclub/events/detailedallpast.dart';

/// Main Screen with TabBar and TabBarView
class ClubsScreen_a extends StatefulWidget {
  final String name;
  final String clubId;
  const ClubsScreen_a({super.key, required this.name, required this.clubId});

  @override
  State<ClubsScreen_a> createState() => _ClubsScreen_aState();
}

class _ClubsScreen_aState extends State<ClubsScreen_a>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Three tabs: Events, Bio, About
    _tabController = TabController(length: 3, vsync: this);
    liveEvents();
    upComingEvents();
    pastEvents();
    getTeamMembers();
  }

  late TabController _tabController;
  AuthService authService = AuthService();
  List<dynamic> liveEventList = [];
  List<dynamic> upComingEventList = [];
  List<dynamic> pastEventList = [];
  List<dynamic> clubMembersList = [];
  //get live events data
  void liveEvents() async {
    final response = await authService.getLiveData(widget.clubId);
    if (response.containsKey('status') && response['status'] == true) {
      print('live response:$response :${widget.clubId}');
      setState(() {
        liveEventList = response['ongoing events'];
      });
    }
  }

  //get upComing events
  void upComingEvents() async {
    final response = await authService.getupComingData(widget.clubId);
    if (response.containsKey('status') && response['status'] == true) {
      print("Upcoming response:$response");
      setState(() {
        upComingEventList = response['upcoming events'];
      });
    }
  }

  //get past events
  void pastEvents() async {
    final response = await authService.getPastData(widget.clubId);
    if (response.containsKey('status') && response['status'] == true) {
      print("Past response:$response");
      setState(() {
        pastEventList = response['past events'];
      });
    }
  }

  //getAllClubMemebrs
  void getTeamMembers() async {
    final response = await authService.getTeamMembers(widget.clubId);
    print('getTeamMembers:$response');
    if (response.containsKey('status') && response['status'] == true) {
      print('getTeamMembers:$response');
      setState(() {
        clubMembersList = response['members'];
      });
    } else {
      print(response['msg'] ?? "unknown error");
    }
  }

  final Map<String, Map<String, String>> clubs = {
    "RC": {
      "name": "Rotaract Club",
      "description": "The Rotaract Club is a student-led service organization that provides opportunities for leadership and personal development. "
          "It focuses on community service, professional development, and social activities. "
          "Members participate in blood donation drives, awareness programs, and rural development projects. "
          "The club aims to instill a sense of responsibility among students towards society. "
          "It also provides networking opportunities with Rotarians and community leaders."
    },
    "GDG": {
      "name": "Google Developer Group",
      "description": "GDG is a global community of developers passionate about Google technologies. "
          "It organizes workshops, hackathons, and technical events for students. "
          "Members learn about Android, Flutter, TensorFlow, Cloud, and more. "
          "The club encourages peer-to-peer learning and open-source contributions. "
          "It helps students build real-world projects and strengthen their developer journey."
    },
    "IEEE": {
      "name": "IEEE Student Branch",
      "description": "IEEE is the world’s largest technical professional organization. "
          "The student branch promotes innovation, research, and technical excellence. "
          "It conducts paper presentations, seminars, and coding contests. "
          "Members get access to IEEE journals, conferences, and international exposure. "
          "It also nurtures entrepreneurship, innovation, and networking among engineers."
    },
    "NSS": {
      "name": "National Service Scheme",
      "description": "NSS aims at developing the personality of students through community service. "
          "Volunteers engage in activities like blood donation, tree plantation, and Swachh Bharat campaigns. "
          "It fosters a spirit of social responsibility and teamwork. "
          "Students spend time in villages to understand grassroots challenges. "
          "The motto of NSS is 'Not Me But You', highlighting selfless service."
    },
    "CC": {
      "name": "Coding Club",
      "description": "The Coding Club is dedicated to fostering a strong programming culture. "
          "It organizes competitive programming contests, hackathons, and workshops. "
          "Members practice problem-solving, algorithms, and data structures regularly. "
          "The club encourages teamwork, innovation, and participation in national contests. "
          "Its mission is to prepare students for coding interviews and global coding competitions."
    },
    "RCC": {
      "name": "Red Cross Club",
      "description": "The Red Cross Club (RCC) is dedicated to humanitarian service "
          "and promoting health awareness among students and the community. "
          "It organizes blood donation drives, first aid training, and health camps. "
          "The club actively participates in disaster relief initiatives and awareness campaigns. "
          "Through volunteering, members develop compassion, leadership, and social responsibility. "
          "RCC aims to spread kindness, serve the needy, and create a safer, healthier society."
    }
  };

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Build a card for an event (non-clickable)
  Widget buildEventCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin: EdgeInsets.symmetric(
          vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(item['profile']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(cardMargin * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Coordinator: ${item['speaker']}'),
                const SizedBox(height: 4),
                Text('Time: ${item['time']} | Category: ${item['duration']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a card for the club's bio (clickable)
  Widget buildTeamCard(BuildContext context, String firstName, String role,
      String rollNo, String lastName) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return GestureDetector(
      onTap: () {
        // Navigate to a detailed bio page when card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
                firstName: firstName,
                lastName: lastName,
                role: role,
                rollNo: rollNo),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
            vertical: cardMargin, horizontal: cardMargin * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: cardMargin, horizontal: cardMargin * 2),
          leading: CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage: NetworkImage(
              'https://info.aec.edu.in/AEC/StudentPhotos/$rollNo.jpg',
            ),
          ),
          title: Text(
            firstName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.045,
            ),
          ),
          subtitle: role == 'admin'
              ? Text(
                  'Club Leader: $role\nRoll No: $rollNo',
                )
              : Text(
                  'Club Member: $role\nRoll No: $rollNo',
                ),
        ),
      ),
    );
  }

  /// Build a card for the about section (non-clickable)
  // Widget buildAboutCard(BuildContext context, Map<String, dynamic> item) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   final cardMargin = screenWidth * 0.02;

  //   return Card(
  //     margin: EdgeInsets.symmetric(
  //         vertical: cardMargin, horizontal: cardMargin * 2),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     elevation: 3,
  //     child: Padding(
  //       padding: EdgeInsets.all(cardMargin * 2),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             item['organization'],
  //             style: TextStyle(
  //                 fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 8),
  //           const Text(
  //             'About this club:',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 4),
  //           // Detailed description can be added here
  //           const Text(
  //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
  //             'Quisque ac eros nec sapien dignissim interdum. '
  //             'Suspendisse potenti. ',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildAboutCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin: EdgeInsets.symmetric(
          vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(cardMargin * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Club Name
            Text(
              item['name'] ?? "Unknown Club",
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Label
            const Text(
              'About this club:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Club Description
            Text(
              item['description'] ?? "No description available.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Roboto',
            letterSpacing: 1.5,
            color: const Color.fromARGB(255, 151, 151, 151),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF040737),
        elevation: 4,
        shadowColor: Colors.black45,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelStyle: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.normal,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              text: 'Events',
              icon: Icon(Icons.calendar_month_outlined),
            ),
            Tab(
              text: 'Team',
              icon: Icon(Icons.person),
            ),
            Tab(
              text: 'About',
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClubsEventScreen(
            clubId: widget.clubId,
            liveList: liveEventList,
            upComingList: upComingEventList,
            pastList: pastEventList,
            clubName: widget.name,
          ), // Events tab now shows ClubsEventScreen

          // Tab 1: Events (non-clickable UI)

          // Tab 2: Club Team (clickable card)
          Column(
            children: [
              Text(
                'Members: ${clubMembersList.length}',
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: clubMembersList.length,
                  itemBuilder: (context, index) {
                    return buildTeamCard(
                        context,
                        clubMembersList[index]['firstName'],
                        clubMembersList[index]['role'],
                        clubMembersList[index]['rollNo'],
                        clubMembersList[index]['lastName']);
                  },
                ),
              ),
            ],
          ),

          // Tab 3: About section (non-clickable UI)
          ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return buildAboutCard(context, clubs[widget.clubId]!);
            },
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String role;
  final String rollNo;

  const DetailScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.rollNo,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.2;
    final fontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: NetworkImage(
                    'https://info.aec.edu.in/AEC/StudentPhotos/$rollNo.jpg',
                  ),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              SizedBox(height: screenWidth * 0.08),

              // Full Name
              Text(
                "$firstName $lastName",
                style: TextStyle(
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.04),

              // Role
              Text(
                role.toLowerCase() == "admin" ? "Club Leader" : "Club Member",
                style: TextStyle(
                  fontSize: fontSize * 0.9,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.03),

              // Roll No
              Text(
                "Roll No: $rollNo",
                style: TextStyle(
                  fontSize: fontSize * 0.8,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: screenWidth * 0.1),

              // You can add more info below (like club details, description, etc.)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    children: [
                      Text(
                        "About Member",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.03),
                      Text(
                        "$firstName is an active $role of the club with roll number $rollNo. They play an important role in managing and contributing to club activities.",
                        style: TextStyle(
                          fontSize: fontSize * 0.75,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClubsEventScreen extends StatefulWidget {
  final String clubId;
  final List<dynamic> liveList;
  final List<dynamic> upComingList;
  final List<dynamic> pastList;
  final String clubName;
  const ClubsEventScreen(
      {super.key,
      required this.clubId,
      required this.liveList,
      required this.upComingList,
      required this.pastList,
      required this.clubName});

  @override
  State<ClubsEventScreen> createState() => _ClubsEventScreenState();
}

class _ClubsEventScreenState extends State<ClubsEventScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader('🔴Live Events', onSeeAll: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>Allpastevents()),
                // );
              }),
              _buildListeningSection(widget.liveList),
              const SizedBox(height: 20),
              _buildSectionHeader('Upcoming Events', onSeeAll: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Allpastevents()),
                // );
              }),
              _buildledgeSection(widget.upComingList),
              const SizedBox(height: 18),
              _buildSectionHeader('Past Events', onSeeAll: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => (Allpastevents())),
                // );
              }),
              _buildPastSection(widget.pastList),
              const SizedBox(height: 20)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // if (onSeeAll != null)
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemBuilder: (context, index) => _buildNewsCard(index),
    );
  }

  Widget _buildNewsCard(int index) {
    final List<Map<String, dynamic>> newsItems = [
      {
        'title': 'New Club Registration Open',
        'excerpt': 'Register your new student organization before April 30...',
        'date': '2h ago'
      },
      {
        'title': 'Annual Fest Schedule Released',
        'excerpt':
            'Check out the complete schedule for this year\'s college fest...',
        'date': '5h ago'
      },
      {
        'title': 'Leadership Workshop Results',
        'excerpt':
            'View the results of the inter-college leadership workshop...',
        'date': '1d ago'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.info_circle, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsItems[index]['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      newsItems[index]['date'],
                      style: TextStyle(
                        color: Color(0xFFFFFF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            newsItems[index]['excerpt'],
            style: TextStyle(
              color: Color(0xFFFFFF),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningSection(List<dynamic> list) {
    return list.isEmpty
        ? Center(
            child: Image.asset('assets/noevent.jpg'),
          )
        : SizedBox(
            width: 150,
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildListeningCard(
                    list[index]['image'] == null
                        ? 'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D'
                        : list[index]['image'],
                    list[index]['eventName'],
                  );
                }),
          );
  }

  // Widget _buildListeningCard(String imagePath, String episode) {
  //   return GestureDetector(
  //     onTap: () async {
  //       List<dynamic> list = [];
  //       final response = await AuthService().getEventDetailsByName(episode);
  //       if (response.containsKey('status') && response['status'] == true) {
  //         print('getEventDetailsByName:$response');
  //         setState(() {
  //           list = response['eventDetails'];
  //         });
  //         final event = response['eventDetails'][0];
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ClubsScreena(
  //                     clubId: widget.clubId,
  //                     clubName: widget.clubName,
  //                     eventName: event['eventName'],
  //                     date: DateTime.parse(event['date']),
  //                     location: event['location'],
  //                     description: event['details'],
  //                     list: List<String>.from(event['guest']),
  //                     rollNo: Shared().token,
  //                     imageUrl: event['image'] == null
  //                         ? 'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D'
  //                         : event['image'])));
  //       }
  //     },
  //     child: Container(
  //       width: 150,
  //       margin: const EdgeInsets.only(left: 16),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         image: DecorationImage(
  //           image: NetworkImage(episode),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       child: Align(
  //         alignment: Alignment.bottomLeft,
  //         child: Container(
  //           padding: const EdgeInsets.all(8),
  //           color: Colors.black54,
  //           child: Text(
  //             episode,
  //             style: const TextStyle(color: Colors.white, fontSize: 12),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildListeningCard(String imageUrl, String episodeName) {
    return GestureDetector(
      onTap: () async {
        final response = await AuthService().getEventDetailsByName(episodeName);
        if (response.containsKey('status') && response['status'] == true) {
          final event = response['eventDetails'][0];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubsScreena(
                clubId: widget.clubId,
                clubName: widget.clubName,
                eventName: event['eventName'],
                date: DateTime.parse(event['date']),
                location: event['location'],
                description: event['details'],
                list: List<String>.from(event['guest']),
                rollNo: Shared().token,
                imageUrl: event['image'] ??
                    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
              ),
            ),
          );
        }
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
              imageUrl.isNotEmpty
                  ? imageUrl
                  : 'https://via.placeholder.com/150',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black54,
            child: Text(
              episodeName,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildledgeSection(List<dynamic> list) {
    return list.isEmpty
        ? Center(
            child: Image.asset('assets/noevent.jpg'),
          )
        : SizedBox(
            width: 150,
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildListeningCard(
                      list[index]['image'] == null
                          ? 'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D'
                          : list[index]['image'],
                      list[index]['eventName']);
                }),
          );
  }

  Widget _buildPastSection(List<dynamic> list) {
    return list.isEmpty
        ? Center(
            child: Image.asset('assets/noevent.jpg'),
          )
        : SizedBox(
            width: 150,
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildListeningCard(
                      list[index]['image'] == null
                          ? 'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D'
                          : list[index]['image'],
                      list[index]['eventName']);
                }),
          );
  }
}
