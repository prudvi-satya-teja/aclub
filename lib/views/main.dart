import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'profile.dart';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'onboarding.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'screen1.dart';
import 'splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'inbox.dart';
import 'terms.dart';
import 'login.dart';
import 'signup.dart';
import 'li.dart';


//
// void main() {
//   runApp(MyApp(),);
// }

void main() {
  runApp(
      DevicePreview(
        enabled: !kReleaseMode, // Enable DevicePreview in debug mode
        builder: (context) => MyApp(), // Launch MyApp
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926), // Design size based on the iPhone 13 Pro Max dimensions
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context), // For DevicePreview
          builder: DevicePreview.appBuilder,     // For DevicePreview
          title: 'STrack',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData.dark(),
           // home: MyHomePage(),
           // home: SplashScreen(),
           home: FAQPage(),
          // home: DashboardScreen(),
          //    home: SimpleRegisterScreen(),
           // home:  TermsScreen(),
           // home:  LangScreen(),
           //  home:  ForgotPassword(),
           // home:  SimpleLoginScreen(),
           // home:  HomeScreen(),
           // home:  AttendanceScreen(),
          // home:  PDFListScreen(),

        );
      },
    );
  }
}
