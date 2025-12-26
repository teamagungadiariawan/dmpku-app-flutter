import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PaymentMethodItem extends StatelessWidget {
  final Widget image;
  final String title;
  final String? subtitle;
  final Widget? titleBadge;
  final List<Widget> details;
  final VoidCallback onTap;

  const PaymentMethodItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.titleBadge,
    this.details = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: paddingCard,
          child: Row(
            children: [
              SizedBox(width: 45, height: 45, child: image),
              const Gap(6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: context.bodyMedium.withWeight(FontWeight.w600),
                        ),
                        if (titleBadge != null) ...[
                          const Spacer(),
                          titleBadge!,
                        ],
                      ],
                    ),
                    if (subtitle != null) ...[
                      const Gap(2),
                      Text(
                        subtitle!,
                        style: context.captionRegular.withWeight(
                          FontWeight.w600,
                        ),
                        textHeightBehavior: AppTextHeightBehavior.noPadding,
                      ),
                    ],
                    if (details.isNotEmpty) ...[const Gap(2), ...details],
                  ],
                ),
              ),
              const Gap(5),
              Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: context.mutedForeground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;

  const DetailInfo({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: iconColor ?? context.mutedForeground),
        const Gap(4),
        Text(
          text,
          style: context.captionRegular
              .withColor(textColor ?? context.foreground)
              .withWeight(FontWeight.w600),
          textHeightBehavior: AppTextHeightBehavior.noPadding,
        ),
      ],
    );
  }
}
