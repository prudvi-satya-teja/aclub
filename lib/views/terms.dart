import 'package:flutter/material.dart';
import 'onboarding.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: _appBarTitleStyle(screenSize),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate to the OnboardingScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.02),
                _buildSection(
                  '1. Welcome to the Aditya Club Connect App',
                  'Thank you for choosing Aditya Club Connect! This platform is designed to give Aditya University students easy access to details about various clubs, their events, members, and activities. Please read the terms and conditions carefully before using the app.',
                  screenSize,
                ),
                _buildSection(
                  '2. User Agreement',
                  'By using the Aditya Club Connect App, you agree to follow all university guidelines and club-specific policies. Users are responsible for maintaining the accuracy of their personal information and keeping their login credentials secure.',
                  screenSize,
                ),
                _buildSection(
                  '3. Privacy Policy',
                  'Your personal data, including login information and club preferences, is treated with utmost priority. The privacy policy explains how your data is collected, used, and safeguarded. By using the app, you agree to these practices.',
                  screenSize,
                ),
                _buildSection(
                  '4. Club Information',
                  'The app provides access to club details such as meeting schedules, upcoming events, member lists, and resources like photos or event summaries. The information displayed is managed by club coordinators and should be verified with them if discrepancies arise.',
                  screenSize,
                ),
                _buildSection(
                  '5. Notifications and Updates',
                  'Stay informed with notifications about club events, registrations, and announcements. Ensure that notifications are enabled to avoid missing important updates.',
                  screenSize,
                ),
                _buildSection(
                  '6. Limitation of Liability',
                  'The developers and coordinators are not responsible for any errors or issues arising from the misuse of the app. It is the user’s responsibility to use the app appropriately and verify the accuracy of any club-related information.',
                  screenSize,
                ),
                _buildSection(
                  '7. Modifications to Terms',
                  'The app administrators and developers reserve the right to update these terms at any time. Any significant changes will be communicated through the app. Continued usage of the app signifies your acceptance of these updates.',
                  screenSize,
                ),
                _buildSection(
                  '8. Contact Us',
                  'For any queries or concerns regarding the app or your club, please contact the support team at support.adityaclubs@aec.edu.in or reach out to the respective club coordinators.',
                  screenSize,
                ),
                _buildFooter(screenSize),
              ],

            ),
          ),
        ),
      ),
    );
  }

  TextStyle _appBarTitleStyle(Size screenSize) {
    return TextStyle(
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.bold,
      fontSize: screenSize.width * 0.06,
      color: Colors.white,
    );
  }

// Widget _buildHeader(Size screenSize) {
//     return Center(
//       child: Text(
//         'Welcome to S Track',
//         style: TextStyle(
//           fontFamily: 'RobotoSlab',
//           fontWeight: FontWeight.bold,
//           fontSize: screenSize.width * 0.05,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

  Widget _buildSection(String title, String content, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title, screenSize),
        SizedBox(height: screenSize.height * 0.01),
        _buildSectionContent(content, screenSize),
        SizedBox(height: screenSize.height * 0.03),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Size screenSize) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: screenSize.width * 0.055,
        color: Colors.orangeAccent,
      ),
    );
  }

  Widget _buildSectionContent(String content, Size screenSize) {
    return Text(
      content,
      style: TextStyle(
        fontSize: screenSize.width * 0.045,
        color: Colors.white70,
        height: 1.5,
      ),
    );
  }

  Widget _buildFooter(Size screenSize) {
    return Center(
      child: Text(
        'Built with ❤️ by Prudvi, Suchandra.',
        style: TextStyle(
          fontFamily: 'RobotoSlab',
          fontStyle: FontStyle.italic,
          fontSize: screenSize.width * 0.03,
          color: Colors.white,
        ),
      ),
    );
  }
}
