import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class RiwayatTableHeader extends StatelessWidget {
  final List<Map<String, dynamic>> columns;

  const RiwayatTableHeader({
    super.key,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: columns.map((col) {
          final label = Text(
            col['label'] as String,
            textAlign: col['align'] as TextAlign?,
            style: context.bodySmall
                .withColor(Colors.white)
                .withWeight(FontWeight.w600),
          );

          if (col.containsKey('flex') && col['flex'] == true) {
            return Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4), child: label));
          } else {
            return Container(
              padding: const EdgeInsets.only(right: 4),
              width: col['width'] as double?,
              child: label,
            );
          }
        }).toList(),
      ),
    );
  }
}
