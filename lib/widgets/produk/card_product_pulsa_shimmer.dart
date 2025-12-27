import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardProductPulsaShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const CardProductPulsaShimmer({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      semanticContainer: false,
      borderOnForeground: false,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.border, width: 1),
      ),
      color: context.card,
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.mutedForeground.withValues(alpha: 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          // Icon placeholder
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: context.muted,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 2),
                          // Title text placeholder
                          Expanded(
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: context.muted,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Price badge placeholder
                  Container(
                    width: 100,
                    height: 28,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Divider
            Container(height: 0.5, color: context.border),
            const SizedBox(height: 5),
            // Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // Info row 1
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: context.muted,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: context.muted,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Info row 2
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: context.muted,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        height: 12,
                        width: 100,
                        decoration: BoxDecoration(
                          color: context.muted,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

// Shimmer untuk multiple cards dalam grid
class CardProductPulsaListShimmer extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry? itemMargin;

  const CardProductPulsaListShimmer({
    super.key,
    this.itemCount = 3,
    this.itemMargin,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return CardProductPulsaShimmer(margin: itemMargin);
      },
    );
  }
}