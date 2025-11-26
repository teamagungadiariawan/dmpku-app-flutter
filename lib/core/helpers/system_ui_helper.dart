import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUIHelper {
  /// Change status bar and navigation bar colors
  ///
  /// [statusBarColor] - Color for status bar background
  /// [isLightStatusBar] - true for light icons (use with dark background)
  ///                      false for dark icons (use with light background)
  /// [navigationBarColor] - Optional color for navigation bar (Android only)
  /// [isLightNavBar] - true for light icons, false for dark icons
  static Future<void> changeSystemUI({
    required Color statusBarColor,
    bool isLightStatusBar = false,
    Color? navigationBarColor,
    bool isLightNavBar = false,
  }) async {
    try {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          // Status Bar
          statusBarColor: statusBarColor,
          statusBarIconBrightness: isLightStatusBar
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness: isLightStatusBar
              ? Brightness.dark
              : Brightness.light,

          // Navigation Bar (Android only)
          systemNavigationBarColor: navigationBarColor ?? statusBarColor,
          systemNavigationBarIconBrightness: isLightNavBar
              ? Brightness.light
              : Brightness.dark,
        ),
      );
    } catch (error) {
      debugPrint('Error changing system UI: $error');
    }
  }

  /// Set transparent status bar with auto icon color
  static Future<void> setTransparentStatusBar({
    bool isLightStatusBar = false,
  }) async {
    await changeSystemUI(
      statusBarColor: Colors.transparent,
      isLightStatusBar: isLightStatusBar,
      navigationBarColor: Colors.white,
      isLightNavBar: false,
    );
  }

  /// Set primary color for status bar
  static Future<void> setPrimaryStatusBar(BuildContext context) async {
    final primaryColor = Theme.of(context).primaryColor;
    await changeSystemUI(
      statusBarColor: primaryColor,
      isLightStatusBar: true, // white icons for colored background
      navigationBarColor: Colors.white,
      isLightNavBar: false,
    );
  }

  /// Set light theme system UI
  static Future<void> setLightSystemUI() async {
    await changeSystemUI(
      statusBarColor: Colors.white,
      isLightStatusBar: false, // dark icons
      navigationBarColor: Colors.transparent,
      isLightNavBar: false, // dark icons
    );
  }

  /// Set dark theme system UI
  static Future<void> setDarkSystemUI() async {
    await changeSystemUI(
      statusBarColor: const Color(0xFF09090B),
      isLightStatusBar: true, // light icons
      navigationBarColor: Colors.transparent,
      isLightNavBar: true, // light icons
    );
  }
}
