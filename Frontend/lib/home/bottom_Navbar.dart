import 'homepage.dart';
import 'package:flutter/material.dart';
//import 'package:iconsax/iconsax.dart';
import 'profilePage.dart';
import '../admin/admin_page.dart';
// import 'all_Clubs_page.dart';

class Nav_Bar extends StatefulWidget {
  final int val; // 0 for normal user, 1 for admin
  const Nav_Bar({super.key, required this.val});

  @override
  _Nav_BarState createState() => _Nav_BarState();
}

class _Nav_BarState extends State<Nav_Bar> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _updateScreens();
  }

  void _updateScreens() {
    _screens = widget.val == 0
        ? [
            const HomeScreen(),
            // const MyEPage(),
            // const SizedBox(), // Placeholder for admin screen
            const ProfileScreen(),
          ]
        : [
            const HomeScreen(),
            // const ProfileScreen(),
            AdminPage(),
            const ProfileScreen(),
          ];
  }

List<BottomNavigationBarItem> _getNavItems() {
  return [
    BottomNavigationBarItem(
      icon: Icon(_currentIndex == 0 ? Icons.home : Icons.home_outlined,color: Colors.white,), // Filled when selected
      label: 'Home',
    ),
    if (widget.val == 1) // Only show for normal users
      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 1 ? Icons.admin_panel_settings : Icons.admin_panel_settings_outlined,color: Colors.white),
        label: 'Admin',
      ),
    BottomNavigationBarItem(
      icon: Icon(_currentIndex == (widget.val == 0 ? 2 : 1) ? Icons.person : Icons.person_outline,color: Colors.white),
      label: 'Profile',
    ),
  ];
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildWhatsAppStyleNavBar(),
    );
  }

  Widget _buildWhatsAppStyleNavBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0xff040737),
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: _getNavItems(),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white, // WhatsApp green
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      iconSize: 28,
    );
  }
}