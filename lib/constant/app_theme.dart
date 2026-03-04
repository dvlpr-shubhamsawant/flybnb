import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.white,
      error: AppColors.error,
      onPrimary: AppColors.black,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
      onError: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: lightTextTheme(),

    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),

      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.colordbd9d9),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primary),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.error),
      ),
    ),
  );

  static TextTheme lightTextTheme() => TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'ManropeBold',
      fontSize: 26.sp,
      color: AppColors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'ManropeBold',
      fontSize: 22.sp,
      color: AppColors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: 'ManropeSemiBold',
      fontSize: 18.sp,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'ManropeSemiBold',
      fontSize: 16.sp,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'ManropeMedium',
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'ManropeMedium',
      fontSize: 12.sp,
      color: AppColors.black,
    ),
  );
}
