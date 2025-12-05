import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DashboardAppBar extends StatelessWidget {
  final double opacity;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onHelpTap;

  const DashboardAppBar({
    super.key,
    required this.opacity,
    this.onNotificationTap,
    this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: context.primary.withOpacity(opacity),
        child: SafeArea(
          child: SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Assets.img.logoTextWhite.image(height: 30),
                  _AppBarActions(
                    primaryColor: context.primary,
                    onNotificationTap: onNotificationTap,
                    onHelpTap: onHelpTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarActions extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onHelpTap;

  const _AppBarActions({
    required this.primaryColor,
    this.onNotificationTap,
    this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          height: 25,
          width: 25,
          padding: const EdgeInsets.all(4),
          borderRadius: BorderRadius.circular(999),
          variant: ButtonVariant.secondary,
          text: '',
          foregroundColor: primaryColor,
          icon: LucideIcons.bell600,
          onPressed: onNotificationTap ?? () {},
        ),
        const Gap(5),
        CustomButton(
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          borderRadius: BorderRadius.circular(999),
          variant: ButtonVariant.secondary,
          text: 'Bantuan',
          foregroundColor: primaryColor,
          icon: LucideIcons.messageCircleQuestionMark600,
          onPressed: onHelpTap ?? () {},
        ),
      ],
    );
  }
}
