import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CardHistoryPenjualanShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const CardHistoryPenjualanShimmer({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: context.muted,
          highlightColor: context.mutedForeground.withValues(alpha: 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title placeholder
                        Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            color: context.muted,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Gap(6),
                        // Subtitle placeholder
                        Container(
                          width: 150,
                          height: 12,
                          decoration: BoxDecoration(
                            color: context.muted,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  // Amount placeholder
                  Container(
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  // Time placeholder
                  Container(
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const Gap(8),
                  // Status placeholder
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: context.muted,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Gap(4),
                      Container(
                        width: 50,
                        height: 12,
                        decoration: BoxDecoration(
                          color: context.muted,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHistoryPenjualanListShimmer extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry? itemMargin;

  const CardHistoryPenjualanListShimmer({
    super.key,
    this.itemCount = 5,
    this.itemMargin,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        return CardHistoryPenjualanShimmer(margin: itemMargin);
      },
    );
  }
}
