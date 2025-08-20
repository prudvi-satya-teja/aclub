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
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AuthService authService = AuthService();
  AuthService authServices = AuthService();

  List<dynamic> allData = [];
  List<dynamic> getAllLiveData = [];
  List<dynamic> getAllupComingData = [];
  List<dynamic> getAllPastData = [];

  bool _hasNetwork = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentCarouselIndex = 0;

  final List<String> carouselItems = [
    'assets/gdg/gdg_5.jpg',
    'assets/leo/leo_2.jpg',
    'assets/red/red_6.jpg',
    'assets/rot/rot_5.jpg',
  ];

  final List<String> defaultCategories = [
    'assets/ROT.png',
    'assets/GDG.jpg',
    'assets/IEEE.png',
    'assets/NSS.png',
    'assets/RED.png',
    'assets/logo/cc.png'
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    _checkNetworkAndLoad();

    Connectivity().onConnectivityChanged.listen((result) {
      final hasNetworkNow = result != ConnectivityResult.none;
      if (hasNetworkNow && !_hasNetwork) {
        _loadAllData();
      }
      setState(() {
        _hasNetwork = hasNetworkNow;
      });
    });
  }

  Future<void> _checkNetworkAndLoad() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      _hasNetwork = result != ConnectivityResult.none;
    });
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    if (!_hasNetwork) return;
    await Future.wait([
      getAllClubsData(),
      getAllLiveResponse(),
      getAllUpcomingResponse(),
      getAllPastResponse(),
    ]);
  }

  Future<void> getAllClubsData() async {
    try {
      final res = await authService.getAllClubsData();

      if (res.containsKey('status') && res['status'] == true) {
        setState(() {
          allData = res['clubs'];
        });
      } else {
        setState(() {
          allData = [];
        });
        if (_hasNetwork) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res['msg'])));
        }
      }
    } catch (_) {
      // Network failure → show default clubs
      setState(() {
        allData = List.generate(
            6,
            (index) => {
                  'clubId': 'Club ${index + 1}',
                  'name': 'Club ${index + 1}',
                });
      });
    }
  }

  Future<void> getAllLiveResponse() async {
    try {
      final response = await authServices.getAllLiveData();
      if (response.containsKey('status') && response['status'] == true) {
        setState(() {
          getAllLiveData = response['ongoing events'];
        });
      }
    } catch (_) {}
  }

  Future<void> getAllUpcomingResponse() async {
    try {
      final response = await authServices.getAllupComingData();
      if (response.containsKey('status') && response['status'] == true) {
        setState(() {
          getAllupComingData = response['upcoming events'];
        });
      }
    } catch (_) {}
  }

  Future<void> getAllPastResponse() async {
    try {
      final response = await authServices.getAllPastData();
      if (response.containsKey('status') && response['status'] == true) {
        setState(() {
          getAllPastData = response['past events'];
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ================= Drawer =================
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(Shared().rollNo),
            accountEmail: Text('${Shared().rollNo}@aec.edu.in'),
            currentAccountPicture: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://info.aec.edu.in/AEC/StudentPhotos/${Shared().rollNo}.jpg',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error, size: 40, color: Colors.red);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF040737),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF040737)),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.event, color: Color(0xFF040737)),
            title: const Text('Events'),
            onTap: () => Navigator.pop(context),
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings, color: Color(0xFF040737)),
          //   title: const Text('Settings'),
          //   onTap: () => Navigator.pop(context),
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.contact_page, color: Color(0xFF040737)),
          //   title: const Text('Contact Us'),
          //   onTap: () => Navigator.pop(context),
          // ),
          // ListTile(
          //   leading: const Icon(Icons.help, color: Color(0xFF040737)),
          //   title: const Text('Help & Support'),
          //   onTap: () => Navigator.pop(context),
          // ),
          // ListTile(
          //   leading: const Icon(Icons.feedback, color: Color(0xFF040737)),
          //   title: const Text('Feedback'),
          //   onTap: () => Navigator.pop(context),
          // ),
          // const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () async {
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

  // ================= AppBar =================
  SliverAppBar _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      floating: true,
      snap: true,
      backgroundColor: const Color(0xff040737),
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        'assets/AU_1.png',
        height: 90,
        fit: BoxFit.contain,
      ),
      actions: [_buildNotificationBadge()],
    );
  }

  Widget _buildNotificationBadge() {
    return const SizedBox(
        width: 48,
        height: 48,
        child: Opacity(opacity: 0, child: Icon(Iconsax.notification)));
  }

  // ================= Carousel =================
  Widget _buildCarouselSection(Size size) {
    return Column(
      children: [
        const SizedBox(height: 5),
        CarouselSlider(
          items: carouselItems
              .map((item) => _buildCarouselItem(item, size))
              .toList(),
          options: CarouselOptions(
            height: size.height * 0.25,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) =>
                setState(() => _currentCarouselIndex = index),
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
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2)
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
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
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentCarouselIndex == entry.key
                  ? const Color(0xFF040737)
                  : Colors.grey.withOpacity(0.4),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ================= Sections =================
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoryRow() {
    if (!_hasNetwork) {
      return Column(
        children: [
          const Text("No network connection. Showing default clubs."),
          const SizedBox(height: 10),
        ],
      );
    }

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
    final club = allData[index];
    final image = defaultCategories[index % defaultCategories.length];

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (_hasNetwork) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClubsScreen_a(
                          name: club['name'], clubId: club['clubId'])));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No network connection")));
            }
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red, size: 30),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          club['clubId'],
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // ================= Event Sections =================
  Widget _buildEventSection(List<dynamic> data) {
    if (data.isEmpty) {
      return Center(child: Image.asset('assets/noevent.jpg'));
    }

    return SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final event = data[index];
          final image = event['image'] ??
              'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D';
          return _buildEventCard(image, event['eventName']);
        },
      ),
    );
  }

  Widget _buildEventCard(String imagePath, String eventName) {
    return GestureDetector(
      onTap: () async {
        if (!_hasNetwork) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No network connection")),
          );
          return;
        }
        List<dynamic> list = [];
        final response = await AuthService().getEventDetailsByName(eventName);
        if (response.containsKey('status') && response['status'] == true) {
          list = response['eventDetails'];
          final event = list[0];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubsScreena(
                clubId: event['clubId'],
                clubName: event['clubName'],
                eventName: event['eventName'],
                date: DateTime.parse(event['date']),
                location: event['location'],
                description: event['details'],
                list: List<String>.from(event['guest']),
                rollNo: Shared().rollNo,
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
              image: NetworkImage(imagePath), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black54,
            child: Text(
              eventName,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
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
              if (!_hasNetwork)
                Container(
                  width: double.infinity,
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'No network connection. Showing default data.',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              _buildCarouselSection(size),
              const SizedBox(height: 24),
              _buildSectionHeader('Clubs'),
              _buildCategoryRow(),
              _buildSectionHeader('🔴 Live Events'),
              _buildEventSection(getAllLiveData),
              const SizedBox(height: 20),
              _buildSectionHeader('Upcoming Events'),
              _buildEventSection(getAllupComingData),
              const SizedBox(height: 18),
              _buildSectionHeader('Past Events'),
              _buildEventSection(getAllPastData),
              const SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }
}
