import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PilihProductPpobDialog<B extends BlocBase<S>, S> extends StatefulWidget {
  final String title;
  final String subtitle;

  // Data static (opsional jika tidak pakai selector)
  final List<ProductModel> items;

  // Callback saat item dipilih
  final Function(ProductModel)? onSelected;

  // Callback refresh (misal: panggil API fetchProducts)
  final Future<void> Function()? onRefresh;

  // BLOC / STATE MANAGEMENT
  final B? bloc;
  final bool Function(S state)? isLoadingSelector;
  final List<ProductModel> Function(S state)? itemsSelector;

  const PilihProductPpobDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.items = const [],
    this.onSelected,
    this.onRefresh,
    this.bloc,
    this.isLoadingSelector,
    this.itemsSelector,
  });

  /// Static method untuk menampilkan dialog
  static void show<B extends BlocBase<S>, S>(
    BuildContext context, {
    required String title,
    String subtitle = 'Pilih produk dari daftar berikut',
    List<ProductModel> items = const [],
    Function(ProductModel)? onSelected,
    Future<void> Function()? onRefresh,
    // Bloc Params
    B? bloc,
    bool Function(S state)? isLoadingSelector,
    List<ProductModel> Function(S state)? itemsSelector,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      // Jika bloc ada, wrap dengan BlocProvider.value agar context di dalam sheet mengenali bloc
      builder: (_) => bloc != null
          ? BlocProvider<B>.value(
              value: bloc,
              child: PilihProductPpobDialog<B, S>(
                title: title,
                subtitle: subtitle,
                items: items,
                onSelected: onSelected,
                onRefresh: onRefresh,
                bloc: bloc,
                isLoadingSelector: isLoadingSelector,
                itemsSelector: itemsSelector,
              ),
            )
          : PilihProductPpobDialog(
              title: title,
              subtitle: subtitle,
              items: items,
              onSelected: onSelected,
              onRefresh: onRefresh,
            ),
    );
  }

  @override
  State<PilihProductPpobDialog<B, S>> createState() =>
      _PilihProductPpobDialogState<B, S>();
}

class _PilihProductPpobDialogState<B extends BlocBase<S>, S>
    extends State<PilihProductPpobDialog<B, S>> {
  final TextEditingController _searchController = TextEditingController();

  // List lokal untuk menampung data (baik dari static items atau selector)
  List<ProductModel> _sourceItems = [];
  List<ProductModel> _filteredItems = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi awal dari widget.items
    _sourceItems = widget.items;
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Update list lokal saat data dari parent/bloc berubah
  void _updateSourceItems(List<ProductModel> newItems) {
    if (_sourceItems != newItems) {
      _sourceItems = newItems;
      // Re-apply filter jika sedang search
      _filterItems(_searchController.text);
    }
  }

  void _filterItems(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredItems = _sourceItems;
      } else {
        final queryLower = query.toLowerCase();
        _filteredItems = _sourceItems.where((item) {
          final nameMatch = item.namaproduk.toLowerCase().contains(queryLower);
          final codeMatch = item.kodeproduk.toLowerCase().contains(queryLower);
          return nameMatch || codeMatch;
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
        // Wrap body dengan BlocListener untuk update list real-time jika selector ada
        child: widget.bloc != null && widget.itemsSelector != null
            ? BlocListener<B, S>(
                listener: (context, state) {
                  final newItems = widget.itemsSelector!(state);
                  _updateSourceItems(newItems);
                },
                child: _buildContent(context),
              )
            : _buildContent(context),
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

  /// Membungkus RefreshableList dengan BlocSelector untuk Loading State
  Widget _buildListWithBlocState(BuildContext context) {
    if (widget.bloc != null && widget.isLoadingSelector != null) {
      return BlocSelector<B, S, bool>(
        selector: widget.isLoadingSelector!,
        builder: (context, isLoading) {
          return _buildRefreshableList(context, isLoading);
        },
      );
    }
    // Default jika tidak ada bloc loading selector
    return _buildRefreshableList(context, false);
  }

  Widget _buildRefreshableList(BuildContext context, bool isLoading) {
    return RefreshableList<ProductModel>(
      isLoading: isLoading,
      loadingWidget: CardProviderListShimmer(itemCount: 6),
      onRefresh:
          widget.onRefresh ??
          () async {
            // Default dummy refresh jika tidak ada callback
            await Future.delayed(const Duration(milliseconds: 500));
            _searchController.clear();
            _filterItems('');
          },
      items: _filteredItems,
      emptyTitle: 'Data tidak ditemukan',
      emptySubtitle: _isSearching
          ? 'Tidak ada produk dengan kata kunci "${_searchController.text}"'
          : 'Daftar produk kosong',
      padding: const EdgeInsets.only(bottom: 10),
      itemBuilder: (context, item, index) {
        return CardProvider(
          title: item.namaproduk,
          subtitle: item.deskripsiproduk,
          imageUrl: item.imgproduk,
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
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? stone[700] : stone[100],
                shape: BoxShape.circle,
              ),
              child: Icon(MdiIcons.listBoxOutline, color: context.primary),
            ),
            const Gap(10),
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
                  Text(widget.subtitle, style: context.bodyMedium),
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
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari nama atau kode...',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _searchController.clear();
                          _filterItems('');
                        },
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }
}
