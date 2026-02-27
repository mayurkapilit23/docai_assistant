import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_colors.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      background: AppColors.lightBackground,
      surface: AppColors.lightSecondary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSecondary,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSecondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    //custom colors
    extensions: const [
      AppThemeColors(
        textPrimary: Colors.black,
        textSecondary: Colors.black54,
        border: Color(0xFFE0E0E0),
        hint: Color(0xFF9E9E9E),

        // Chat
        userBubble: AppColors.primary, // Blue
        botBubble: Colors.white, // White bubble
        userText: Colors.white, // White on blue
        botText: Colors.black87, // Dark on white
      ),
    ],
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      background: AppColors.darkBackground,
      surface: AppColors.darkSecondary,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSecondary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSecondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    //custom colors
    extensions: const [
      AppThemeColors(
        textPrimary: Colors.white,
        textSecondary: Colors.white70,
        border: Color(0xFF2C2F4A),
        hint: Color(0xFFB0B0B0),

        // Chat
        userBubble: AppColors.primary, // Same blue
        botBubble: Color(0xFF181B2E), // Dark surface
        userText: Colors.white,
        botText: Colors.white70,
      ),
    ],
  );
}
