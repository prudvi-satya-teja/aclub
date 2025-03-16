import 'package:flutter/material.dart';
import 'package:aclub/rollno.dart';
import 'package:aclub/auth/authService.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService authService = AuthService();
  List<dynamic> details = [];
  String studentName = '';
  String roll = Shared().rollNo;
  String branch = '';
  String campus = 'AU';
  String year = '3rd Year';
  String clubMember = '';
  int eventsParticipated = 5; // Assume this value is fetched from another source
  String r = Shared().rollNo;

  bool _isLoading = true;
  bool _showEnlargedImage = false;

  // Profile image URL
  final String profileImageUrl = 'https://info.aec.edu.in/AEC/StudentPhotos/${Shared().rollNo}.jpg';

  String getBranchFromRoll(String roll) {
    Map<String, String> branchMap = {
      "01": "Civil",
      "02": "EEE",
      "03": "Mechanical",
      "04": "ECE",
      "05": "CSE",
      "12": "IT",
      "26": "Mining",
      "27": "Petroleum",
      "35": "Agriculture",
      "44": "Data Science",
      "61": "AI & ML"
    };

    if (roll.length >= 8) {
      String branchCode = roll.substring(6, 8); // Extracting branch code
      return branchMap[branchCode] ?? "Unknown"; // Default to "Unknown" if not found
    }
    return "Unknown";
  }

  void getUserDetails() async {
    final res = await authService.getUserDetails(Shared().token);

    if (res.containsKey('status') && res['status'] == true) {
      setState(() {
        details = res['details'];
        _isLoading = false;
        if (details.isNotEmpty) {
          var user = details[0];
          studentName = '${user['firstName']} ${user['lastName']}';
          List<dynamic> clubs = user['clubs'];
          clubMember = clubs.map((club) => club['clubId']).join(', ');
        }
      });
    }
  }

  void _toggleImageSize() {
    setState(() {
      _showEnlargedImage = !_showEnlargedImage;
    });
  }

  @override
  void initState() {
    super.initState();
    branch = getBranchFromRoll(roll);
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    // If still loading, show a loading spinner
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: screenSize.height * 0.20,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF040737), Color(0xFF040737)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -60,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _toggleImageSize,
                        child: Hero(
                          tag: 'profile-image',
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.network(
                                profileImageUrl,
                                width: 136,
                                height: 136,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.error, size: 50, color: Colors.red),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 40),
                  child: Column(
                    children: [
                      Text(
                        studentName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        clubMember.isNotEmpty ? clubMember : 'No clubs',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildInfoCard(
                              icon: Icons.badge,
                              title: "Roll No",
                              value: roll,
                              color: Colors.amber,
                            ),
                            _buildInfoCard(
                              icon: Icons.school,
                              title: "Branch",
                              value: branch,
                              color: Colors.purple,
                            ),
                            _buildInfoCard(
                              icon: Icons.location_city,
                              title: "Campus",
                              value: campus,
                              color: Colors.green,
                            ),
                            _buildInfoCard(
                              icon: Icons.group,
                              title: "Club Member",
                              value: clubMember,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showEnlargedImage)
            BackdropFilter(
              filter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.srcOver,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _toggleImageSize,
                      child: Center(
                        child: Hero(
                          tag: 'profile-image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              profileImageUrl,
                              width: screenSize.width * 0.9,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, size: 100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 30,
                      child: IconButton(
                        icon: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onPressed: _toggleImageSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
