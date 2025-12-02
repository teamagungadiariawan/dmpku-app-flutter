import 'package:dmpku/core/helpers/produk_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardProductVoucher extends StatelessWidget {
  final dynamic product;

  const CardProductVoucher({required this.product});

  @override
  Widget build(BuildContext context) {
    final formattedDesc = getInfoProduk(product.deskripsiproduk);

    return Card(
      semanticContainer: false,
      borderOnForeground: false,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.primary, width: 1),
      ),
      child: Stack(
        children: [
          _buildPriceBadge(context),
          _buildContent(context, formattedDesc),
        ],
      ),
    );
  }

  Widget _buildPriceBadge(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        constraints: const BoxConstraints(minWidth: 100),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: context.primary,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(7),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Text(
          ToRupiah(product.hargaproduk.toString()),
          textAlign: TextAlign.center,
          style: context.labelLarge
              .withColor(context.primaryForeground)
              .withWeight(FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReformattedDesc formattedDesc) {
    return Padding(
      padding: paddingCard,
      child: Row(
        children: [
          _buildProductImage(context),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 120),
                  child: Text(
                    product.namaproduk,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelLarge,
                  ),
                ),
                _buildDescription(context, formattedDesc),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.muted,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.network(
        product.imgproduk,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(
          Icons.image_not_supported,
          size: 24,
          color: context.mutedForeground,
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, ReformattedDesc desc) {
    if (!desc.format) {
      return Text(
        desc.info,
        style: context.bodyMedium.withWeight(FontWeight.w400),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final pair in desc.keyValuePairs) ...[
          Row(
            children: [
              Icon(pair.type.icon, size: 12),
              const Gap(6),
              Expanded(
                child: Text(
                  pair.value,
                  style: context.bodyExtraSmall.withWeight(FontWeight.w600),
                ),
              ),
            ],
          ),
          const Gap(1),
        ],
      ],
    );
  }
}
