import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final VoidCallback? onBackButtonPressed;
  final bool showBackButton;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 80,
    this.onBackButtonPressed,
    this.showBackButton = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(color: backgroundColor ?? context.primary),
      child: InkWell(
        onTap: () {
          if (onBackButtonPressed != null) {
            onBackButtonPressed!();
          } else {
            pop();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (showBackButton)
              Icon(LucideIcons.chevronLeft, size: 22, color: Colors.white),
            Gap(5),
            Text(
              title,
              style: context.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textHeightBehavior: AppTextHeightBehavior.noPadding,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
