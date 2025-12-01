import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/produk/empty_state_widget.dart';
import 'package:flutter/material.dart';

class RefreshableList<T> extends StatelessWidget {
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
  final Widget? separatorBuilder;

  const RefreshableList({
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
    this.separatorBuilder,
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
      child: separatorBuilder != null
          ? ListView.separated(
              physics: physics ?? const AlwaysScrollableScrollPhysics(),
              padding: padding,
              itemCount: items.length,
              separatorBuilder: (_, __) => separatorBuilder!,
              itemBuilder: (context, index) =>
                  itemBuilder(context, items[index], index),
            )
          : ListView.builder(
              physics: physics ?? const AlwaysScrollableScrollPhysics(),
              padding: padding,
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  itemBuilder(context, items[index], index),
            ),
    );
  }
}

/// Variant dengan Sliver untuk digunakan dalam CustomScrollView
class SliverRefreshableList<T> extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool isLoading;
  final Widget? loadingWidget;
  final String emptyTitle;
  final String emptySubtitle;

  const SliverRefreshableList({
    super.key,
    required this.onRefresh,
    required this.items,
    required this.itemBuilder,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyTitle = 'Data tidak ditemukan',
    this.emptySubtitle = 'Tarik ke bawah untuk refresh',
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SliverFillRemaining(
        child:
            loadingWidget ?? const Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        child: EmptyStateWidget(title: emptyTitle, subtitle: emptySubtitle),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => itemBuilder(context, items[index], index),
        childCount: items.length,
      ),
    );
  }
}
