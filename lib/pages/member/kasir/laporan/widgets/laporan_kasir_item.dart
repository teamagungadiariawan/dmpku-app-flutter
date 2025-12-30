import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LaporanKasirItem extends StatelessWidget {
  final String namaPelanggan;
  final String waktu;
  final int qty;
  final int modal;
  final int jual;
  final bool isOdd;

  const LaporanKasirItem({
    super.key,
    required this.namaPelanggan,
    required this.waktu,
    required this.qty,
    required this.modal,
    required this.jual,
    this.isOdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isOdd ? context.muted.withOpacity(0.3) : context.card,
        border: Border(bottom: BorderSide(color: context.border, width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaPelanggan,
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  DateHelper.formatDateTime(
                    DateHelper.tryParse(waktu) ?? DateTime.now(),
                  ),
                  style: context.bodySmall.withColor(context.mutedForeground),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              "$qty Produk",
              textAlign: TextAlign.center,
              style: context.bodySmall,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              ToCurrency(modal.toString()),
              textAlign: TextAlign.end,
              style: context.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              ToCurrency(jual.toString()),
              textAlign: TextAlign.end,
              style: context.bodySmall.withWeight(FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
