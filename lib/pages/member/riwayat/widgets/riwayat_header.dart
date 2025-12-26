import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/tab/custom_tab_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RiwayatHeader extends StatelessWidget {
  final CustomTabRiwayatController tabController;
  final ValueChanged<int> onTabChanged;

  const RiwayatHeader({
    super.key,
    required this.tabController,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.primary,
        image: DecorationImage(
          image: Assets.img.bgPattern.provider(),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomAppBar(
            title: 'Riwayat Transaksi',
            showBackButton: false,
            backgroundColor: Colors.transparent,
          ),
          const Gap(10),
          CustomTabRiwayat(
            tabs: const [
              "Hari Ini",
              "Kemarin",
              "Mutasi Stok",
              "Rekap Transaksi"
            ],
            controller: tabController,
            onChange: onTabChanged,
          ),
        ],
      ),
    );
  }
}
