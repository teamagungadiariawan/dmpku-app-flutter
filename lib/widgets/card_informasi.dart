import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardInformasi extends StatelessWidget {
  final Color borderColor;

  const CardInformasi({super.key, this.borderColor = AppColors.lightBorder});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi",
              style: context.bodyMedium.withWeight(FontWeight.w600),
            ),
            Gap(8),
            Text(
              "\u2022 Pastikan Data Transaksi sudah benar",
              style: context.bodySmall.withSize(13),
            ),
            Text(
              "\u2022 Transaksi tidak bisa dibbatalkan jika Transaksi Sudah Berhasil",
              style: context.bodySmall.withSize(13),
            ),
            Text(
              "\u2022 Transaksi dengan Status Pending atau Dalam Proses tidak bisa dibatalkan",
              style: context.bodySmall.withSize(13),
            ),
            Text(
              "\u2022 Jika terjadi kendala dalam setiap Transaksi silahkan menghubungi Customer Service kami yang stanby 24 jam",
              style: context.bodySmall.withSize(13),
            ),
          ],
        ),
      ),
    );
  }
}
