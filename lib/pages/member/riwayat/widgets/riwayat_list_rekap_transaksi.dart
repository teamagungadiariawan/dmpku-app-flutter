import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/item_rekap_transaksi.dart';
import 'package:dmpku/pages/member/riwayat/widgets/item_rekap_transaksi_shimmer.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_table_header.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiwayatListRekapTransaksi extends StatelessWidget {
  const RiwayatListRekapTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: context.border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const RiwayatTableHeader(
            columns: [
              {'label': 'No', 'width': 30.0, 'align': TextAlign.start},
              {'label': 'Produk', 'flex': true, 'align': TextAlign.start},
              {'label': 'Jml trx', 'width': 100.0, 'align': TextAlign.end},
              {'label': 'Total', 'width': 100.0, 'align': TextAlign.end},
            ],
          ),
          Expanded(
            child: BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
              buildWhen: (prev, curr) =>
                  prev.apiFetchRekapTransaksiStatus !=
                      curr.apiFetchRekapTransaksiStatus ||
                  prev.rekapTransaksiList != curr.rekapTransaksiList,
              builder: (context, state) {
                return LoadMoreRefreshableList<RekapTransaksiModel>(
                  padding: EdgeInsets.zero,
                  isLoading: state.apiFetchRekapTransaksiStatus.isLoading,
                  loadingWidget:
                      const ItemRekapTransaksiListShimmer(itemCount: 6),
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
          BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
            buildWhen: (prev, curr) =>
                prev.totalJumlahTrx != curr.totalJumlahTrx ||
                prev.totalNominalTrx != curr.totalNominalTrx,
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.card,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(12)),
                  border:
                      Border(top: BorderSide(color: context.border, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Total",
                        style: context.bodySmall.withWeight(FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        ToCurrency(state.totalJumlahTrx.toString()),
                        textAlign: TextAlign.end,
                        style: context.bodySmall.withColor(context.primary),
                      ),
                    ),
                    SizedBox(
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
}
