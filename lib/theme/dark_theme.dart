import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class DarkTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryDarkColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    textTheme: AppTextStyles.textThemeDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDarkColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDarkColor,
    ),
  );
}
