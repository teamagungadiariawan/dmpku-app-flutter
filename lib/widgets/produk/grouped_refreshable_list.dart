import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/produk/empty_state_widget.dart';
import 'package:flutter/material.dart';

class GroupedRefreshableList<G, I> extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<G> groups;
  final List<I> Function(G group) getItems;
  final Widget Function(BuildContext context, G group) groupHeaderBuilder;
  final Widget Function(BuildContext context, I item, int index) itemBuilder;
  final bool isLoading;
  final Widget? loadingWidget;
  final String emptyTitle;
  final String emptySubtitle;
  final String? emptyAnimationAsset;
  final VoidCallback? onLoadMore;
  final bool canLoadMore;
  final bool isLoadingMore;
  final EdgeInsetsGeometry? padding;

  // CATATAN: variable groupHeaderHeight udah DIHAPUS karena gak perlu lagi!

  const GroupedRefreshableList({
    super.key,
    required this.onRefresh,
    required this.groups,
    required this.getItems,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyTitle = 'Data tidak ditemukan',
    this.emptySubtitle = 'Tarik ke bawah untuk refresh',
    this.emptyAnimationAsset,
    this.onLoadMore,
    this.canLoadMore = false,
    this.isLoadingMore = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Handle Initial Loading
    if (isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    // 2. Handle Empty State
    if (groups.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        color: context.primary,
        backgroundColor: context.card,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: EmptyStateWidget(
                  title: emptyTitle,
                  subtitle: emptySubtitle,
                  animationAsset:
                  emptyAnimationAsset ?? Assets.animations.noData,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 3. Handle Grouped List Data (The Modern Way)
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.primary,
      backgroundColor: context.card,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [

          // Loop Group pake SliverMainAxisGroup
          for (var group in groups)
            SliverMainAxisGroup(
              slivers: [
                // A. Header yang Sticky (Gak butuh delegate!)
                PinnedHeaderSliver(
                  child: groupHeaderBuilder(context, group),
                ),

                // B. List Item
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final items = getItems(group);
                      return padding != null
                          ? Padding(
                        padding: padding!,
                        child: itemBuilder(context, items[index], index),
                      )
                          : itemBuilder(context, items[index], index);
                    },
                    childCount: getItems(group).length,
                  ),
                ),
              ],
            ),

          // 4. Tombol Load More
          if (canLoadMore || isLoadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: isLoadingMore
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : OutlinedButton.icon(
                    onPressed: onLoadMore,
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text("Muat Lebih Banyak"),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(color: context.primary),
                    ),
                  ),
                ),
              ),
            ),

          // Spacer bawah
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}