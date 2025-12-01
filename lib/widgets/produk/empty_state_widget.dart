import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? animationAsset;
  final double animationWidth;
  final Widget? actionWidget;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle = 'Tarik ke bawah untuk refresh',
    this.animationAsset,
    this.animationWidth = 200,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animationAsset ?? Assets.animations.noData,
            width: animationWidth,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: context.bodyMedium
                .copyWith(color: context.mutedForeground)
                .withWeight(FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: context.bodySmall.copyWith(color: context.mutedForeground),
              textAlign: TextAlign.center,
            ),
          ],
          if (actionWidget != null) ...[
            const SizedBox(height: 16),
            actionWidget!,
          ],
        ],
      ),
    );
  }
}