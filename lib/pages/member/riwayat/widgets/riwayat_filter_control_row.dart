import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RiwayatFilterControlRow extends StatelessWidget {
  final String labelTitle;
  final String labelValue;
  final VoidCallback onFilter;
  final VoidCallback onRefresh;
  final bool isLoading;

  const RiwayatFilterControlRow({
    super.key,
    required this.labelTitle,
    required this.labelValue,
    required this.onFilter,
    required this.onRefresh,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelTitle,
                style: context.bodySmall.withColor(context.primary),
              ),
              Text(
                labelValue,
                style: context.bodySmall.withWeight(FontWeight.w600),
              ),
            ],
          ),
        ),
        const Gap(5),
        VerticalDivider(color: context.primary, thickness: 4, width: 1),
        const Gap(5),
        CustomButton(
          height: 25,
          size: ButtonSize.small,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          text: "Filter",
          textStyle: context.captionMedium
              .withWeight(FontWeight.w600)
              .withColor(context.primaryForeground),
          icon: LucideIcons.filter,
          onPressed: onFilter,
        ),
        const Gap(5),
        CustomButton(
          height: 25,
          size: ButtonSize.small,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          text: "Refresh",
          textStyle: context.captionMedium
              .withWeight(FontWeight.w600)
              .withColor(context.primaryForeground),
          icon: LucideIcons.refreshCcw,
          isLoading: isLoading,
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
