import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemMutasiStokShimmer extends StatelessWidget {
  final bool isOdd;

  const ItemMutasiStokShimmer({super.key, required this.isOdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ikutin logic warna selang-seling biar persis aslinya
      color: isOdd ? context.secondary : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.mutedForeground.withOpacity(0.1),
        child: Row(
          children: [
            // 1. Tanggal & Jam (Width: 70)
            SizedBox(
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 40,
                    height: 10,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Keterangan (Expanded)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 12,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 12,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 40,
                    margin: const EdgeInsets.only(right: 8),
                    height: 12,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              )
            ),

            // 3. Potongan (Width: 60)
            Container(
              width: 60,
              height: 12,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // 4. Stok Akhir (Width: 50)
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
      ),
    );
  }
}

class ItemMutasiStokListShimmer extends StatelessWidget {
  final int itemCount;

  const ItemMutasiStokListShimmer({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        // Kirim isOdd berdasarkan index biar selang-seling warnanya tetep kelihatan
        return ItemMutasiStokShimmer(isOdd: index % 2 != 0);
      },
    );
  }
}
