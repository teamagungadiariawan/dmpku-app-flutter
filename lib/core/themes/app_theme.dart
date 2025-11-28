import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightPrimaryForeground,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightSecondaryForeground,
      error: AppColors.lightDestructive,
      onError: AppColors.lightDestructiveForeground,
      surface: AppColors.lightCard,
      onSurface: AppColors.lightCardForeground,
    ),
    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.lightBorder, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      enabledBorder:  InputBorder.none,
      focusedBorder:  InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      suffixIconConstraints: const BoxConstraints(
        minHeight: 0,
        minWidth: 0,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightPrimaryForeground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightPrimary,
        side: BorderSide(color: AppColors.lightPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightForeground,
      elevation: 0,
      centerTitle: false,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkPrimaryForeground,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkSecondaryForeground,
      error: AppColors.darkDestructive,
      onError: AppColors.darkDestructiveForeground,
      surface: AppColors.darkCard,
      onSurface: AppColors.darkCardForeground,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.darkBorder, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      enabledBorder:  InputBorder.none,
      focusedBorder:  InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      suffixIconConstraints: const BoxConstraints(
        minHeight: 0,
        minWidth: 0,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkPrimaryForeground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightPrimary,
        side: BorderSide(color: AppColors.lightPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkForeground,
      elevation: 0,
      centerTitle: false,
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
