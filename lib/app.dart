import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class AClubApp extends StatelessWidget {
  const AClubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACLUB',
      theme: AppTheme.lightTheme, // Light theme configuration
      darkTheme: AppTheme.darkTheme, // Dark theme configuration
      themeMode: ThemeMode.system, // Use system theme preference
      initialRoute: AppRoutes.splash, // Set the initial route
      onGenerateRoute: AppRoutes.onGenerateRoute, // Handle dynamic routing
    );
  }
}
