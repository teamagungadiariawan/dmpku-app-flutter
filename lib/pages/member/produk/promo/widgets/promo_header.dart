import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/promo_response.dart';
import 'package:dmpku/widgets/tab/custom_tab_riwayat.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class PromoHeader extends StatefulWidget {
  final List<PromoProdukModel> promoCategories;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final bool isLoading;

  const PromoHeader({
    super.key,
    required this.promoCategories,
    required this.selectedIndex,
    required this.onTabChanged,
    this.isLoading = false,
  });

  @override
  State<PromoHeader> createState() => _PromoHeaderState();
}

class _PromoHeaderState extends State<PromoHeader> {
  late CustomTabRiwayatController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = CustomTabRiwayatController();
  }

  @override
  void didUpdateWidget(PromoHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update tab controller when selected index changes from parent
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.jumpToTab(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract tab names from promo categories
    final tabNames = widget.promoCategories
        .map((category) => category.namakategoripromo)
        .toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: context.primary),
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isLoading)
            _buildShimmerTabs()
          else if (tabNames.isNotEmpty)
            CustomTabRiwayat(
              tabs: tabNames,
              controller: _tabController,
              onChange: widget.onTabChanged,
            )
          else
            const SizedBox(height: 48), // Placeholder when no tabs
        ],
      ),
    );
  }

  Widget _buildShimmerTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Shimmer.fromColors(
              baseColor: Colors.white.withValues(alpha: 0.2),
              highlightColor: Colors.white.withValues(alpha: 0.4),
              child: Container(
                width: 100,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
