import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'menu_button.dart';
import 'promo_card.dart';
import 'sales_feature_card.dart';

class DashboardHeader extends StatelessWidget {
  final List<MenuData> salesMenus;
  final VoidCallback onPromoTap;
  final ValueChanged<String> onMenuTap;

  static const double headerHeight = 208.0;

  const DashboardHeader({
    super.key,
    required this.salesMenus,
    required this.onPromoTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              height: headerHeight,
              decoration: BoxDecoration(
                color: context.primary,
                image: DecorationImage(
                  image: Assets.img.bgPattern.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 75),
          ],
        ),
        Positioned(
          top: kToolbarHeight + 32,
          left: 12,
          right: 12,
          child: Column(
            children: [
              PromoCard(onPressed: onPromoTap),
              SalesFeatureCard(menus: salesMenus, onMenuTap: onMenuTap),
            ],
          ),
        ),
      ],
    );
  }
}