import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class GridProviderShimmer extends StatelessWidget {
  final double imageSize;
  final double width;

  const GridProviderShimmer({super.key, this.imageSize = 70, this.width = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.mutedForeground.withValues(alpha: 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image placeholder
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Gap(8),
            // Title placeholder - line 1
            Container(
              height: 12,
              width: width - 16,
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer untuk horizontal list of vertical cards
class GridProviderVerticalListShimmer extends StatelessWidget {
  final int itemCount;
  final double imageSize;
  final double itemWidth;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  const GridProviderVerticalListShimmer({
    super.key,
    this.itemCount = 4,
    this.imageSize = 70,
    this.itemWidth = 90,
    this.spacing = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageSize + 60, // image + padding + text
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(width: spacing),
        itemBuilder: (context, index) {
          return GridProviderShimmer(imageSize: imageSize, width: itemWidth);
        },
      ),
    );
  }
}

/// Shimmer untuk grid of vertical cards
class GridProviderVerticalGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double imageSize;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double aspectRatio;
  final EdgeInsetsGeometry? padding;

  const GridProviderVerticalGridShimmer({
    super.key,
    this.itemCount = 8,
    this.crossAxisCount = 4,
    this.imageSize = 70,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.aspectRatio = 0.75,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: aspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return GridProviderShimmer(imageSize: imageSize);
      },
    );
  }
}
