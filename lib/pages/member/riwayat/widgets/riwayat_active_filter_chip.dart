import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RiwayatActiveFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onReset;

  const RiwayatActiveFilterChip({
    super.key,
    required this.label,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingPage.copyWith(left: 18, right: 18),
      child: Row(
        children: [
          Text(
            "FILTER: ",
            style: context.bodyMedium
                .withColor(context.mutedForeground)
                .withWeight(FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? context.primary.withValues(alpha: 0.1)
                  : context.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: context.bodySmall
                  .withColor(context.primary)
                  .withWeight(FontWeight.w600),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onReset,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.destructive.withValues(alpha: 0.2),
              ),
              child: Row(
                children: [
                  Text(
                    "Hapus",
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                  const Gap(4),
                  Icon(
                    LucideIcons.x,
                    size: 16,
                    color: context.destructive,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
