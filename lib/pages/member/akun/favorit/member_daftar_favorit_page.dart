import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/kategori_favorit.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/favorit_response.dart';
import 'package:dmpku/pages/member/akun/favorit/member_favorit_provider.dart';
import 'package:dmpku/pages/member/akun/favorit/widget/hapus_favorit_dialog.dart';
import 'package:dmpku/pages/member/akun/favorit/widget/option_favorit.dart';
import 'package:dmpku/pages/member/akun/favorit/widget/tambah_favorit_dialog.dart';
import 'package:dmpku/pages/member/akun/favorit/widget/ubah_favorit_dialog.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart'; // Jangan lupa import ini!

class MemberDaftarFavoritPage extends StatefulWidget {
  const MemberDaftarFavoritPage({super.key});

  static const String routeName = '/member/akun/favorit';

  @override
  State<MemberDaftarFavoritPage> createState() =>
      _MemberDaftarFavoritPageState();
}

class _MemberDaftarFavoritPageState extends State<MemberDaftarFavoritPage> {
  @override
  void initState() {
    super.initState();
    // Panggil data otomatis pas halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMemberFavoritProvider(context).getFavoritList();
    });
  }

  void closePage() {
    pop();
  }

  List<FavoritModel> _filterFavorit(List<FavoritModel> favorit, String search) {
    if (search.isEmpty) return favorit;

    final query = search.toLowerCase();
    return favorit.where((fav) {
      final namaFavorit = fav.nama.replaceAll(RegExp(r'[^\w\s]'), '');
      final nomorFavorit = fav.nomor.replaceAll(RegExp(r'[^\w\s]'), '');

      final katFa = fav.kategori.label.replaceAll(RegExp(r'[^\w\s]'), '');

      return namaFavorit.toLowerCase().contains(query) ||
          nomorFavorit.toLowerCase().contains(query) ||
          katFa.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          closePage();
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Daftar Favorit",
            onBackButtonPressed: closePage,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              TambahFavoritDialog.show(context, idKategori: Kategori.all.id);
            },
            backgroundColor: context.primary,
            shape: const CircleBorder(), // Biar bulet sempurna
            child: const Icon(LucideIcons.plus, color: Colors.white),
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildHeaderCard(context),
                Gap(5),
                _buildJumlahKontak(context),
                Gap(10),
                _buildSearchField(context),
                Gap(10),
                Expanded(child: _buildFavoritContent(context)),
                Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.img.profile.icFavorit.image(width: 40, height: 40),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daftar Favorit",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  Text("Kelola daftar favorit Anda.", style: context.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJumlahKontak(BuildContext context) {
    return BlocBuilder<MemberFavoritProvider, MemberFavoritState>(
      buildWhen: (previous, current) =>
          previous.favoritList != current.favoritList,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -20,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Tersimpan',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${state.favoritList.length} Favorit',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.star_border_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 48,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return BlocBuilder<MemberFavoritProvider, MemberFavoritState>(
      buildWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery,
      builder: (context, state) {
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
                  controller: state.searchController,
                  onChanged: (val) {
                    getMemberFavoritProvider(
                      context,
                    ).setSearchQuery(val, updateController: false);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Favorit',
                    border: InputBorder.none,
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberFavoritProvider(
                                context,
                              ).setSearchQuery('', updateController: true);
                            },
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: context.foreground,
                            ),
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFavoritContent(BuildContext context) {
    return BlocBuilder<MemberFavoritProvider, MemberFavoritState>(
      buildWhen: (previous, current) =>
          previous.apiGetFavoritStatus != current.apiGetFavoritStatus ||
          previous.favoritList != current.favoritList ||
          previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        var filteredList = _filterFavorit(state.favoritList, state.searchQuery);

        return RefreshableList(
          loadingWidget: _buildShimmerLoading(context),
          isLoading: state.apiGetFavoritStatus.isLoading,
          onRefresh: getMemberFavoritProvider(context).getFavoritList,
          items: filteredList,
          itemBuilder: (context, provider, index) {
            return _buildFavoritItem(context, provider);
          },
          emptyTitle: 'Favorit tidak ditemukan',
        );
      },
    );
  }

  Widget _buildFavoritItem(BuildContext context, FavoritModel provider) {
    var jenisFav = Kategori.fromId(provider.idkategori) ?? Kategori.all;
    var katItem = jenisFav.toKategoriItem ?? getKategoriFavorit()[0];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            if (katItem.icon != null)
              Image(image: katItem.icon!, width: 40, height: 40)
            else
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: context.border, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  LucideIcons.star,
                  size: 20,
                  color: context.foreground,
                ),
              ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.nama,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    provider.nomor,
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
                provider.namakategori,
                style: context.bodySmall
                    .withSize(10)
                    .withWeight(FontWeight.w600),
              ),
            ),
            const Gap(4),
            OptionFavorit(
              onEdit: () {
                UbahFavoritDialog.show(
                  context,
                  favoritModel: provider,
                  idKategori: provider.idkategori,
                );
              },
              onDelete: () {
                HapusFavoritDialog.show(context, favorit: provider);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- SHIMMER LOADING EFFECT ---
  Widget _buildShimmerLoading(BuildContext context) {
    // Tentukan warna shimmer (biasanya abu-abu muda ke agak terang)
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;

    return ListView.builder(
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: paddingCard,
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Row(
                children: [
                  // Dummy Icon Box
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
                        // Dummy Nama
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
                        // Dummy Nomor
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
                  const Gap(12),
                  // Dummy Tag Kategori
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(8),
                  // Dummy Action Dots
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
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
