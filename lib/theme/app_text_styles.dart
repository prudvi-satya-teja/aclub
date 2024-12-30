import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    button: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  );

  static const TextTheme textThemeDark = TextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white70),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white70),
    button: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  );
}
