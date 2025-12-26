import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RiwayatFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final List<String> categories;
  final Function(int) onTabSelected;

  const RiwayatFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.categories,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return InkWell(
            onTap: () => onTabSelected(index),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? context.primary : context.muted,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? context.primary : context.border,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index],
                style: context.bodySmall.copyWith(
                  color: isSelected ? Colors.white : context.foreground,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
