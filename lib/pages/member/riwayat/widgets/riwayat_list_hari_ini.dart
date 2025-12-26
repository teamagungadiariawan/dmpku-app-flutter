import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_page.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi.dart';
import 'package:dmpku/pages/member/riwayat/widgets/card_riwayat_transaksi_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiwayatListHariIni extends StatelessWidget {
  const RiwayatListHariIni({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) =>
          prev.apiFetchRiwayatTodayStatus != curr.apiFetchRiwayatTodayStatus ||
          prev.canLoadMoreRiwayatToday != curr.canLoadMoreRiwayatToday ||
          prev.riwayatTodayList != curr.riwayatTodayList,
      builder: (context, state) {
        return LoadMoreRefreshableList<RiwayatModel>(
          items: state.riwayatTodayList,
          isLoading: state.apiFetchRiwayatTodayStatus.isLoading &&
              state.pageRiwayatToday == 1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          onRefresh: () async =>
              context.read<MemberRiwayatProvider>().resetPageRiwayatToday(),
          loadingWidget: const CardRiwayatTransaksiListShimmer(
            itemCount: 6,
            itemMargin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                pushNamed(MemberDetailRiwayatPage.routeName);
                getMemberDetailRiwayatProvider(context)
                    .setSelectedTransaksi(item, true);
              },
            );
          },
          canLoadMore: state.canLoadMoreRiwayatToday,
          isLoadingMore: state.apiFetchRiwayatTodayStatus.isLoading &&
              state.pageRiwayatToday > 1,
          onLoadMore: () {
            context.read<MemberRiwayatProvider>().nextPageRiwayatToday();
          },
        );
      },
    );
  }
}
