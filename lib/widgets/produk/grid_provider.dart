import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GridProvider extends StatelessWidget {
  final String? imageUrl;
  final String? imageAsset;
  final String title;
  final VoidCallback? onPressed;
  final bool isImgLocal;
  final bool isSelected;
  final double imageSize;
  final double width;

  const GridProvider({
    super.key,
    this.imageUrl,
    this.imageAsset,
    required this.title,
    this.onPressed,
    this.isImgLocal = false,
    this.isSelected = false,
    this.imageSize = 70,
    this.width = 90,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(context),
            Gap(8),
            _buildTitle(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: context.muted,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildImageContent(context),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    if (isImgLocal && imageAsset != null) {
      return Image.asset(
        imageAsset!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.image_not_supported,
              size: 24,
              color: context.mutedForeground,
            ),
          );
        },
      );
    }
    return Center(
      child: Icon(Icons.image, size: 24, color: context.mutedForeground),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: context.bodySmall.copyWith(
        color: isSelected ? context.primary : context.foreground,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
