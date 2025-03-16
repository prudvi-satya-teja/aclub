import 'package:flutter/widgets.dart';

import '../auth/login.dart';
import '../rollno.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';
import '../auth/authService.dart';
import '../clubs/club_screen_tab_bar.dart';
import '../events/detailedallpast.dart';
import 'bottom_Navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'settings.dart';
// import 'contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AuthService authService=AuthService();
  List<dynamic>allData=[];
  void getAllClubsData()async{
    final res= await authService.getAllClubsData();
    if(res.containsKey('status')&&res['status']==true){
      print('allDataResponse:res');
      setState(() {
        allData=res['clubs'];
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
    }
  }
  final List<String> carouselItems = [
    'assets/gdg/gdg_5.jpg', //D:\pro\aclub\assets\gdg\gdg_2.jpg
    'assets/leo/leo_2.jpg',   // D:\pro\aclub\assets\leo\leo_2.jpg
    'assets/red/red_6.jpg',  //D:\pro\aclub\assets\red\red_6.jpg
    'assets/rot/rot_5.jpg',             
  ];
 
  late AnimationController _animationController;
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentCarouselIndex = 0;
  late Animation<double> _fadeAnimation;
  AuthService authServices=AuthService();
List<dynamic>getAllLiveData=[];
List<dynamic>getAllupComingData=[];
List<dynamic>getAllPastData=[];
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getAllClubsData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    getAllLiveResponse();
    getAllUpcomingResponse();
    getAllPastResponse();
  }
 void getAllLiveResponse()async{
final response=await authServices.getAllLiveData();
if(response.containsKey('status')&&response['status']==true){
     setState(() {
       getAllLiveData=response['ongoing events'];
     });
}
 }
  void getAllUpcomingResponse()async{
final response=await authServices.getAllupComingData();
if(response.containsKey('status')&&response['status']==true){
     setState(() {
       getAllupComingData=response['upcoming events'];
     });
}
 }
  void getAllPastResponse()async{
final response=await authServices.getAllPastData();
if(response.containsKey('status')&&response['status']==true){
     setState(() {
       getAllPastData=response['past events'];
     });
}
 }
  Drawer _buildDrawer(BuildContext context) {
    // print('https://info.aec.edu.in/AEC/StudentPhotos/${Shared().rollNo}.jpg');
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:  Text(Shared().rollNo),
            
          accountEmail:  Text('${Shared().rollNo}@aec.edu.in'),
            currentAccountPicture: Container(
              height: 100,
              width: 100,
              // color: ,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), 
             ) ,
              
child: ClipRRect(borderRadius: BorderRadius.circular(20),
  child: CachedNetworkImage(
    imageUrl: 'https://info.aec.edu.in/AEC/StudentPhotos/${Shared().rollNo}.jpg',
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) {
      print('Image load error: $error');
      return Icon(Icons.error, size: 40, color: Colors.red);
    },
    fit: BoxFit.cover,
  ),
),

            // Image.network('https://info.aec.edu.in/AEC/StudentPhotos/22a91a0565.jpg')
            )
            ,decoration: BoxDecoration(
    color:  Color(0xFF040737), // Change this to your desired background color
  ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color:  Color(0xFF040737)),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.event, color:  Color(0xFF040737)),
            title: const Text('Events'),
            onTap: () {
              Navigator.pop(context);
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) =>Allpastevents()
            //  ),
            //   );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color:  Color(0xFF040737)),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Allpastevents()),
              // );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contact_page, color:  Color(0xFF040737)),
            title: const Text('Contact Us'),
                        onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //  MaterialPageRoute(builder: (context) => Allpastevents()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color:  Color(0xFF040737)),
            title: const Text('Help & Support'),
                                    onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //  MaterialPageRoute(builder: (context) => Allpastevents()),
              // );
            },
            
          ),
          ListTile(
            leading: const Icon(Icons.feedback, color:  Color(0xFF040737)),
            title: const Text('Feedback'),
                                                onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //  MaterialPageRoute(builder: (context) => Allpastevents()),
              // );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () async{
              await Shared().logout();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
              MaterialPageRoute(builder: (context) => SimpleLoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

SliverAppBar _buildAppBar(ThemeData theme) {
  return SliverAppBar(
    floating: true,
    snap: true,
    backgroundColor: Color(0xff040737),
    elevation: 0,
    title: Center(
      child: Transform.translate(
        offset: const Offset(0, 0), // Adjust the vertical offset as needed
        child: Image.asset(
          'assets/AU_1.png',
          height: 90, // just logo size as needed
          fit: BoxFit.contain,
        ),
      ),
    ),
    actions: [
      _buildNotificationBadge(),
    ],
  );
}


  Widget _buildCarouselSection(Size size) {
    return Column(
      children: [
        SizedBox(height: 5,),
        CarouselSlider(
          items: carouselItems.map((item) => _buildCarouselItem(item, size)).toList(),
          options: CarouselOptions(
            height: size.height * 0.25,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() => _currentCarouselIndex = index);
            },
          ),
          carouselController: _carouselController,
        ),
        const SizedBox(height: 12),
        _buildCarouselIndicators(),
      ],
    );
  }

  Widget _buildCarouselItem(String imagePath, Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image:AssetImage(imagePath) , fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Club Spotlight',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: carouselItems.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.jumpToPage(entry.key),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentCarouselIndex == entry.key
                  ?  Color(0xFF040737)
                  : Colors.grey.withOpacity(0.4),
            ),
          ),
        );
      }).toList(),
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
            // TextButton(
            //   onPressed: onSeeAll,
            //   child: const Text('See All'),
            // ),
        ],
      ),
    );
  }

