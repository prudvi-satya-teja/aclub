
import '../auth/authService.dart';
// import '../events/allpastevents.dart';
import '../events/detailedallpast.dart';
import '../rollno.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:aclub/events/detailedallpast.dart';

/// Main Screen with TabBar and TabBarView
class ClubsScreen_a extends StatefulWidget {
  final String name;
  final String clubId;
  const ClubsScreen_a({super.key,required this.name,required this.clubId});

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
    getAllClubMembers();
  }
  late TabController _tabController;
      AuthService authService=AuthService();
  List<dynamic>liveEventList=[];
   List<dynamic>upComingEventList=[];
    List<dynamic>pastEventList=[];
    List<dynamic>clubMembersList=[];
  //get live events data
  void liveEvents()async{
    final response=await authService.getLiveData(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print('live response:$response :${widget.clubId}');
      setState(() {
        liveEventList=response['ongoing events'];
      });
    }
  } 

  //get upComing events 
    void upComingEvents()async{
    final response=await authService.getupComingData(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print("Upcoming response:$response");
      setState(() {
        upComingEventList=response['upcoming events'];
      });
    }
  } 

  //get past events 
    void pastEvents()async{
    final response=await authService.getPastData(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print("Past response:$response");
      setState(() {
        pastEventList=response['past events'];
      });
    }
  }

  //getAllClubMemebrs
  void getAllClubMembers()async{
    final response=await authService.getAllClubMembers(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print('getAllClubMembers:$response');
      setState(() {
        clubMembersList=response['members'];
      });
    }else{
      print(response['msg']??"unknown error");
    }
  }
  // Data for the bio (Club info), events, and about sections
  final List<Map<String, dynamic>> groupItems = [
    {
      'title': 'Shivaji Deshmukh',
      'speaker': 'Shiva Shankar',
      'time': '3rd year',
      'duration': 'ECE',
      'profile': 'assets/NSS.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'SHIVA',
    },
  ];


  final List<Map<String, dynamic>> aboutItems = [
    {
      'title': 'Shivaji Babu',
      'speaker': 'Shiva Shyam',
      'time': '2nd year',
      'duration': 'EEE',
      'profile': 'assets/RED.jpg',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'LEO',
    },
  ];


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
      margin:
          EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
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
  Widget buildBioCard(BuildContext context,String firstName,String role,String rollNo,String lastName){
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return GestureDetector(
      onTap: () {
        // Navigate to a detailed bio page when card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(firstName: firstName,lastName: lastName,),
          ),
        );
      },
      child: Card(
        margin:
            EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: cardMargin, horizontal: cardMargin * 2),
          leading: CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage:const NetworkImage('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          ),
          title: Text(
           firstName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.045,
            ),
          ),
          subtitle: role=='admin'? Text(
            'Club Leader: $role\n Roll NO: $rollNo',
          ): Text(
            'Club Member: $role\n Roll NO: $rollNo',
          ),
        ),
      ),
    );
  }

  /// Build a card for the about section (non-clickable)
  Widget buildAboutCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin:
          EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(cardMargin * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['organization'],
              style: TextStyle(
                  fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'About this club:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Detailed description can be added here
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Quisque ac eros nec sapien dignissim interdum. '
              'Suspendisse potenti. ',
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
        title:  Text(
          '${widget.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Roboto',
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor:  Color(0xFF040737),
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
              text: 'Bio',
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
             ClubsEventScreen(clubId: widget.clubId,liveList: liveEventList,upComingList: upComingEventList,pastList: pastEventList,clubName: widget.name,), // Events tab now shows ClubsEventScreen

          // Tab 1: Events (non-clickable UI)

          // Tab 2: Club Bio (clickable card)
          Column(
            children: [
              Text('Members: ${clubMembersList.length}',style: TextStyle(fontSize: 20),),
              Expanded(
                child: ListView.builder(
                  itemCount: clubMembersList.length,
                  itemBuilder: (context, index) {
                    return  buildBioCard(context,clubMembersList[index]['firstName'],clubMembersList[index]['role'],clubMembersList[index]['rollNo'],clubMembersList[index]['lastName']);
                  },
                ),
              ),
            ],
          ),
          // Tab 3: About section (non-clickable UI)
          ListView.builder(
            itemCount: aboutItems.length,
            itemBuilder: (context, index) {
              return buildAboutCard(context, aboutItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

/// Detail Screen (Common for clickable cards)
class DetailScreen extends StatelessWidget {
  // final Map<String, dynamic> data;
  final String firstName;
  final String lastName;
  const DetailScreen({super.key ,required this.firstName,required this.lastName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.2;
    final fontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          firstName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality can be added here.
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage:const NetworkImage('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              lastName,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.1),
           // buildSocialIcons(context, data['social']),
          ],
        ),
      ),
    );
  }
}

class ClubsEventScreen extends StatefulWidget {
  final String clubId;
  final List<dynamic>liveList;
  final List<dynamic>upComingList;
   final List<dynamic>pastList;
   final String clubName;
  const ClubsEventScreen({super.key,required this.clubId,required this.liveList,required this.upComingList,required this.pastList,required this.clubName});

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
        'excerpt': 'Check out the complete schedule for this year\'s college fest...',
        'date': '5h ago'
      },
      {
        'title': 'Leadership Workshop Results',
        'excerpt': 'View the results of the inter-college leadership workshop...',
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
                        color:  Color(0xFFFFFF),
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
              color:  Color(0xFFFFFF),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningSection(List<dynamic>list) {
    return list.isEmpty?Center(child:Image.asset('assets/noevent.jpg') ,): SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:list.length ,
        itemBuilder: (context,index){
      return _buildListeningCard(list[index]['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':list[index]['image'],
       list[index]['eventName'],);
      }),
    );
  }

  Widget _buildListeningCard(String imagePath, String episode) {
    return GestureDetector(onTap: ()async{
       List<dynamic>list=[];
      final response=await AuthService().getEventDetailsByName(episode);
      if(response.containsKey('status')&&response['status']==true){
        print('getEventDetailsByName:$response');
         setState(() {
           list=response['eventDetails'];
         });
         final event=response['eventDetails'][0];
         Navigator.push(context, MaterialPageRoute(
          builder: (context)=>
          ClubsScreena(clubId: widget.clubId, clubName: widget.clubName, eventName: event['eventName'], date: DateTime.parse(event['date']), location: event['location'], description: event['details'], list:List<String>.from(event['guest']), rollNo: Shared().token,imageUrl:event['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':event['image'])));
      }
    },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(episode),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black54,
            child: Text(
              episode,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildledgeSection(List<dynamic>list) {
    return list.isEmpty?Center(child: Image.asset('assets/noevent.jpg'),):SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:list.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard(list[index]['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':list[index]['image'], list[index]['eventName']);
      }),
    );
  }


Widget _buildPastSection(List<dynamic>list) {
    return list.isEmpty?Center(child: Image.asset('assets/noevent.jpg'),):SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:list.length ,
        itemBuilder: (context,index){
      return _buildListeningCard(list[index]['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':list[index]['image'], list[index]['eventName']);
      }),
    );
  }
}

  