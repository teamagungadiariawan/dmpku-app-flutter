import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class CardTanya extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;
  final Color borderColor;

  const CardTanya({
    super.key,
    this.title = "Punya Pertanyaan?",
    this.subtitle = "Langsung chat dengan customer service kami",
    this.buttonText = "Tanya Sekarang",
    this.borderColor = AppColors.lightBorder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.bodyMedium.withWeight(FontWeight.w800),
                  ),
                  Text(
                    subtitle,
                    style: context.bodySmall.withColor(context.mutedForeground),
                  ),
                  Gap(5),
                  CustomButton(
                    text: "Tanya Sekarang",
                    onPressed: onTap,
                    variant: ButtonVariant.border,
                    borderColor: context.primary,
                    foregroundColor: context.primary,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 30,
                  ),
                ],
              ),
            ),
            Gap(10),
            Lottie.asset(
              Assets.animations.punyaPertanyaan,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
