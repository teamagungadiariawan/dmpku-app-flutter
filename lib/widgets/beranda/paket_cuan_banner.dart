import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class PaketCuanBanner extends StatelessWidget {
  final VoidCallback onTap;

  const PaketCuanBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          _buildDecorativeCircle(),
          _buildContent(context),
          _buildAnimation(),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle() {
    return Positioned(
      top: -12,
      left: -12,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context),
                Text(
                  "Dapatkan keuntungan lebih dengan paket cuan",
                  style: context.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(15),
                CustomButton(
                  height: 25,
                  foregroundColor: context.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  text: "Beli disini",
                  variant: ButtonVariant.secondary,
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 120, width: 110),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        const Icon(MdiIcons.starShootingOutline, color: Colors.white),
        const Gap(5),
        Text(
          "Paket Cuan",
          style: context.sectionTitle.copyWith(color: Colors.white),
        ),
        const Gap(5),
        const Icon(MdiIcons.starShootingOutline, color: Colors.white),
      ],
    );
  }

  Widget _buildAnimation() {
    return Positioned(
      bottom: -16,
      right: 10,
      child: Lottie.asset(
        Assets.animations.berandaPaketCuan,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }
}
