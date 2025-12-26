import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class ItemMutasiStok extends StatelessWidget {
  final DateTime waktu;
  final String keterangan;
  final int potongan;
  final int stok;
  final bool isOdd;
  final bool isMinus;

  const ItemMutasiStok({
    super.key,
    required this.waktu,
    required this.keterangan,
    required this.potongan,
    required this.stok,
    required this.isOdd,
    this.isMinus = false,
  });

  @override
  Widget build(BuildContext context) {
    var dateStr = DateHelper.formatSimpleDate(waktu);
    var waktuStr = DateHelper.formatTime(waktu);

    return Container(
      color: isOdd ? context.secondary : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$dateStr\nPukul $waktuStr',
              textAlign: TextAlign.start,
              style: context.captionRegular
                  .withWeight(FontWeight.w400)
                  .withColor(context.foreground),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 2),
              child: Text(keterangan,
                  style: context.captionMedium
                      .withWeight(FontWeight.w400)
                      .withColor(context.foreground)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 4),
            width: 60,
            child: Text(
              isMinus
                  ? '-${ToCurrency(potongan.toString())}'
                  : ToCurrency(potongan.toString()),
              textAlign: TextAlign.end,
              style: context.bodySmall
                  .withColor(isMinus ? context.destructive : context.primary),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 4),
            width: 50,
            child: Text(
              ToCurrency(stok.toString()),
              textAlign: TextAlign.end,
              style: context.bodySmall
                  .withColor(isMinus ? context.destructive : context.primary),
            ),
          ),
        ],
      ),
    );
  }
}
