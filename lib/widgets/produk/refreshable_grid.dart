import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'empty_state_widget.dart';

class RefreshableGrid<T> extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool isLoading;
  final Widget? loadingWidget;
  final String emptyTitle;
  final String emptySubtitle;
  final String? emptyAnimationAsset;
  final Widget? emptyActionWidget;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  // Grid specific
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final double? mainAxisExtent;

  const RefreshableGrid({
    super.key,
    required this.onRefresh,
    required this.items,
    required this.itemBuilder,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyTitle = 'Data tidak ditemukan',
    this.emptySubtitle = 'Tarik ke bawah untuk refresh',
    this.emptyAnimationAsset,
    this.emptyActionWidget,
    this.physics,
    this.padding,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty && !isLoading) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        color: context.primary,
        backgroundColor: context.card,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: EmptyStateWidget(
                title: emptyTitle,
                subtitle: emptySubtitle,
                animationAsset: emptyAnimationAsset ?? Assets.animations.noData,
                actionWidget: emptyActionWidget,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.primary,
      backgroundColor: context.card,
      child: GridView.builder(
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        padding: padding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
          mainAxisExtent: mainAxisExtent,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) =>
            itemBuilder(context, items[index], index),
      ),
    );
  }
}
