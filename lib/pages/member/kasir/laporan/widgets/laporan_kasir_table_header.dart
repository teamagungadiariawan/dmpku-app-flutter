import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class LaporanKasirTableHeader extends StatelessWidget {
  const LaporanKasirTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Pelanggan",
              style: context.bodySmall
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              "QTY",
              textAlign: TextAlign.center,
              style: context.bodySmall
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              "Modal",
              textAlign: TextAlign.end,
              style: context.bodySmall
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              "Jual",
              textAlign: TextAlign.end,
              style: context.bodySmall
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
            ),
          ),
        ],
      ),
    );
  }
}
