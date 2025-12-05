import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class IsiUlangSection extends StatelessWidget {
  final List<MenuData> menus;

  const IsiUlangSection({
    super.key,
    required this.menus,
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
                onTap: () => {
                  if (menu.onTap != null) {menu.onTap!()}
                },
              );
            },
          ),
          const Gap(10),
        ],
      ),
    );
  }
}