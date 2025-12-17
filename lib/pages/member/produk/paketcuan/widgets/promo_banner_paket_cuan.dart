import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class PromoBannerPaketCuan extends StatelessWidget {
  const PromoBannerPaketCuan({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna utama request lo
    var mainColor = context.primary;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // Ganti solid color jadi gradient
        gradient: LinearGradient(
          colors: [
            mainColor, // Warna request lo (Start)
            // Gue gelapin dikit variannya biar gradasinya kelihatan elegan
            const Color(0xFF267E7F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [

        ],
      ),
      child: Stack(
        children: [
          // Background Icon Placeholder (tetap ada biar gak sepi)
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Opacity(
                opacity: 0.15,
                child: Transform.translate(
                  offset: const Offset(-20, 30),
                  child: const Icon(
                    Icons.card_giftcard,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: paddingCard.copyWith(top: 12, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Chip "Hot Promo"
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("🔥", style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 6),
                            Text(
                              "Hot Promo",
                              style: context.bodyMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(16),

                      const Text(
                        "Paket Cuan Spesial Hari Ini!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),

                      Text(
                        "Paket Murah ALL Operator, Dapatkan Keuntungan Maksimal!",
                        style: context.bodySmall
                            .withColor(Colors.white)
                            .withWeight(FontWeight.w500),
                      ),
                      Gap(8),
                    ],
                  ),
                ),

                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),

          // Gambar 3D Overlay
          Positioned(
            right: 10,
            child: Lottie.asset(
              Assets.animations.paketCuan,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
