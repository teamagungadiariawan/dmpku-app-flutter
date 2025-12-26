import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_page.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi_shimmer.dart';
import 'package:dmpku/widgets/produk/grouped_refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiwayatListKemarin extends StatelessWidget {
  const RiwayatListKemarin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatHistoryStatus !=
              curr.apiFetchRiwayatHistoryStatus ||
          prev.canLoadMoreRiwayatHistory != curr.canLoadMoreRiwayatHistory ||
          prev.riwayatHistoryListGrouped != curr.riwayatHistoryListGrouped,
      builder: (context, state) {
        return GroupedRefreshableList<GroupedRiwayatModel, RiwayatModel>(
          groups: state.riwayatHistoryListGrouped.groupedRiwayatList,
          isLoading: state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory == 1,
          loadingWidget: const CardRiwayatTransaksiListShimmer(
            itemCount: 6,
            itemMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          ),
          getItems: (group) => group.riwayatList,
          onRefresh: () async =>
              context.read<MemberRiwayatProvider>().resetPageRiwayatHistory(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          groupHeaderBuilder: (context, group) {
            return Container(
              color: context.secondary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                getMemberDetailRiwayatProvider(context)
                    .setSelectedTransaksi(item, false);
              },
            );
          },
          canLoadMore: state.canLoadMoreRiwayatHistory,
          isLoadingMore: state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory > 1,
          onLoadMore: () {
            context.read<MemberRiwayatProvider>().nextPageRiwayatHistory();
          },
        );
      },
    );
  }
}
