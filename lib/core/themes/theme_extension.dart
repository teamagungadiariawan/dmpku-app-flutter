import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Extension untuk memudahkan akses warna tema
extension ThemeExtension on BuildContext {
  // Cek apakah sedang dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Quick access ke color scheme
  ColorScheme get colors => Theme.of(this).colorScheme;

  // Shadcn-inspired colors
  Color get background => isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  Color get foreground => isDarkMode ? AppColors.darkForeground : AppColors.lightForeground;

  Color get card => isDarkMode ? AppColors.darkCard : AppColors.lightCard;
  Color get cardForeground => isDarkMode ? AppColors.darkCardForeground : AppColors.lightCardForeground;

  Color get popover => isDarkMode ? AppColors.darkPopover : AppColors.lightPopover;
  Color get popoverForeground => isDarkMode ? AppColors.darkPopoverForeground : AppColors.lightPopoverForeground;

  Color get primary => isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
  Color get primaryForeground => isDarkMode ? AppColors.darkPrimaryForeground : AppColors.lightPrimaryForeground;

  Color get secondary => isDarkMode ? AppColors.darkSecondary : AppColors.lightSecondary;
  Color get secondaryForeground => isDarkMode ? AppColors.darkSecondaryForeground : AppColors.lightSecondaryForeground;

  Color get muted => isDarkMode ? AppColors.darkMuted : AppColors.lightMuted;
  Color get mutedForeground => isDarkMode ? AppColors.darkMutedForeground : AppColors.lightMutedForeground;

  Color get accent => isDarkMode ? AppColors.darkAccent : AppColors.lightAccent;
  Color get accentForeground => isDarkMode ? AppColors.darkAccentForeground : AppColors.lightAccentForeground;

  Color get destructive => isDarkMode ? AppColors.darkDestructive : AppColors.lightDestructive;
  Color get destructiveForeground => isDarkMode ? AppColors.darkDestructiveForeground : AppColors.lightDestructiveForeground;

  Color get success => isDarkMode ? AppColors.darkSuccess : AppColors.lightSuccess;
  Color get successForeground => isDarkMode ? AppColors.darkSuccessForeground : AppColors.lightSuccessForeground;

  Color get warning => isDarkMode ? AppColors.darkWarning : AppColors.lightWarning;
  Color get warningForeground => isDarkMode ? AppColors.darkWarningForeground : AppColors.lightWarningForeground;

  Color get border => isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;
  Color get input => isDarkMode ? AppColors.darkInput : AppColors.lightInput;
  Color get ring => isDarkMode ? AppColors.darkRing : AppColors.lightRing;
}