import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PilihPelangganDialog<B extends BlocBase<S>, S> extends StatefulWidget {
  final String title;
  final String subtitle;

  final List<PelangganModel> items;
  final Function(PelangganModel)? onSelected;
  final Future<void> Function()? onRefresh;

  // BLOC / STATE MANAGEMENT
  final B? bloc;
  final bool Function(S state)? isLoadingSelector;

  const PilihPelangganDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.items = const [],
    this.onSelected,
    this.onRefresh,
    this.bloc,
    this.isLoadingSelector,
  });

  static void show<B extends BlocBase<S>, S>(
    BuildContext context, {
    required String title,
    String subtitle = 'Pilih pelanggan dari daftar berikut',
    List<PelangganModel> items = const [],
    Function(PelangganModel)? onSelected,
    Future<void> Function()? onRefresh,
    // Bloc Params
    B? bloc,
    bool Function(S state)? isLoadingSelector,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => bloc != null
          ? BlocProvider<B>.value(
              value: bloc,
              child: PilihPelangganDialog<B, S>(
                title: title,
                subtitle: subtitle,
                items: items,
                onSelected: onSelected,
                onRefresh: onRefresh,
                bloc: bloc,
                isLoadingSelector: isLoadingSelector,
              ),
            )
          : PilihPelangganDialog(
              title: title,
              subtitle: subtitle,
              items: items,
              onSelected: onSelected,
              onRefresh: onRefresh,
            ),
    );
  }

  @override
  State<PilihPelangganDialog<B, S>> createState() =>
      _PilihPelangganDialogState<B, S>();
}

class _PilihPelangganDialogState<B extends BlocBase<S>, S>
    extends State<PilihPelangganDialog<B, S>> {
  final TextEditingController _searchController = TextEditingController();
  List<PelangganModel> _filteredItems = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant PilihPelangganDialog<B, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _filterItems(_searchController.text);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        final queryLower = query.toLowerCase();
        _filteredItems = widget.items.where((item) {
          final nameMatch = item.namapelanggan.toLowerCase().contains(
            queryLower,
          );
          final hpMatch = item.nohppelanggan.contains(queryLower);
          return nameMatch || hpMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const TopDividerSheet(),
        const Gap(15),
        _buildHeader(context),
        const Gap(10),
        _buildSearchField(context),
        const Gap(10),
        Expanded(child: _buildListWithBlocState(context)),
        const Gap(10),
        CustomButton(
          height: 40,
          width: double.infinity,
          padding: EdgeInsets.zero,
          variant: ButtonVariant.destructive,
          text: "TUTUP",
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildListWithBlocState(BuildContext context) {
    if (widget.bloc != null && widget.isLoadingSelector != null) {
      return BlocSelector<B, S, bool>(
        selector: widget.isLoadingSelector!,
        builder: (context, isLoading) {
          return _buildRefreshableList(context, isLoading);
        },
      );
    }
    return _buildRefreshableList(context, false);
  }

  Widget _buildRefreshableList(BuildContext context, bool isLoading) {
    return RefreshableList<PelangganModel>(
      isLoading: isLoading,
      loadingWidget: CardProviderListShimmer(itemCount: 6),
      onRefresh:
          widget.onRefresh ??
          () async {
            await Future.delayed(const Duration(milliseconds: 500));
            _searchController.clear();
            _filterItems('');
          },
      items: _filteredItems,
      emptyTitle: 'Data tidak ditemukan',
      emptySubtitle: _isSearching
          ? 'Tidak ada pelanggan dengan kata kunci "${_searchController.text}"'
          : 'Daftar pelanggan kosong',
      padding: const EdgeInsets.only(bottom: 10),
      itemBuilder: (context, item, index) {
        return CardProvider(
          title: item.namapelanggan,
          subtitle: item.nohppelanggan,
          showImage: false,
          onPressed: () {
            widget.onSelected?.call(item);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.border),
      ),
      color: context.card,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey[800] : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(MdiIcons.accountBoxOutline, color: context.primary),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: context.bodySmall.copyWith(
                      color: context.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              style: context.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari nama atau no. HP...',
                hintStyle: context.bodyMedium.copyWith(
                  color: context.mutedForeground,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filterItems('');
                        },
                        child: Icon(
                          MdiIcons.closeCircle,
                          size: 18,
                          color: context.mutedForeground,
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 20,
                  minWidth: 20,
                ),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }
}
