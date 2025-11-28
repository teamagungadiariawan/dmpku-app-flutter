import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class TopDividerSheet extends StatelessWidget {
  const TopDividerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 5,
        width: 120,
        decoration: BoxDecoration(
          color: context.isDarkMode ? stone[700] : stone[300],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
