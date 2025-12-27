import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardPaketCuanShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const CardPaketCuanShimmer({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: context.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: context.muted,
        highlightColor: context.muted.withValues(alpha: 0.5),
        child: Row(
          children: [
            _buildIconSection(context),
            _buildStatusIndicator(context),
            const SizedBox(width: 8),
            _buildTextSection(context),
            const SizedBox(width: 6),
            _buildButton(context),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: context.muted,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: context.background,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-5, 0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: context.muted),
      ),
    );
  }

  Widget _buildTextSection(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.muted,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 12,
            width: 80,
            decoration: BoxDecoration(
              color: context.muted,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      height: 32,
      width: 80,
      decoration: BoxDecoration(
        color: context.muted,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// Shimmer untuk multiple cards dalam list
class CardPaketCuanListShimmer extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry? itemMargin;

  const CardPaketCuanListShimmer({
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
        return CardPaketCuanShimmer(margin: itemMargin);
      },
    );
  }
}
