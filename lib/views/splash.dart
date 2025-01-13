import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Create fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation
    _controller!.forward();

    // Navigate to Onboarding screen after a delay
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 3 seconds after the animation
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive setup
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    // MediaQuery for responsive layout
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Color(0xFF112148), // Slightly transparent dark color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Centered Column with logo and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.network(
                    'assets/logo/ACLUB_.png', // Replace with your logo path
                    height: screenHeight * 0.3, // Responsive height
                    width: screenWidth * 0.6, // Responsive width
                  ),
                ),

                SizedBox(height: 20.h),

                // Text with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  // child: Text(
                  //   'ACLUB',
                  //   style: TextStyle(
                  //     fontSize: 32.sp,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //     letterSpacing: 1.5,
                  //     shadows: [
                  //       Shadow(
                  //         offset: Offset(1.5, 1.5),
                  //         blurRadius: 5.0,
                  //         color: Colors.black45,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),

                SizedBox(height: 25.h),

                // Circular loading indicator with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
