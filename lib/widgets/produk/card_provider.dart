import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class CardProvider extends StatelessWidget {
  final String? imageUrl;
  final String? imageAsset;
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedGanti;
  final bool isGanti;
  final bool isImgLocal;
  final bool isGangguan;
  final EdgeInsetsGeometry? margin;

  const CardProvider({
    super.key,
    this.imageUrl,
    this.imageAsset,
    required this.title,
    required this.subtitle,
    this.onPressed,
    this.onPressedGanti,
    this.isGanti = false,
    this.isImgLocal = false,
    this.isGangguan = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [_buildCard(context), if (isGangguan) _buildOverlay(context)],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return InkWell(
      onTap: isGangguan ? null : onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: paddingCard,
        decoration: BoxDecoration(
          color: isGangguan ? context.muted : context.card,
          border: Border.all(color: context.border, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _buildImageContainer(context),
            const SizedBox(width: 12),
            _buildTextSection(context),
            const SizedBox(width: 12),
            _buildTrailingWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.muted,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _buildImage(context),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (isImgLocal && imageAsset != null) {
      return Image.asset(
        imageAsset!,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.image_not_supported,
            size: 24,
            color: context.mutedForeground,
          );
        },
      );
    }
    return Icon(Icons.image, size: 24, color: context.mutedForeground);
  }

  Widget _buildTextSection(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: isGanti ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: context.labelLarge,
          ),
          Text(
            subtitle,
            style: context.bodySmall.copyWith(color: context.mutedForeground),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingWidget(BuildContext context) {
    if (isGangguan) {
      return _buildGangguanBadge(context);
    }

    if (isGanti) {
      return _buildGantiButton(context);
    }

    return Icon(MdiIcons.chevronRight, size: 24, color: context.primary);
  }

  Widget _buildGantiButton(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 29,
      child: ElevatedButton(
        onPressed: onPressedGanti,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primary,
          foregroundColor: context.primaryForeground,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text('Ganti', style: context.buttonMedium),
      ),
    );
  }

  Widget _buildGangguanBadge(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.destructive,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Gangguan',
          style: context.bodySmall.copyWith(
            color: context.destructiveForeground,
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: context.border.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
