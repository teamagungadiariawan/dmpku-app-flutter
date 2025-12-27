import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardProduct extends StatelessWidget {
  final String title;
  final String subtitle;
  final String harga;
  final bool selected;
  final bool isGangguan;
  final VoidCallback onPress;

  const CardProduct({
    super.key,
    required this.title,
    required this.subtitle,
    required this.harga,
    required this.selected,
    required this.isGangguan,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      borderOnForeground: false,
      clipBehavior: Clip.antiAlias,
      // Tambahkan ini agar child mengikuti border radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected ? context.primary : context.border,
          width: 1,
        ),
      ),
      color: _getBackgroundColor(context),
      // Ganti Colors.yellow dengan ini
      child: Stack(
        children: [
          _buildCard(context),
          if (isGangguan) ...[_buildOverlay(context)],
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return InkWell(
      onTap: isGangguan ? null : onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeaderSection(context),
          Container(
            height: 0.5,
            color: selected ? context.primary : context.border,
          ),
          Gap(5),
          _buildInfoSection(context),
          Gap(5),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.layers,
                      size: 16,
                      color: context.mutedForeground,
                    ),
                    const SizedBox(width: 2),
                    Expanded(child: Text(title, style: context.labelLarge)),
                  ],
                ),
              ),
            ),
          ),

          // Price Section
          Container(
            constraints: BoxConstraints(minWidth: 100),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(7),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Text(
              ToRupiah(harga),
              textAlign: TextAlign.center,
              style: context.labelLarge
                  .withColor(context.primaryForeground)
                  .withWeight(FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(subtitle, style: context.bodyMedium.withWeight(FontWeight.w400)),
        ],
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (selected) {
      return context.primary.withValues(alpha: 0.3);
    }
    if (isGangguan) {
      return context.muted;
    }
    return context.card;
  }

  Widget _buildOverlay(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: context.border.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
