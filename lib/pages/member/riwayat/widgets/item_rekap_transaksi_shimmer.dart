import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemRekapTransaksiShimmer extends StatelessWidget {
  final bool isOdd;

  const ItemRekapTransaksiShimmer({
    super.key,
    required this.isOdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Warna background ngikutin logic zebra row biar konsisten
      color: isOdd ? context.secondary : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.mutedForeground.withOpacity(0.1),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // 1. Placeholder No (Width: 30)
            Container(
              width: 30,
              height: 12,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 2. Placeholder Produk (Expanded)
            Expanded(
              child: Container(
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: context.muted,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // 3. Placeholder Jml Trx (Width: 80)
            Container(
              width: 100,
              height: 12,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // 4. Placeholder Total (Width: 80)
            Container(
              width: 100,
              height: 12,
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

class ItemRekapTransaksiListShimmer extends StatelessWidget {
  final int itemCount;

  const ItemRekapTransaksiListShimmer({
    super.key,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        // Biar selang-seling warna barisnya dapet
        return ItemRekapTransaksiShimmer(isOdd: index % 2 != 0);
      },
    );
  }
}