import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/member_pelanggan_provider.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/widgets/hapus_pelanggan_dialog.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/widgets/option_pelanggan.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/widgets/tambah_pelanggan_dialog.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/widgets/ubah_pelanggan_dialog.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberPelangganPage extends StatefulWidget {
  const MemberPelangganPage({super.key});

  static const String routeName = '/member/kasir/pelanggan';

  @override
  State<MemberPelangganPage> createState() => _MemberPelangganPageState();
}

class _MemberPelangganPageState extends State<MemberPelangganPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMemberPelangganProvider(context).getPelangganList();
    });
  }

  void closePage() {
    pop();
  }

  List<PelangganModel> _filterPelanggan(
    List<PelangganModel> pelanggan,
    String search,
  ) {
    if (search.isEmpty) return pelanggan;

    final query = search.toLowerCase();
    return pelanggan.where((plg) {
      final nama = plg.namapelanggan.replaceAll(RegExp(r'[^\w\s]'), '');
      return nama.toLowerCase().contains(query) ||
          plg.nohppelanggan.contains(query);
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
            title: "Data Pelanggan",
            onBackButtonPressed: closePage,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              TambahPelangganDialog.show(context);
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
                _buildJumlahPelanggan(context),
                const Gap(10),
                _buildSearchField(context),
                const Gap(10),
                Expanded(child: _buildPelangganContent(context)),
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
                    "Data Pelanggan",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  Text(
                    "Kelola daftar pelanggan Anda.",
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJumlahPelanggan(BuildContext context) {
    return BlocBuilder<MemberPelangganProvider, MemberPelangganState>(
      buildWhen: (previous, current) =>
          previous.pelangganList != current.pelangganList,
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
                            'Total Pelanggan',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${state.pelangganList.length} Pelanggan',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        LucideIcons.users,
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
    return BlocBuilder<MemberPelangganProvider, MemberPelangganState>(
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
                    getMemberPelangganProvider(
                      context,
                    ).setSearchQuery(val, updateController: false);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Pelanggan',
                    border: InputBorder.none,
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberPelangganProvider(
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

  Widget _buildPelangganContent(BuildContext context) {
    return BlocBuilder<MemberPelangganProvider, MemberPelangganState>(
      buildWhen: (previous, current) =>
          previous.apiGetPelangganStatus != current.apiGetPelangganStatus ||
          previous.pelangganList != current.pelangganList ||
          previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        var filteredList = _filterPelanggan(
          state.pelangganList,
          state.searchQuery,
        );

        return RefreshableList(
          loadingWidget: _buildShimmerLoading(context),
          isLoading: state.apiGetPelangganStatus.isLoading,
          onRefresh: getMemberPelangganProvider(context).getPelangganList,
          items: filteredList,
          itemBuilder: (context, provider, index) {
            return _buildPelangganItem(context, provider);
          },
          emptyTitle: 'Pelanggan tidak ditemukan',
        );
      },
    );
  }

  Widget _buildPelangganItem(BuildContext context, PelangganModel pelanggan) {
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
                  pelanggan.namapelanggan.isNotEmpty
                      ? pelanggan.namapelanggan.substring(0, 1).toUpperCase()
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
                    pelanggan.namapelanggan,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(2),
                  Text(pelanggan.nohppelanggan, style: context.bodySmall),
                  if (pelanggan.alamatpelanggan.isNotEmpty) ...[
                    const Gap(2),
                    Text(
                      pelanggan.alamatpelanggan,
                      style: context.bodySmall.copyWith(
                        fontSize: 10,
                        color: context.mutedForeground,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const Gap(8),
            OptionPelanggan(
              onEdit: () {
                UbahPelangganDialog.show(context, pelangganModel: pelanggan);
              },
              onDelete: () {
                HapusPelangganDialog.show(context, pelangganModel: pelanggan);
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
