import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDarkColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    textTheme: AppTextStyles.textThemeDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDarkColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryDarkColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
