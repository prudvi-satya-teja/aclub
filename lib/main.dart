import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'routes/app_routes.dart';
import 'features/splash/presentation/splash_screen.dart'; // Adjust import to the correct splash screen location

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable DevicePreview in debug mode
      builder: (context) => const AClubApp(),
    ),
  );
}

class AClubApp extends StatelessWidget {
  const AClubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context), // For DevicePreview
      builder: DevicePreview.appBuilder,
      title: 'ACLUB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash, // Updated to use the initial route from AppRoutes
      routes: AppRoutes.routes, // Defined in app_routes.dart
    );
  }
}
