import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class KonfirmasiPinDialog extends StatefulWidget {
  final bool isLoading;
  final String title;
  final String subtitle;
  final Function(String pin) onConfirm;

  const KonfirmasiPinDialog({
    super.key,
    required this.isLoading,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
  });

  @override
  State<KonfirmasiPinDialog> createState() => _KonfirmasiPinDialogState();
}

class _KonfirmasiPinDialogState extends State<KonfirmasiPinDialog> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      child: Icon(MdiIcons.qrcodeScan),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan Barcode/QR Code',
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Scan barcode atau QR code untuk mendapatkan informasi dengan cepat.',
                            style: context.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(5),



          ],
        ),
      ),
    );
  }
}
