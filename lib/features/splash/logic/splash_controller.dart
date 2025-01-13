import 'package:flutter/material.dart';

class SplashController {
  final BuildContext context;

  SplashController(this.context);

  void navigateToNextScreen() async {
    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the next screen (e.g., login or dashboard)
    Navigator.pushReplacementNamed(context, '/login');
  }
}
