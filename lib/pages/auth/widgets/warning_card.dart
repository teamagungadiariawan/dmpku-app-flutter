import 'package:flutter/material.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

/// Warning Card Colors - tambahkan ke app_colors.dart
class WarningCardColors {
  // Light Mode
  static const lightBackground = Color(0xFFFFF7ED); // orange.50
  static const lightBorder = Color(0xFFFED7AA); // orange.200
  static const lightIcon = Color(0xFFF97316); // orange.500
  static const lightTitle = Color(0xFFEA580C); // orange.600
  static const lightText = Color(0xFF9A3412); // orange.800

  // Dark Mode
  static const darkBackground = Color(0xFF431407); // orange.950
  static const darkBorder = Color(0xFF7C2D12); // orange.900
  static const darkIcon = Color(0xFFFB923C); // orange.400
  static const darkTitle = Color(0xFFFDBA74); // orange.300
  static const darkText = Color(0xFFFED7AA); // orange.200
}

/// Widget WarningCard yang responsive terhadap tema
class WarningCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const WarningCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = MdiIcons.lock,
    this.padding,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark
        ? WarningCardColors.darkBackground
        : WarningCardColors.lightBackground;
    final borderColor = isDark
        ? WarningCardColors.darkBorder
        : WarningCardColors.lightBorder;
    final iconColor = isDark
        ? WarningCardColors.darkIcon
        : WarningCardColors.lightIcon;
    final titleColor = isDark
        ? WarningCardColors.darkTitle
        : WarningCardColors.lightTitle;
    final textColor = isDark
        ? WarningCardColors.darkText
        : WarningCardColors.lightText;

    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.labelLarge.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(2),
                Text(
                  message,
                  style: context.captionMedium.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

