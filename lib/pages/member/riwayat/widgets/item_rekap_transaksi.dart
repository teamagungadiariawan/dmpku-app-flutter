import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class ItemRekapTransaksi extends StatelessWidget {
  final int no;
  final String produk;
  final int jmlTrx;
  final int total;
  final bool isOdd;

  const ItemRekapTransaksi({
    super.key,
    required this.no,
    required this.produk,
    required this.jmlTrx,
    required this.total,
    required this.isOdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isOdd ? context.secondary : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.only(left: 2),
            width: 30,
            child: Text(
              no.toString(),
              textAlign: TextAlign.start,
              style: context.captionRegular
                  .withWeight(FontWeight.w400)
                  .withColor(context.foreground),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 2),
              child: Text(
                produk,
                style: context.captionMedium
                    .withWeight(FontWeight.w400)
                    .withColor(context.foreground),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 4),
            width: 100,
            child: Text(
              ToCurrency(jmlTrx.toString()),
              textAlign: TextAlign.end,
              style: context.bodySmall.withColor(context.primary),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 4),
            width: 100,
            child: Text(
              ToCurrency(total.toString()),
              textAlign: TextAlign.end,
              style: context.bodySmall.withColor(context.primary),
            ),
          ),
        ],
      ),
    );
  }
}
