import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'terms.dart';
import 'login.dart';
import 'signup.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;
  bool isPrivacyPolicyChecked = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildPage(
      BuildContext context,
      String title,
      String description,
      String imageUrl,
      String extraText,
      ) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: screenSize.width * 0.07, // Adjust size as needed
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenSize.height * 0.02),
          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: screenSize.width * 0.05,
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Montserrat',
              height: 1.4, // Line height for better readability
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenSize.height * 0.05),
          if (imageUrl.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  height: screenSize.height * 0.28,
                  width: screenSize.width * 0.6,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          SizedBox(height: screenSize.height * 0.05),
          // Extra text
          Text(
            extraText,
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              color: Colors.white.withOpacity(0.85),
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ],
      ),
    );
  }

  List<Widget> _buildPageList(BuildContext context) {
    return [
      buildPage(
        context,
        "Welcome to ClubConnect",
        "Explore and stay updated with all the college clubs in one place.",
        'assets/logo/ACLUB.png',  // Use your college logo here
        "Join the community and discover your passion.",
      ),

      buildPage(
        context,
        "Explore Clubs",
        "Browse through various clubs and know what they offer.",
        'assets/Profile.png',  // Image representing profile
        "Find clubs that match your interests and get involved.",
      ),

      buildPage(
        context,
        "Track Events",
        "Stay informed about upcoming events and activities in all clubs.",
        'assets/Attendance.png',  // Image representing attendance
        "Never miss a club event—mark your calendar today!",
      ),

      buildPage(
        context,
        "Your Club Details",
        "Access detailed information about your club, members, and organizers.",
        'assets/Timetable.png',  // Image representing timetable
        "Be a part of your club's journey and connect with other members.",
      ),

      buildPage(
        context,
        "Exclusive Resources",
        "Access resources like club handbooks, event guides, and materials.",
        'assets/Pdf.jpg',  // Image for syllabus or documents
        "Get exclusive resources for members of your club.",
      ),

      buildPage(
        context,
        "Admin Tools           Coming Soon!",
        "Admins will soon have tools to manage club members and events.",
        'assets/Staff.jpg',  // Image for staff login placeholder
        "Enhance your club's management experience. Stay tuned!",
      ),



    ];
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF000000), // Black base
              Color(0xFF112148), // Dark blue
              Color(0xFF2A2A5A), // Dark indigo-blue
              Color(0xFF3D3D7A), // Muted dark purple
              Color(0xFF4A4A92), // Rich navy blue
              Color(0xFF5C5CAD), // Softer blueish purple
              Color(0xFF7171C2), // Gentle lavender blue
              Color(0xFF8A8AD5), // Light cool lavender
            ],

            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: _buildPageList(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    _buildPageList(context).length,
                        (index) => Padding(
                      padding: EdgeInsets.only(right: screenSize.width * 0.01),
                      child: DotIndicator(
                        isActive: index == currentPage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isPrivacyPolicyChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isPrivacyPolicyChecked = value ?? false;
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: "By proceeding you agree to our ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.width * 0.04,
                    ),
                    children: [
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: Color(0xFF012869),
                          fontSize: screenSize.width * 0.04,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TermsAndConditionsScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.02),
            InkWell(
              onTap: isPrivacyPolicyChecked
                  ? () {
                Navigator.of(context).push(_createRoute());
              }
                  : null, // Disable button if checkbox is not checked
              child: Container(
                margin: EdgeInsets.only(bottom: screenSize.height * 0.05),
                height: screenSize.height * 0.075,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                  color: isPrivacyPolicyChecked ? Color(0xFF112148) : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Login / Registration",
                    style: TextStyle(
                      fontFamily: "HappyMonkey",
                      color: Colors.white,
                      fontSize: screenSize.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SimpleLoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: screenSize.width * 0.02,
      width: isActive ? screenSize.width * 0.06 : screenSize.width * 0.02,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(screenSize.width * 0.04),
        ),
      ),
    );
  }
}
