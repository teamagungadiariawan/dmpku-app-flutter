import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class PilihPpobCetakDialog extends StatefulWidget {
  final Function onPPOB1;
  final Function onPPOB2;

  const PilihPpobCetakDialog({
    super.key,
    required this.onPPOB1,
    required this.onPPOB2,
  });

  static Future<void> show(
    BuildContext context, {
    required Function onPPOB1,
    required Function onPPOB2,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PilihPpobCetakDialog(onPPOB1: onPPOB1, onPPOB2: onPPOB2),
    );
  }

  @override
  State<PilihPpobCetakDialog> createState() => _PilihPpobCetakDialogState();
}

class _PilihPpobCetakDialogState extends State<PilihPpobCetakDialog> {
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
                      child: Icon(MdiIcons.printerPosNetwork, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Format Cetak Struk',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Tentukan format cetak struk sesuai kebutuhan Anda.',
                            style: context.captionRegular.withColor(
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
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  widget.onPPOB1();
                },
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Icon(MdiIcons.printerPosEdit, size: 20),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Format PPOB 1',
                              style: context.bodySmall.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Cetak detail dengan menambahkan biaya jasa.',
                              style: context.captionRegular.withColor(
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
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  widget.onPPOB2();
                },
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Icon(MdiIcons.printerPosEdit, size: 20),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Format PPOB 2',
                              style: context.bodySmall.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Cetak detail dengan mengubah biaya admin.',
                              style: context.captionRegular.withColor(
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
            ),
            Card(
              color: context.isDarkMode ? stone[800] : stone[200],
              child: Padding(
                padding: paddingCard,
                child: Row(
                  children: [
                    Icon(MdiIcons.printerPosEdit, size: 20),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Format PPOB 3',
                                style: context.bodySmall.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: context.warning,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Segera Hadir',
                                  style: context.captionRegular
                                      .withColor(Colors.white)
                                      .withWeight(FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Sedang menunggu masukan, akan segera hadir.',
                            style: context.captionRegular.withColor(
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
            Gap(15),
            CustomButton(
              height: 32,
              padding: EdgeInsets.zero,
              width: double.infinity,
              text: "Tutup",
              variant: ButtonVariant.destructive,
              onPressed: () {
                pop();
              },
            ),

            Gap(15),
          ],
        ),
      ),
    );
  }
}
