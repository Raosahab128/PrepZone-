import 'package:flutter/material.dart';

/// Design tokens from Module 3 — "Stamp" identity, not generic edtech blue.
class AppColors {
  // Light
  static const inkNavy = Color(0xFF12203D);
  static const paper = Color(0xFFF6F5F1);
  static const stampGold = Color(0xFFC9932E);
  static const correctGreen = Color(0xFF1E7F5C);
  static const errorRust = Color(0xFFB3413A);
  static const slate = Color(0xFF5C6478);

  // Dark
  static const deepInk = Color(0xFF0B1220);
  static const cardSurfaceDark = Color(0xFF151F30);
  static const stampGoldDark = Color(0xFFE8C77A);
  static const textLight = Color(0xFFF5F4F0);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.paper,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.inkNavy,
      brightness: Brightness.light,
      primary: AppColors.inkNavy,
      secondary: AppColors.stampGold,
      error: AppColors.errorRust,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.paper,
      foregroundColor: AppColors.inkNavy,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: _textTheme(AppColors.inkNavy),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.deepInk,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.stampGoldDark,
      brightness: Brightness.dark,
      primary: AppColors.stampGoldDark,
      secondary: AppColors.stampGoldDark,
      error: AppColors.errorRust,
      surface: AppColors.cardSurfaceDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.deepInk,
      foregroundColor: AppColors.textLight,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.cardSurfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: _textTheme(AppColors.textLight),
  );

  static TextTheme _textTheme(Color baseColor) {
    // Space Grotesk (headings) + Inter (body) + IBM Plex Mono (data/numbers).
    // Bundle the actual font files under assets/fonts/ and declare them in
    // pubspec.yaml's `fonts:` section before shipping — using fontFamily
    // strings here as placeholders for that setup.
    return TextTheme(
      headlineMedium: TextStyle(fontFamily: 'SpaceGrotesk', fontWeight: FontWeight.w600, color: baseColor),
      titleLarge: TextStyle(fontFamily: 'SpaceGrotesk', fontWeight: FontWeight.w600, color: baseColor),
      bodyLarge: TextStyle(fontFamily: 'Inter', color: baseColor),
      bodyMedium: TextStyle(fontFamily: 'Inter', color: baseColor),
      labelLarge: const TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w600),
    );
  }

  /// Use for scores, ranks, timers, percentiles — the signature "data" style.
  static const TextStyle dataStyle = TextStyle(
    fontFamily: 'IBMPlexMono',
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
}
