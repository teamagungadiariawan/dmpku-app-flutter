import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CardMutasiDepositShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const CardMutasiDepositShimmer({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.border),
      ),
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.mutedForeground.withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Gap(12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(6),
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 80,
                  height: 14,
                  decoration: BoxDecoration(
                    color: context.muted,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Gap(8),
                Container(
                  width: 60,
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
      ),
    );
  }
}

class CardMutasiDepositListShimmer extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry? itemMargin;

  const CardMutasiDepositListShimmer({
    super.key,
    this.itemCount = 6,
    this.itemMargin,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CardMutasiDepositShimmer(margin: itemMargin);
      },
    );
  }
}
