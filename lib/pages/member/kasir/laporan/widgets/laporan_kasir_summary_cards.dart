import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class LaporanKasirSummaryCards extends StatelessWidget {
  final int totalModal;
  final int totalPenjualan;
  final int totalLaba;

  const LaporanKasirSummaryCards({
    super.key,
    required this.totalModal,
    required this.totalPenjualan,
    required this.totalLaba,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingPage,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              context,
              icon: MdiIcons.cashMinus,
              label: "Modal",
              value: ToCurrency(totalModal.toString()),
              color: context.destructive,
            ),
          ),
          const Gap(10),
          Expanded(
            child: _buildSummaryCard(
              context,
              icon: MdiIcons.cashMultiple,
              label: "Penjualan",
              value: ToCurrency(totalPenjualan.toString()),
              color: context.primary,
            ),
          ),
          const Gap(10),
          Expanded(
            child: _buildSummaryCard(
              context,
              icon: MdiIcons.trendingUp,
              label: "Laba",
              value: ToCurrency(totalLaba.toString()),
              color: context.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: color),
            const Gap(6),
            Text(
              label,
              style: context.bodySmall.withColor(context.mutedForeground),
            ),
            const Gap(2),
            Text(
              value,
              style: context.bodyMedium.withWeight(FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
