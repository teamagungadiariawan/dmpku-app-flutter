import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class SalesFeatureCard extends StatelessWidget {
  final List<MenuData> menus;
  final ValueChanged<String> onMenuTap;

  const SalesFeatureCard({
    super.key,
    required this.menus,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fitur Penjualan', style: context.labelMedium),
            Text(
              'Fitur pelengkap transaksi penjualan anda',
              style: context.captionMedium,
            ),
            Gap(5),
            GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 2),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 0,
                childAspectRatio: 1.1,
              ),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return MenuButton(
                  title: menu.title,
                  icon: menu.icon,
                  onTap: () => onMenuTap(menu.title),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}