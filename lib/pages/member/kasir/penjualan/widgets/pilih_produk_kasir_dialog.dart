import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/pages/member/kasir/penjualan/widgets/tambah_produk_manual_dialog.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PilihProdukKasirDialog extends StatefulWidget {
  const PilihProdukKasirDialog({super.key});

  static void show(BuildContext context) {
    final provider = context.read<KasirProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: provider,
        child: const PilihProdukKasirDialog(),
      ),
    );
  }

  @override
  State<PilihProdukKasirDialog> createState() => _PilihProdukKasirDialogState();
}

class _PilihProdukKasirDialogState extends State<PilihProdukKasirDialog> {
  late final KasirProvider _provider;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _provider = context.read<KasirProvider>();
    // Ensure data is loaded
    _provider.fetchListProduk();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.toLowerCase();
    });
  }

  List<ProdukModel> _filterList(List<ProdukModel> list) {
    if (_searchQuery.isEmpty) return list;
    return list.where((item) {
      final name = item.namaproduk.toLowerCase();
      return name.contains(_searchQuery);
    }).toList();
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
        child: Column(
          children: [
            const TopDividerSheet(),
            const Gap(15),
            _buildHeader(context),
            const Gap(10),
            _buildSearchField(context),
            const Gap(10),
            Expanded(child: _buildList(context)),
            const Gap(10),
            CustomButton(
              height: 40,
              width: double.infinity,
              variant: ButtonVariant.destructive,
              text: "TUTUP",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
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
              child: const Icon(LucideIcons.package),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Produk',
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Tambahkan produk ke keranjang',
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ),
            CustomButton(
              text: "Refresh",
              onPressed: () => _provider.fetchListProduk(),
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              variant: ButtonVariant.border,
              backgroundColor: context.primary.withValues(alpha: 0.1),
              borderColor: context.primary,
              textStyle: context.bodySmall
                  .withColor(context.primary)
                  .withWeight(FontWeight.w500),
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
          Icon(LucideIcons.search, size: 16, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari Nama Produk',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                suffixIcon: _searchController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
              ),
              style: context.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder<KasirProvider, KasirState>(
      builder: (context, state) {
        if (state.apiGetProdukStatus.isLoading) {
          return const CardProviderListShimmer(itemCount: 5);
        }

        if (state.apiGetProdukStatus.isFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.alertCircleOutline,
                  size: 48,
                  color: context.destructive,
                ),
                const Gap(8),
                Text(
                  state.apiGetProdukMessage,
                  style: context.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
                CustomButton(
                  text: "Coba Lagi",
                  onPressed: () => _provider.fetchListProduk(),
                  variant: ButtonVariant.outline,
                  height: 35,
                ),
              ],
            ),
          );
        }

        final filteredList = _filterList(state.listProduk);

        if (filteredList.isEmpty) {
          return EmptyStateWidget(
            title: _searchQuery.isEmpty
                ? 'Belum ada data produk'
                : 'Produk tidak ditemukan',
            subtitle: _searchQuery.isEmpty
                ? 'Tambahkan produk terlebih dahulu'
                : 'Coba kata kunci lain',
            actionWidget: _searchQuery.isEmpty
                ? CustomButton(
                    text: 'Refresh',
                    onPressed: () => _provider.fetchListProduk(),
                    variant: ButtonVariant.outline,
                    height: 35,
                  )
                : null,
          );
        }

        return ListView.separated(
          itemCount: filteredList.length,
          separatorBuilder: (_, __) => Gap(6),
          itemBuilder: (context, index) {
            final item = filteredList[index];

            return Card(
              margin: EdgeInsets.zero,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  _provider.addToCart(item);
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  padding: paddingCard,
                  decoration: BoxDecoration(
                    color: context.card,
                    border: Border.all(color: context.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Icon container (like CardProvider)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.muted,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          LucideIcons.package,
                          size: 24,
                          color: context.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Text section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.namaproduk,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.labelLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Modal: ',
                                  style: context.bodySmall.copyWith(
                                    color: context.mutedForeground,
                                  ),
                                ),
                                Text(
                                  'Rp ${ToCurrency(item.hargamodal.toString())}',
                                  style: context.bodySmall.copyWith(
                                    color: context.destructive,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Jual: ',
                                  style: context.bodySmall.copyWith(
                                    color: context.mutedForeground,
                                  ),
                                ),
                                Text(
                                  'Rp ${ToCurrency(item.hargajual.toString())}',
                                  style: context.bodySmall.copyWith(
                                    color: context.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Trailing - stock info and icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.satuan,
                            style: context.bodySmall.copyWith(
                              color: context.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        MdiIcons.chevronRight,
                        size: 24,
                        color: context.primary,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