Widget _buildCategoryRow() {
  return SizedBox(
    height: 120,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: allData.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (context, index) => _buildCategoryItem(index),
    ),
  );
}


Widget _buildCategoryItem(int index) {
  final List<String> categories = [
'assets/ROT.png',
'assets/GDG.jpg',
'assets/IEEE.png',
'assets/NSS.png',
'assets/RED.png'
  ];

  return Column(
    children: [
      GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ClubsScreen_a(name: allData[index]['name'], clubId: allData[index]['clubId'])));
      },
        child: Container(
          width: 70,
          
          height: 70,
          decoration: BoxDecoration(
           
            shape: BoxShape.circle,
            border: Border.all(
              color:Colors.white,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              categories[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.error,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        allData[index]['clubId'],
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

  // Widget _buildEventCard(int index) {
  //   final List<Map<String, dynamic>> events = [
  //     {
  //       'title': 'Leadership Workshop',
  //       'date': 'March 25',
  //       'image': 'assets/ob/ob1.jpg',
  //       'club': 'LEO Club'
  //     },
  //     {
  //       'title': 'Music Festival',
  //       'date': 'April 2',
  //       'image': 'assets/ob/ob2.jpg',
  //       'club': 'SAC'
  //     },
  //     {
  //       'title': 'Coding Challenge',
  //       'date': 'April 5',
  //       'image': 'assets/ob/ob3.jpg',
  //       'club': 'IEDC'
  //     },
  //     {
  //       'title': 'Cultural Night',
  //       'date': 'April 8',
  //       'image': 'assets/ob/ob1.jpg',
  //       'club': 'NSS'
  //     },
  //   ];

  //   return GestureDetector(
  //     onTap: () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ,
  //       ),
  //     ),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15),
  //         image: DecorationImage(
  //           image: NetworkImage(events[index]['image']),
  //           fit: BoxFit.cover,
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.1),
  //             blurRadius: 10,
  //             spreadRadius: 2,
  //           ),
  //         ],
  //       ),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(15),
  //           gradient: LinearGradient(
  //             begin: Alignment.bottomCenter,
  //             end: Alignment.topCenter,
  //             colors: [
  //               Colors.black.withOpacity(0.6),
  //               Colors.transparent,
  //             ],
  //           ),
  //         ),
  //         padding: const EdgeInsets.all(12),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Text(
  //               events[index]['date'],
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             Text(
  //               events[index]['title'],
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //             const SizedBox(height: 4),
  //             Row(
  //               children: [
  //                 const Icon(Iconsax.clock, color: Colors.white, size: 12),
  //                 const SizedBox(width: 4),
  //                 Text(
  //                   '6:00 PM',
  //                   style: TextStyle(
  //                     color: Colors.white.withOpacity(0.9),
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                  color:  Color(0xFF040737).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.info_circle, color:  Color(0xFF040737)),
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
                        color: Colors.grey.shade600,
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
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningSection() {
      return getAllLiveData.isEmpty?Center(child: Image.asset('assets/noevent.jpg'),): SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:getAllLiveData.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard(getAllLiveData[index]['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':getAllLiveData[index]['image'], 
      getAllLiveData[index]['eventName']);
      }),
    );
  }

  Widget _buildListeningCard(String imagePath, String episode) {
      return GestureDetector(onTap: ()async{
       List<dynamic>list=[];
       SharedPreferences prefs=await SharedPreferences.getInstance();
      final response=await AuthService().getEventDetailsByName(episode);
      if(response.containsKey('status')&&response['status']==true){
        print('getEventDetailsByName:$response');
         setState(() {
           list=response['eventDetails'];
         });
         final event=response['eventDetails'][0];
         Navigator.push(context, MaterialPageRoute(
          builder: (context)=>
          ClubsScreena(clubId: event['clubId'], clubName: event['clubName'], eventName: event['eventName'], date: DateTime.parse(event['date']), location: event['location'], description: event['details'], list:List<String>.from(event['guest']), rollNo:Shared().rollNo,imageUrl: event['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':event['image'])));
      }
    },
      child:
    Container(
      width: 150,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
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
    ));
  }

  Widget _buildKnowledgeSection() {
     return getAllupComingData.isEmpty?Center(child: Image.asset('assets/noevent.jpg'),): SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:getAllupComingData.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard(getAllupComingData[index]['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':getAllupComingData[index]['image'],
       getAllupComingData[index]['eventName']);
      }),
    );
  }

  Widget _buildledgeSection() {
     return getAllPastData.isEmpty?Center(child: Image.asset('assets/noevent.jpg'),): SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:getAllPastData.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard(getAllPastData[index]['image']==null?'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D':getAllPastData[index]['image'],
       getAllPastData[index]['eventName']);
      }),
    );
  }


  Widget _buildNotificationBadge() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Iconsax.notification, color: Colors.white),
          onPressed: () => () {}
        ),
        Positioned(
          right: 8,
          top: 7,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 13,
              minHeight: 13,
            ),
            child: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
  );
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      drawer: _buildDrawer(context),
      body: CustomScrollView(
slivers: [
  _buildAppBar(theme),
  SliverList(
    delegate: SliverChildListDelegate([
      _buildCarouselSection(size),
      const SizedBox(height: 24),
      _buildSectionHeader('Clubs', onSeeAll: () {
        // Navigator.push(
        //   context,
        //         MaterialPageRoute(builder: (context) => Allpastevents()),
        // );
      }),
      _buildCategoryRow(),
      _buildSectionHeader('🔴Live Events', onSeeAll: () {
        // Navigator.push(
        //   context,
        //         MaterialPageRoute(builder: (context) => Allpastevents()),
        // );
      }),
      _buildListeningSection(),
      const SizedBox(height: 20),
      _buildSectionHeader('Upcooming Events', onSeeAll: () {
        // Navigator.push(
        //   context,
        //         MaterialPageRoute(builder: (context) =>Allpastevents()),
        // );
      }),
      _buildKnowledgeSection(),
      const SizedBox(height: 18),
      _buildSectionHeader(' Past Events', onSeeAll: () {
        // Navigator.push(
        //   context,
        //         MaterialPageRoute(builder: (context) => Allpastevents()),
        // );
      }),
      _buildledgeSection(),
      const SizedBox(height: 18),
      // _buildSectionHeader('Past Events', onSeeAll: () {
      //   Navigator.push(
      //     context,
      //           MaterialPageRoute(builder: (context) => Allpastevents()),
      //   );
      // }),
      // _buildEventGrid(),
      // const SizedBox(height: 18),
      _buildSectionHeader('Latest News', onSeeAll: () {
        // Navigator.push(
        //   context,
        //         MaterialPageRoute(builder: (context) => Allpastevents()),
        // );
      }),
      _buildNewsList(),
      const SizedBox(height: 20),
    ]),
  ),
],
        
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: _buildBottomAppBar(theme),
    );
  }
}