import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi_shimmer.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class AmbilRiwayatDialog extends StatefulWidget {
  const AmbilRiwayatDialog({super.key});

  static Future<RiwayatModel?> show(BuildContext context) {
    return showModalBottomSheet<RiwayatModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider(
        create: (_) => MemberRiwayatProvider(),
        child: const AmbilRiwayatDialog(),
      ),
    );
  }

  @override
  State<AmbilRiwayatDialog> createState() => _AmbilRiwayatDialogState();
}

class _AmbilRiwayatDialogState extends State<AmbilRiwayatDialog> {
  @override
  void initState() {
    super.initState();
    // Initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MemberRiwayatProvider>();

      // Fetch Today (Hari ini)
      final now = DateTime.now();
      provider.setRangeWaktu(now, now);
      provider.fetchRiwayatHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final paddingCard = const EdgeInsets.all(12.0);

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            const Gap(10),
            const TopDividerSheet(),
            const Gap(15),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: paddingCard,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colors.grey[800]
                            : Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        MdiIcons.history,
                        size: 16,
                        color: context.primary,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Riwayat Hari Ini',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Pilih transaksi hari ini untuk diinput ulang.',
                            style: context.captionRegular.withColor(
                              context.foreground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            Expanded(child: _buildListHariIni()),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                height: 40,
                width: double.infinity,
                variant: ButtonVariant.outline,
                text: "TUTUP",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Widget _buildListHariIni() {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatHistoryStatus !=
              curr.apiFetchRiwayatHistoryStatus ||
          prev.canLoadMoreRiwayatHistory != curr.canLoadMoreRiwayatHistory ||
          prev.riwayatHistoryList != curr.riwayatHistoryList,
      builder: (context, state) {
        return LoadMoreRefreshableList<RiwayatModel>(
          items: state.riwayatHistoryList,
          isLoading:
              state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory == 1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          onRefresh: () async =>
              context.read<MemberRiwayatProvider>().resetPageRiwayatHistory(),
          loadingWidget: const CardRiwayatTransaksiListShimmer(
            itemCount: 6,
            itemMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          ),
          itemBuilder: (context, item, index) {
            return CardRiwayatTransaksi(
              namaProduk: item.namaproduk,
              tujuan: item.tujuan,
              totalHarga: item.totalHargaFormatted,
              status: item.statusTrx,
              waktuTrx: DateHelper.tryParse(item.waktutrx) ?? DateTime.now(),
              imgProduk: item.imgproduk,
              onTap: () {
                Navigator.pop(context, item);
              },
            );
          },
          canLoadMore: state.canLoadMoreRiwayatHistory,
          isLoadingMore:
              state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory > 1,
          onLoadMore: () {
            context.read<MemberRiwayatProvider>().nextPageRiwayatHistory();
          },
          emptyTitle: "Belum ada riwayat",
          emptySubtitle: "Transaksi hari ini akan muncul disini",
        );
      },
    );
  }
}
