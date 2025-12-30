import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/produk/member_produk_provider.dart';
import 'package:dmpku/pages/member/kasir/produk/widgets/hapus_produk_dialog.dart';
import 'package:dmpku/pages/member/kasir/produk/widgets/option_produk.dart';
import 'package:dmpku/pages/member/kasir/produk/widgets/tambah_produk_dialog.dart';
import 'package:dmpku/pages/member/kasir/produk/widgets/ubah_produk_dialog.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberProdukPage extends StatefulWidget {
  const MemberProdukPage({super.key});

  static const String routeName = '/member/kasir/produk';

  @override
  State<MemberProdukPage> createState() => _MemberProdukPageState();
}

class _MemberProdukPageState extends State<MemberProdukPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMemberProdukProvider(context).getProdukList();
    });
  }

  void closePage() {
    pop();
  }

  List<ProdukModel> _filterProduk(List<ProdukModel> produk, String search) {
    if (search.isEmpty) return produk;

    final query = search.toLowerCase();
    return produk.where((prod) {
      final namaProduk = prod.namaproduk.replaceAll(RegExp(r'[^\w\s]'), '');
      return namaProduk.toLowerCase().contains(query);
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
            title: "Data Produk",
            onBackButtonPressed: closePage,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              TambahProdukDialog.show(context);
            },
            backgroundColor: context.primary,
            shape: const CircleBorder(),
            child: const Icon(LucideIcons.plus, color: Colors.white),
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildHeaderCard(context),
                const Gap(5),
                _buildJumlahProduk(context),
                const Gap(10),
                _buildSearchField(context),
                const Gap(10),
                Expanded(child: _buildProdukContent(context)),
                const Gap(10),
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
            Assets.img.menuPenjualan.icKasir.image(width: 40, height: 40),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data Produk",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  Text("Kelola daftar produk Anda.", style: context.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJumlahProduk(BuildContext context) {
    return BlocBuilder<MemberProdukProvider, MemberProdukState>(
      buildWhen: (previous, current) =>
          previous.produkList != current.produkList,
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
                            'Total Produk',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${state.produkList.length} Produk',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        LucideIcons.package,
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
    return BlocBuilder<MemberProdukProvider, MemberProdukState>(
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
                    getMemberProdukProvider(
                      context,
                    ).setSearchQuery(val, updateController: false);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Produk',
                    border: InputBorder.none,
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberProdukProvider(
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

  Widget _buildProdukContent(BuildContext context) {
    return BlocBuilder<MemberProdukProvider, MemberProdukState>(
      buildWhen: (previous, current) =>
          previous.apiGetProdukStatus != current.apiGetProdukStatus ||
          previous.produkList != current.produkList ||
          previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        var filteredList = _filterProduk(state.produkList, state.searchQuery);

        return RefreshableList(
          loadingWidget: _buildShimmerLoading(context),
          isLoading: state.apiGetProdukStatus.isLoading,
          onRefresh: getMemberProdukProvider(context).getProdukList,
          items: filteredList,
          itemBuilder: (context, provider, index) {
            return _buildProdukItem(context, provider);
          },
          emptyTitle: 'Produk tidak ditemukan',
        );
      },
    );
  }

  Widget _buildProdukItem(BuildContext context, ProdukModel produk) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: context.border, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: context.muted,
              ),
              child: Center(
                child: Text(
                  produk.namaproduk.isNotEmpty
                      ? produk.namaproduk.substring(0, 1).toUpperCase()
                      : 'P',
                  style: context.bodyLarge.withWeight(FontWeight.bold),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.namaproduk,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Text(
                        'Jual: ${ToCurrency(produk.hargajual.toString())}',
                        style: context.bodySmall.copyWith(
                          color: context.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Modal: ${ToCurrency(produk.hargamodal.toString())}',
                        style: context.bodySmall.copyWith(fontSize: 10),
                      ),
                    ],
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
                produk.satuan,
                style: context.bodySmall
                    .withSize(10)
                    .withWeight(FontWeight.w600),
              ),
            ),
            const Gap(4),
            OptionProduk(
              onEdit: () {
                UbahProdukDialog.show(context, produkModel: produk);
              },
              onDelete: () {
                HapusProdukDialog.show(context, produkModel: produk);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- SHIMMER LOADING EFFECT ---
  Widget _buildShimmerLoading(BuildContext context) {
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
                  const Gap(12),
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(8),
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
