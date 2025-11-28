import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final VoidCallback onPressed;

  const PromoCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mau Lebih Untung ?', style: context.labelMedium),
                  Text(
                    'Gabung dengan kami sekarang!',
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
            CustomButton(
              height: 25,
              padding: EdgeInsets.zero,
              text: 'Masuk',
              onPressed: onPressed,
              variant: ButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }
}