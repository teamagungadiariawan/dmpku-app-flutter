import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'menu_button.dart';

class IsiUlangSection extends StatelessWidget {
  final List<MenuData> menus;
  final ValueChanged<String> onMenuTap;

  const IsiUlangSection({
    super.key,
    required this.menus,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Isi Ulang', style: context.labelMedium),
          Text(
            'Isi Ulang Produk Digital sesuai kebutuhan Anda',
            style: context.bodySmall,
          ),
          const Gap(10),
          GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
              childAspectRatio: 0.87,
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
          const Gap(10),
        ],
      ),
    );
  }
}