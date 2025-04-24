// theme.dart
import 'package:flutter/material.dart';

class AppColors {
  static const lightPrimary = Color(0xFF0066CC);
  static const lightBackground = Color(0xFFF2F2F2);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightText = Color(0xFF000000);

  static const darkPrimary = Color(0xFF3399FF);
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkText = Color(0xFFFFFFFF);
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.lightPrimary,
  scaffoldBackgroundColor: AppColors.lightBackground,
  textTheme: const TextTheme(
    titleLarge: AppTypography.titleLarge,
    bodyLarge: AppTypography.titleMedium,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodyMedium,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.lightPrimary,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    onPrimary: Colors.white,
    onBackground: AppColors.lightText,
    onSurface: AppColors.lightText,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: const TextTheme(
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    onPrimary: Colors.black,
    onBackground: AppColors.darkText,
    onSurface: AppColors.darkText,
  ),
);

class AppTypography {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
