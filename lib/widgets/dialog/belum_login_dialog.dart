import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BelumLoginDialog extends StatelessWidget {
  const BelumLoginDialog({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      requestFocus: true,
      useSafeArea: true,
      builder: (_) => const BelumLoginDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: context.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopDividerSheet(),
              Gap(15),
              Card(
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.isDarkMode ? stone[700] : stone[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.shieldAlert500,
                          color: context.primary,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Anda belum login',
                              style: context.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Silakan login untuk mengakses fitur ini.',
                              style: context.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 30,
                      padding: EdgeInsets.zero,
                      variant: ButtonVariant.primary,
                      text: "Login",
                      onPressed: () {},
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: CustomButton(
                      height: 30,
                      padding: EdgeInsets.zero,
                      variant: ButtonVariant.border,
                      borderColor: context.primary,
                      foregroundColor: context.primary,
                      text: "Daftar",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
