import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/jenis_filter_riwayat.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_page.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi_shimmer.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_mutasi_stok_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_rekap_transaksi_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_riwayat_history_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_riwayat_today_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/item_mutasi_stok.dart';
import 'package:dmpku/pages/member/riwayat/widgets/item_mutasi_stok_shimmer.dart';
import 'package:dmpku/pages/member/riwayat/widgets/item_rekap_transaksi.dart';
import 'package:dmpku/pages/member/riwayat/widgets/item_rekap_transaksi_shimmer.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/produk/grouped_refreshable_list.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/tab/custom_tab_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MemberRiwayatPage extends StatefulWidget {
  static const routeName = '/member/riwayat';

  const MemberRiwayatPage({super.key});

  @override
  State<MemberRiwayatPage> createState() => _MemberRiwayatPageState();
}

class _MemberRiwayatPageState extends State<MemberRiwayatPage> {
  late PageController _pageViewController;
  late CustomTabRiwayatController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = CustomTabRiwayatController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index, {bool fromTab = true}) {
    setState(() {
      _selectedTabIndex = index;
    });

    if (fromTab) {
      _pageViewController.jumpToPage(index);
    } else {
      _tabController.jumpToTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: context.secondary,
        body: Stack(
          fit: StackFit.loose,
          children: [_buildHeaderBackground(), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.primary,
        image: DecorationImage(
          image: Assets.img.bgPattern.provider(),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            title: 'Riwayat Transaksi',
            showBackButton: false,
            backgroundColor: Colors.transparent,
          ),

          Gap(10),

          CustomTabRiwayat(
            tabs: ["Hari Ini", "Kemarin", "Mutasi Stok", "Rekap Transaksi"],
            controller: _tabController,
            onChange: (int index) {
              _onTabChanged(index, fromTab: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 130),
        _buildFilterSection(context),

        Expanded(
          child: Container(
            color: context.secondary,
            child: PageView(
              controller: _pageViewController,
              onPageChanged: (index) {
                _onTabChanged(index, fromTab: false);
              },
              children: [
                Expanded(child: _buildListHariIni(context)),
                Expanded(child: _buildListKemarin(context)),
                Expanded(child: _buildListMutasiStok(context)),
                Expanded(child: _buildListRekapTransaksi(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListHariIni(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatTodayStatus != curr.apiFetchRiwayatTodayStatus ||
          prev.canLoadMoreRiwayatToday != curr.canLoadMoreRiwayatToday ||
          prev.riwayatTodayList != curr.riwayatTodayList,
      builder: (context, state) {
        return LoadMoreRefreshableList<RiwayatModel>(
          // Pake Flat List
          items: state.riwayatTodayList,
          isLoading:
              state.apiFetchRiwayatTodayStatus.isLoading &&
              state.pageRiwayatToday == 1,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          onRefresh: () async =>
              context.read<MemberRiwayatProvider>().resetPageRiwayatToday(),
          loadingWidget: CardRiwayatTransaksiListShimmer(
            itemCount: 6,
            itemMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          ),

          // Item Builder
          itemBuilder: (context, item, index) {
            return CardRiwayatTransaksi(
              namaProduk: item.namaproduk,
              tujuan: item.tujuan,
              totalHarga: item.totalHargaFormatted,
              status: item.statusTrx,
              waktuTrx: DateHelper.tryParse(item.waktutrx) ?? DateTime.now(),
              imgProduk: item.imgproduk,
              onTap: () {
                pushNamed(MemberDetailRiwayatPage.routeName);
                getMemberDetailRiwayatProvider(
                  context,
                ).setSelectedTransaksi(item, true);
              },
            );
          },

          // Load More Logic
          canLoadMore: state.canLoadMoreRiwayatToday,
          isLoadingMore:
              state.apiFetchRiwayatTodayStatus.isLoading &&
              state.pageRiwayatToday > 1,
          onLoadMore: () {
            context.read<MemberRiwayatProvider>().nextPageRiwayatToday();
          },
        );
      },
    );
  }

  Widget _buildListKemarin(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatHistoryStatus !=
              curr.apiFetchRiwayatHistoryStatus ||
          prev.canLoadMoreRiwayatHistory != curr.canLoadMoreRiwayatHistory ||
          prev.riwayatHistoryListGrouped != curr.riwayatHistoryListGrouped,
      builder: (context, state) {
        return GroupedRefreshableList<GroupedRiwayatModel, RiwayatModel>(
          // Pake Grouped List
          groups: state.riwayatHistoryListGrouped.groupedRiwayatList,
          isLoading:
              state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory == 1,
          loadingWidget: CardRiwayatTransaksiListShimmer(
            itemCount: 6,
            itemMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          ),
          // Cara ambil list item dari object Group
          getItems: (group) => group.riwayatList,

          onRefresh: () async =>
              context.read<MemberRiwayatProvider>().resetPageRiwayatHistory(),

          padding: EdgeInsets.symmetric(horizontal: 16),
          // Header Tanggal
          groupHeaderBuilder: (context, group) {
            return Container(
              color: context.secondary,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: context.primary,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      group.tanggal,
                      style: context.bodySmall
                          .withWeight(FontWeight.w600)
                          .withColor(context.primary),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: context.primary,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            );
          },

          // Item Builder
          itemBuilder: (context, item, index) {
            return CardRiwayatTransaksi(
              namaProduk: item.namaproduk,
              tujuan: item.tujuan,
              totalHarga: item.totalHargaFormatted,
              status: item.statusTrx,
              waktuTrx: DateHelper.tryParse(item.waktutrx) ?? DateTime.now(),
              imgProduk: item.imgproduk,
              onTap: () {
                pushNamed(MemberDetailRiwayatPage.routeName);
                getMemberDetailRiwayatProvider(
                  context,
                ).setSelectedTransaksi(item, false);

              },
            );
          },

          // Load More Logic
          canLoadMore: state.canLoadMoreRiwayatHistory,
          isLoadingMore:
              state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory > 1,
          onLoadMore: () {
            context.read<MemberRiwayatProvider>().nextPageRiwayatHistory();
          },
        );
      },
    );
  }

  Widget _buildListMutasiStok(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: context.border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 4),
                  width: 80,
                  child: Text(
                    'Waktu',
                    textAlign: TextAlign.start,
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 4),
                    child: Text(
                      'Keterangan',
                      style: context.bodySmall
                          .withColor(Colors.white)
                          .withWeight(FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 2),
                  width: 60,
                  child: Text(
                    'Potongan',
                    textAlign: TextAlign.end,
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 4),
                  width: 50,
                  child: Text(
                    'Stok',
                    textAlign: TextAlign.end,
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
                buildWhen: (prev, curr) =>
                    prev.apiFetchMutasiStokStatus !=
                        curr.apiFetchMutasiStokStatus ||
                    prev.pageMutasiStok != curr.pageMutasiStok ||
                    prev.mutasiStokList != curr.mutasiStokList ||
                    prev.canLoadMoreMutasiStok != curr.canLoadMoreMutasiStok,
                builder: (context, state) {
                  return LoadMoreRefreshableList<MutasiSaldoModel>(
                    padding: EdgeInsets.zero,
                    isLoading:
                        state.apiFetchMutasiStokStatus.isLoading &&
                        state.pageMutasiStok == 1,
                    loadingWidget: ItemMutasiStokListShimmer(itemCount: 6),
                    onRefresh: () async {
                      getMemberRiwayatProvider(context).resetPageMutasiStok();
                    },
                    items: state.mutasiStokList,
                    itemBuilder: (context, stok, index) {
                      var isMinus = stok.mutasi < 0;

                      return ItemMutasiStok(
                        waktu: stok.waktuMutasi,
                        keterangan: stok.keterangan
                            .replaceAll("Saldo", "Stok")
                            .replaceAll("saldo", "stok"),
                        potongan: stok.mutasi,
                        stok: stok.saldo,
                        isOdd: index % 2 == 1,
                        isMinus: isMinus,
                      );
                    },
                    emptyTitle: 'Data mutasi stok tidak ditemukan',
                    canLoadMore: state.canLoadMoreMutasiStok,
                    isLoadingMore:
                        state.apiFetchMutasiStokStatus.isLoading &&
                        state.pageMutasiStok > 1,
                    onLoadMore: () {
                      context
                          .read<MemberRiwayatProvider>()
                          .nextPageMutasiStok();
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: context.card,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              border: Border(top: BorderSide(color: context.border, width: 1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stok Saat Ini",
                  style: context.bodySmall.withWeight(FontWeight.w600),
                ),
                BlocBuilder<MemberProvider, MemberState>(
                  builder: (context, state) {
                    return Text(
                      state.profile.formatSaldo,
                      style: context.bodySmall
                          .withWeight(FontWeight.w600)
                          .withColor(context.primary),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListRekapTransaksi(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: context.border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 4),
                  width: 30,
                  child: Text(
                    'No',
                    textAlign: TextAlign.start,
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 4),
                    child: Text(
                      'Produk',
                      style: context.bodySmall
                          .withColor(Colors.white)
                          .withWeight(FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 2),
                  width: 100,
                  child: Text(
                    'Jml trx',
                    textAlign: TextAlign.end,
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 4),
                  width: 100,
                  child: Text(
                    'Total',
                    textAlign: TextAlign.end,
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
                buildWhen: (prev, curr) =>
                    prev.apiFetchRekapTransaksiStatus !=
                        curr.apiFetchRekapTransaksiStatus ||
                    prev.rekapTransaksiList != curr.rekapTransaksiList,
                builder: (context, state) {
                  return LoadMoreRefreshableList<RekapTransaksiModel>(
                    padding: EdgeInsets.zero,
                    isLoading: state.apiFetchRekapTransaksiStatus.isLoading,
                    loadingWidget: ItemRekapTransaksiListShimmer(itemCount: 6),
                    onRefresh: () async {
                      getMemberRiwayatProvider(context).fetchRekapTransaksi();
                    },
                    items: state.rekapTransaksiList,
                    itemBuilder: (context, stok, index) {
                      return ItemRekapTransaksi(
                        no: index + 1,
                        produk: stok.kodeproduk,
                        jmlTrx: stok.jumlahtrx,
                        total: stok.totaldebet,
                        isOdd: index % 2 == 1,
                      );
                    },
                    emptyTitle: 'Data rekap transaksi tidak ditemukan',
                    canLoadMore: false,
                  );
                },
              ),
            ),
          ),
          BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
            buildWhen: (prev, curr) =>
                prev.totalJumlahTrx != curr.totalJumlahTrx ||
                prev.totalNominalTrx != curr.totalNominalTrx,
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.card,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  border: Border(
                    top: BorderSide(color: context.border, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Total",
                        style: context.bodySmall.withWeight(FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 4),
                      width: 100,
                      child: Text(
                        ToCurrency(state.totalJumlahTrx.toString()),
                        textAlign: TextAlign.end,
                        style: context.bodySmall.withColor(context.primary),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 4),
                      width: 100,
                      child: Text(
                        ToCurrency(state.totalNominalTrx.toString()),
                        textAlign: TextAlign.end,
                        style: context.bodySmall.withColor(context.primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: paddingPage,
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedTabIndex == 0) _filterTransaksiToday(context),
                if (_selectedTabIndex == 1) _filterTransaksiHis(context),
                if (_selectedTabIndex == 2) _filterMutasiStok(context),
                if (_selectedTabIndex == 3) _filterRekapTransaksi(context),
              ],
            ),
          ),
        ),
        _buildKetFilter(context),
      ],
    );
  }

  Widget _buildKetFilter(BuildContext context) {
    return Column(
      children: [
        // Keterangan Filter Today
        ...[
          BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
            buildWhen: (prev, curr) =>
                prev.jenisFilterToday != curr.jenisFilterToday ||
                prev.kataKunciToday != curr.kataKunciToday,
            builder: (context, state) {
              if (_selectedTabIndex == 0 && state.kataKunciToday.isNotEmpty) {
                return Padding(
                  padding: paddingPage.copyWith(left: 18, right: 18),
                  child: Row(
                    children: [
                      Text(
                        "FILTER: ",
                        style: context.bodyMedium
                            .withColor(context.mutedForeground)
                            .withWeight(FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? context.primary.withOpacity(0.1)
                              : context.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${state.jenisFilterToday.label} : \"${state.kataKunciToday}\"",
                          style: context.bodySmall
                              .withColor(context.primary)
                              .withWeight(FontWeight.w600),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          getMemberRiwayatProvider(
                            context,
                          ).resetSearchRiwayatToday();
                          getMemberRiwayatProvider(
                            context,
                          ).resetPageRiwayatToday();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: context.destructive.withOpacity(0.2),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Hapus",
                                style: context.bodySmall.withColor(
                                  context.destructive,
                                ),
                              ),
                              Gap(4),
                              Icon(
                                LucideIcons.x,
                                size: 16,
                                color: context.destructive,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SizedBox.shrink();
            },
          ),
        ],
        // End Keterangan Filter Today
        // Keterangan Filter History
        ...[
          BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
            buildWhen: (prev, curr) =>
                prev.jenisFilterHistory != curr.jenisFilterHistory ||
                prev.kataKunciHistory != curr.kataKunciHistory,
            builder: (context, state) {
              if (_selectedTabIndex == 1 && state.kataKunciHistory.isNotEmpty) {
                return Padding(
                  padding: paddingPage.copyWith(left: 18, right: 18),
                  child: Row(
                    children: [
                      Text(
                        "FILTER: ",
                        style: context.bodyMedium
                            .withColor(context.mutedForeground)
                            .withWeight(FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? context.primary.withOpacity(0.1)
                              : context.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${state.jenisFilterHistory.label} : \"${state.kataKunciHistory}\"",
                          style: context.bodySmall
                              .withColor(context.primary)
                              .withWeight(FontWeight.w600),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          getMemberRiwayatProvider(
                            context,
                          ).resetSearchRiwayatHistory();
                          getMemberRiwayatProvider(
                            context,
                          ).resetPageRiwayatHistory();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: context.destructive.withOpacity(0.2),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Hapus",
                                style: context.bodySmall.withColor(
                                  context.destructive,
                                ),
                              ),
                              Gap(4),
                              Icon(
                                LucideIcons.x,
                                size: 16,
                                color: context.destructive,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SizedBox.shrink();
            },
          ),
        ],
        // End Keterangan Filter History
        // Keterangan Mutasi Stok
        ...[
          BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
            buildWhen: (prev, curr) =>
                prev.kataKunciMutasiStok != curr.kataKunciMutasiStok,
            builder: (context, state) {
              if (_selectedTabIndex == 1 &&
                  state.kataKunciMutasiStok.isNotEmpty) {
                return Padding(
                  padding: paddingPage.copyWith(left: 18, right: 18),
                  child: Row(
                    children: [
                      Text(
                        "FILTER: ",
                        style: context.bodyMedium
                            .withColor(context.mutedForeground)
                            .withWeight(FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? context.primary.withOpacity(0.1)
                              : context.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "KET : \"${state.kataKunciMutasiStok}\"",
                          style: context.bodySmall
                              .withColor(context.primary)
                              .withWeight(FontWeight.w600),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          getMemberRiwayatProvider(
                            context,
                          ).resetSearchMutasiStok();
                          getMemberRiwayatProvider(
                            context,
                          ).resetPageMutasiStok();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: context.destructive.withOpacity(0.2),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Hapus",
                                style: context.bodySmall.withColor(
                                  context.destructive,
                                ),
                              ),
                              Gap(4),
                              Icon(
                                LucideIcons.x,
                                size: 16,
                                color: context.destructive,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SizedBox.shrink();
            },
          ),
        ],
        // End Keterangan Mutasi Stok
      ],
    );
  }

  Widget _filterTransaksiToday(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatTodayStatus != curr.apiFetchRiwayatTodayStatus ||
          prev.jenisFilterToday != curr.jenisFilterToday ||
          prev.kataKunciToday != curr.kataKunciToday,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Periode Aktif",
                    style: context.bodySmall.withColor(context.primary),
                  ),
                  Text(
                    "Hari Ini",
                    style: context.bodySmall.withWeight(FontWeight.w600),
                  ),
                ],
              ),
            ),

            Gap(5),
            VerticalDivider(color: context.primary, thickness: 4, width: 1),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Filter",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.filter,
              onPressed: () {
                FilterRiwayatTodayDialog.show(
                  context,
                  initialFilter: state.jenisFilterToday,
                  initialSearch: state.kataKunciToday,
                );
              },
            ),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Refresh",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.refreshCcw,
              isLoading:
                  state.apiFetchRiwayatTodayStatus.isLoading &&
                  state.pageRiwayatToday == 1,
              onPressed: () {
                getMemberRiwayatProvider(context).resetPageRiwayatToday();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _filterTransaksiHis(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatHistoryStatus !=
              curr.apiFetchRiwayatHistoryStatus ||
          prev.waktuAwalHistory != curr.waktuAwalHistory ||
          prev.waktuAkhirHistory != curr.waktuAkhirHistory ||
          prev.jenisFilterHistory != curr.jenisFilterHistory ||
          prev.kataKunciHistory != curr.kataKunciHistory,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Periode Aktif",
                    style: context.bodySmall.withColor(context.primary),
                  ),
                  Text(
                    DateHelper.joinDateRange(
                      state.waktuAwalHistory!,
                      state.waktuAkhirHistory!,
                    ),
                    style: context.bodySmall.withWeight(FontWeight.w600),
                  ),
                ],
              ),
            ),

            Gap(5),
            VerticalDivider(color: context.primary, thickness: 4, width: 1),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Filter",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.filter,
              onPressed: () {
                FilterRiwayatHistoryDialog.show(
                  context,
                  initialFilter: state.jenisFilterHistory,
                  initialSearch: state.kataKunciHistory,
                  waktuAwal: state.waktuAwalHistory!,
                  waktuAkhir: state.waktuAkhirHistory!,
                );
              },
            ),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Refresh",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.refreshCcw,
              isLoading:
                  state.apiFetchRiwayatHistoryStatus.isLoading &&
                  state.pageRiwayatHistory == 1,
              onPressed: () {
                getMemberRiwayatProvider(context).resetPageRiwayatHistory();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _filterMutasiStok(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchMutasiStokStatus != curr.apiFetchMutasiStokStatus ||
          prev.waktuAwalMutasiStok != curr.waktuAwalMutasiStok ||
          prev.waktuAkhirMutasiStok != curr.waktuAkhirMutasiStok ||
          prev.kataKunciMutasiStok != curr.kataKunciMutasiStok,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Periode Aktif",
                    style: context.bodySmall.withColor(context.primary),
                  ),
                  Text(
                    DateHelper.joinDateRange(
                      state.waktuAwalMutasiStok!,
                      state.waktuAkhirMutasiStok!,
                    ),
                    style: context.bodySmall.withWeight(FontWeight.w600),
                  ),
                ],
              ),
            ),

            Gap(5),
            VerticalDivider(color: context.primary, thickness: 4, width: 1),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Filter",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.filter,
              onPressed: () {
                FilterMutasiStokDialog.show(context);
              },
            ),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Refresh",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.refreshCcw,
              onPressed: () {
                getMemberRiwayatProvider(context).resetPageMutasiStok();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _filterRekapTransaksi(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRekapTransaksiStatus !=
              curr.apiFetchRekapTransaksiStatus ||
          prev.waktuAwalRekapTransaksi != curr.waktuAwalRekapTransaksi ||
          prev.kataKunciRekapTransaksi != curr.kataKunciRekapTransaksi,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Periode Aktif",
                    style: context.bodySmall.withColor(context.primary),
                  ),
                  Text(
                    DateHelper.formatSimpleDate(state.waktuAwalRekapTransaksi!),
                    style: context.bodySmall.withWeight(FontWeight.w600),
                  ),
                ],
              ),
            ),

            Gap(5),
            VerticalDivider(color: context.primary, thickness: 4, width: 1),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Filter",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.filter,
              onPressed: () {
                FilterRekapTransaksiDialog.show(
                  context,
                  waktuAwal: state.waktuAwalRekapTransaksi,
                  initialSearch: state.kataKunciRekapTransaksi,
                );
              },
            ),
            Gap(5),

            CustomButton(
              height: 25,
              size: ButtonSize.small,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              text: "Refresh",
              textStyle: context.captionMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primaryForeground),
              icon: LucideIcons.refreshCcw,
              onPressed: () {
                getMemberRiwayatProvider(context).fetchRekapTransaksi();
              },
            ),
          ],
        );
      },
    );
  }
}
