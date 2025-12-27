import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/kategori_favorit.dart';
import 'package:dmpku/core/enums/tipe_produk.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/favorit_response.dart';
import 'package:dmpku/pages/member/akun/favorit/member_favorit_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class PilihFavoritDialog extends StatefulWidget {
  final TipeProduk tipeProduk;
  final ValueChanged<FavoritModel> onFavoritSelected;

  const PilihFavoritDialog({
    super.key,
    required this.tipeProduk,
    required this.onFavoritSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required TipeProduk tipeProduk,
    required ValueChanged<FavoritModel> onFavoritSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getMemberFavoritProvider(context)),
        ],
        child: PilihFavoritDialog(
          tipeProduk: tipeProduk,
          onFavoritSelected: onFavoritSelected,
        ),
      ),
    );
  }

  @override
  State<PilihFavoritDialog> createState() => _PilihFavoritDialogState();
}

class _PilihFavoritDialogState extends State<PilihFavoritDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMemberFavoritProvider(context).getFavoritList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FavoritModel> _filterFavorit(List<FavoritModel> favorit) {
    // 1. Filter by Category (if not All)
    var filtered = favorit
        .where(
          (element) =>
              element.idkategori == widget.tipeProduk.idFavorit ||
              element.idkategori == TipeProduk.all.idFavorit,
        )
        .toList();

    // 2. Filter by Search Query
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((fav) {
        final namaFavorit = fav.nama.toLowerCase();
        final nomorFavorit = fav.nomor.toLowerCase();
        // Optional: Filter by Category Name too if needed, but we already filtered by category ID
        return namaFavorit.contains(query) || nomorFavorit.contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ).copyWith(bottom: bottomInset > 0 ? bottomInset : 20),
      decoration: BoxDecoration(
        color: context.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: context.border, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          const TopDividerSheet(),
          const Gap(15),
          _buildHeader(context),
          const Gap(10),
          _buildSearchField(context),
          const Gap(10),
          Expanded(child: _buildListContent(context)),
          const Gap(20),
          CustomButton(
            height: 40,
            width: double.infinity,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.destructive,
            text: "TUTUP",
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent(BuildContext context) {
    return BlocBuilder<MemberFavoritProvider, MemberFavoritState>(
      builder: (context, state) {
        if (state.apiGetFavoritStatus.isLoading) {
          return _buildShimmerLoading(context);
        }

        final filteredList = _filterFavorit(state.favoritList);

        if (filteredList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    MdiIcons.starOff,
                    size: 48,
                    color: context.mutedForeground,
                  ),
                  const Gap(10),
                  Text(
                    "Favorit tidak ditemukan",
                    style: context.bodyMedium.copyWith(
                      color: context.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final item = filteredList[index];
            return _buildFavoritItem(context, item);
          },
        );
      },
    );
  }

  Widget _buildFavoritItem(BuildContext context, FavoritModel item) {
    var jenisFav = Kategori.fromId(item.idkategori) ?? Kategori.all;
    var katItem = jenisFav.toKategoriItem ?? getKategoriFavorit()[0];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.border, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          widget.onFavoritSelected(item);
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: paddingCard,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.muted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: katItem.icon != null
                    ? Image(image: katItem.icon!, width: 20, height: 20)
                    : Icon(MdiIcons.star, size: 20, color: context.foreground),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nama,
                      style: context.bodyMedium.withWeight(FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.nomor,
                      style: context.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.muted,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.namakategori,
                  style: context.bodySmall
                      .withSize(10)
                      .withWeight(FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
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
              child: Icon(MdiIcons.star, color: context.primary, size: 20),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih Dari Favorit",
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Pilih nomor tujuan dari daftar favorit",
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: context.mutedForeground),
          const Gap(8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: context.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari nama atau nomor...',
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
                          setState(() {});
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

  Widget _buildShimmerLoading(BuildContext context) {
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;

    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: context.border, width: 1),
          ),
          child: Padding(
            padding: paddingCard,
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 14,
                          margin: const EdgeInsets.only(right: 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Gap(6),
                        Container(
                          width: 120,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
