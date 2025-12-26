import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardProviderShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const CardProviderShimmer({
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: context.card,
          border: Border.all(color: context.border, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Shimmer.fromColors(
          baseColor: context.muted,
          highlightColor: context.mutedForeground.withOpacity(0.1),
          child: Row(
            children: [
              // Image placeholder
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.muted,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              // Text section placeholder
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title placeholder
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.muted,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle placeholder
                    Container(
                      height: 14,
                      width: 120,
                      decoration: BoxDecoration(
                        color: context.muted,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Trailing icon placeholder
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: context.muted,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alternative: Shimmer untuk multiple cards
class CardProviderListShimmer extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry? itemMargin;

  const CardProviderListShimmer({
    super.key,
    this.itemCount = 3,
    this.itemMargin,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return CardProviderShimmer(margin: itemMargin);
      },
    );
  }
}