import 'package:dmpku/core/enums/status_trx.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardRiwayatTransaksi extends StatelessWidget {
  final String namaProduk;
  final String tujuan;
  final String totalHarga;
  final TrxStatus status;
  final DateTime waktuTrx;
  final String imgProduk;
  final Function()? onTap;

  const CardRiwayatTransaksi({
    super.key,
    required this.namaProduk,
    required this.tujuan,
    required this.totalHarga,
    required this.status,
    required this.waktuTrx,
    required this.imgProduk,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Opsional: biar lebih flat modern, atau sesuaikan selera
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.border, width: 0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12), // Padding standard card
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // Align top biar rapi
            children: [
              _buildImage(context),
              const Gap(12), // Kasih jarak napas dikit
              Expanded(child: _buildMainInfo(context)),
              const Gap(8),
              _buildTrailing(context),
            ],
          ),
        ),
      ),
    );
  }

  // Bagian Kiri: Info Produk & Tujuan & Waktu
  Widget _buildMainInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          namaProduk,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.bodyMedium
              .withColor(context.foreground)
              .withWeight(FontWeight.w600),
        ),
        const Gap(4),
        Text(
          "Tujuan : $tujuan",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.bodySmall.withColor(context.foreground),
        ),
        // Waktu ditaruh sini biar flow bacanya enak: Apa -> Ke Siapa -> Kapan
      ],
    );
  }

  // Bagian Kanan: Harga & Status Badge
  Widget _buildTrailing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          totalHarga,
          style: context.bodyMedium
              .withWeight(FontWeight.bold)
              .withColor(status.textColor(context)),
        ),
        const Gap(2),

        Row(
          children: [
            Container(
              width: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.clock,
                    size: 12,
                    color: context.mutedForeground,
                  ),
                  const Gap(4),
                  Text(
                    DateHelper.formatTime(waktuTrx),
                    style: context.captionRegular.withColor(context.foreground),
                  ),
                ],
              ),
            ),
            Gap(4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ).copyWith(top: 3),
              decoration: BoxDecoration(
                color: status.bgColor(context),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status.text,
                textAlign: TextAlign.center,
                style: context.labelSmall
                    .withColor(status.textColor(context))
                    .withWeight(FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.border, width: 1),
      ),
      child: Image.network(
        imgProduk,
        fit: BoxFit.contain,
        height: 24,
        width: 24,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.image_not_supported_outlined,
            size: 20,
            color: context.mutedForeground,
          );
        },
      ),
    );
  }
}
