import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardCaraBayarVa extends StatelessWidget {
  const CardCaraBayarVa({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: paddingCard,
            decoration: BoxDecoration(
              color: !context.isDarkMode ? slate[50] : slate[800],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              border: Border(
                bottom: BorderSide(color: context.border, width: 1),
              ),
            ),
            child: Text(
              "Cara Pembayaran",
              style: context.bodyLarge.withWeight(FontWeight.w600),
            ),
          ),
          Padding(
            padding: paddingCard,
            child: Column(
              children: [
                _buildStep(
                  context,
                  1,
                  "Buka aplikasi mobile banking atau ATM Anda.",
                ),
                _buildStep(context, 2, "Pilih menu Transfer atau Pembayaran."),
                _buildStep(context, 3, "Pilih opsi Virtual Account."),
                _buildStep(
                  context,
                  4,
                  "Masukkan Nomor Virtual Account yang tertera di atas.",
                ),
                _buildStep(
                  context,
                  5,
                  "Pastikan nama penerima dan nominal sesuai.",
                ),
                _buildStep(
                  context,
                  6,
                  "Lanjutkan proses pembayaran hingga selesai.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number. ",
            style: context.bodyMedium.withColor(context.mutedForeground),
          ),
          Expanded(
            child: Text(
              text,
              style: context.bodyMedium.withColor(context.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}
