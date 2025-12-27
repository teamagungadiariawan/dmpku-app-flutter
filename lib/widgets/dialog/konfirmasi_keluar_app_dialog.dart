import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class KonfirmasiKeluarAppDialog extends StatefulWidget {
  const KonfirmasiKeluarAppDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const KonfirmasiKeluarAppDialog(),
    );
  }

  @override
  State<KonfirmasiKeluarAppDialog> createState() =>
      _KonfirmasiKeluarAppDialogState();
}

class _KonfirmasiKeluarAppDialogState extends State<KonfirmasiKeluarAppDialog> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: paddingPage.copyWith(bottom: bottomInset),
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
            Gap(10),
            TopDividerSheet(),
            Gap(15),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: context.destructive, width: 1),
              ),
              color: context.destructive.withValues(alpha: 0.3),
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
                        LucideIcons.logOut,
                        size: 16,
                        color: context.destructive,
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keluar Aplikasi',
                            style: context.bodyMedium
                                .copyWith(fontWeight: FontWeight.w600)
                                .withColor(context.destructive),
                          ),
                          Text(
                            'Yakin ingin keluar dari aplikasi?',
                            style: context.captionMedium.withColor(
                              context.foreground,
                            ),
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
                    variant: ButtonVariant.border,
                    borderColor: context.primary,
                    foregroundColor: context.primary,
                    text: "Batal",
                    onPressed: () {
                      pop();
                    },
                  ),
                ),
                Gap(15),
                Expanded(
                  child: CustomButton(
                    height: 30,
                    padding: EdgeInsets.zero,
                    variant: ButtonVariant.destructive,
                    text: "Keluar",
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
              ],
            ),
            Gap(10),
          ],
        ),
      ),
    );
  }
}
