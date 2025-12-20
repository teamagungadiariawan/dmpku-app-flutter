import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CardRiwayatTransaksiShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const CardRiwayatTransaksiShimmer({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    // Container luar ngikutin style CardRiwayatTransaksi biar konsisten
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border, width: 0.5),
      ),
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.mutedForeground.withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Placeholder Image (Kiri)
            Container(
              width: 42, // 24 icon + 16 padding total (approx)
              height: 42,
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Gap(12),

            // 2. Placeholder Main Info (Tengah)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title (Nama Produk)
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: context.muted,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(6),
                  // Subtitle (Tujuan) - dibikin lebih pendek dikit biar variatif
                  Container(
                    width: 120,
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

            // 3. Placeholder Trailing (Kanan: Harga & Status)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Harga
                Container(
                  width: 80,
                  height: 14,
                  decoration: BoxDecoration(
                    color: context.muted,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Gap(8), // Jarak ke baris status

                // Row Status (Jam + Badge)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon Jam kecil
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: context.muted,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    // Jam Text
                    Container(
                      width: 30,
                      height: 10,
                      decoration: BoxDecoration(
                        color: context.muted,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const Gap(8),
                    // Badge Status
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: context.muted,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardRiwayatTransaksiListShimmer extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry? itemMargin;

  const CardRiwayatTransaksiListShimmer({
    super.key,
    this.itemCount = 5, // Default dibanyakin dikit biar menuhin layar
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
        return CardRiwayatTransaksiShimmer(margin: itemMargin);
      },
    );
  }
}