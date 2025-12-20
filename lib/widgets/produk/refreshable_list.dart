import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_button.dart';
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

class LoadMoreRefreshableList<T> extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  // State Loading Awal
  final bool isLoading;
  final Widget? loadingWidget;

  // State Empty
  final String emptyTitle;
  final String emptySubtitle;
  final String? emptyAnimationAsset;
  final Widget? emptyActionWidget;

  // Config List
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget? separatorBuilder;

  // State Load More
  final VoidCallback? onLoadMore;
  final bool canLoadMore;
  final bool isLoadingMore;

  const LoadMoreRefreshableList({
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
    this.onLoadMore,
    this.canLoadMore = false,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Handle Initial Loading
    if (isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    // 2. Handle Empty State
    if (items.isEmpty && !isLoading) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        color: context.primary,
        backgroundColor: context.card,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
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

    // 3. Hitung total item (+1 kalau tombol load more muncul)
    final bool showLoadMore = canLoadMore || isLoadingMore;
    final int totalCount = items.length + (showLoadMore ? 1 : 0);

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.primary,
      backgroundColor: context.card,
      child: ListView.builder(
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        padding: padding,
        itemCount: totalCount,
        itemBuilder: (context, index) {
          // Render Item Data
          if (index < items.length) {
            return itemBuilder(context, items[index], index);
          }

          // Render Tombol Load More / Loading Bawah
          return _buildLoadMoreIndicator(context);
        },
      ),
    );
  }

  Widget _buildLoadMoreIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: isLoadingMore
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : CustomButton(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(horizontal: 15),
                onPressed: onLoadMore,
                text: "Muat Lebih Banyak",
                variant: ButtonVariant.primary,
              ),
      ),
    );
  }
}

/// Versi Sliver buat Load More (Dipake di dalam CustomScrollView)
class SliverLoadMoreList<T> extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool isLoading;
  final Widget? loadingWidget;
  final String emptyTitle;
  final String emptySubtitle;

  // State Load More
  final VoidCallback? onLoadMore;
  final bool canLoadMore;
  final bool isLoadingMore;

  const SliverLoadMoreList({
    super.key,
    required this.onRefresh,
    required this.items,
    required this.itemBuilder,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyTitle = 'Data tidak ditemukan',
    this.emptySubtitle = 'Tarik ke bawah untuk refresh',
    this.onLoadMore,
    this.canLoadMore = false,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child:
            loadingWidget ?? const Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(title: emptyTitle, subtitle: emptySubtitle),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        // List Item
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => itemBuilder(context, items[index], index),
            childCount: items.length,
          ),
        ),

        // Tombol Load More di Bawah
        if (canLoadMore || isLoadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Center(
                child: isLoadingMore
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : CustomButton(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        onPressed: onLoadMore,
                        text: "Muat Lebih Banyak",
                        variant: ButtonVariant.primary,
                      ),
              ),
            ),
          ),

        // Spacer Bawah biar gak mepet
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
