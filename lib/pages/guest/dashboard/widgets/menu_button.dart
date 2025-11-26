import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MenuData {
  final String title;
  final ImageProvider icon;

  const MenuData(this.title, this.icon);
}

class MenuButton extends StatelessWidget {
  final String title;
  final ImageProvider icon;
  final VoidCallback onTap;
  final double iconSize;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: icon, width: iconSize, height: iconSize),
            const Gap(4),
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: context.captionMedium.copyWith(
                color: context.foreground,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
