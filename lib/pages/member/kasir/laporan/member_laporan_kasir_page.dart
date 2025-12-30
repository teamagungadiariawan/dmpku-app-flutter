import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/pages/member/kasir/laporan/widgets/filter_laporan_dialog.dart';
import 'package:dmpku/pages/member/kasir/laporan/widgets/laporan_kasir_item.dart';
import 'package:dmpku/pages/member/kasir/laporan/widgets/laporan_kasir_summary_cards.dart';
import 'package:dmpku/pages/member/kasir/laporan/widgets/laporan_kasir_table_header.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MemberLaporanKasirPage extends StatefulWidget {
  static const routeName = '/member/kasir/laporan';

  const MemberLaporanKasirPage({super.key});

  @override
  State<MemberLaporanKasirPage> createState() => _MemberLaporanKasirPageState();
}

class _MemberLaporanKasirPageState extends State<MemberLaporanKasirPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getKasirProvider(context).fetchLaporanKasir();
      getKasirProvider(context).fetchTotalLaporanKasir();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Laporan", onBackButtonPressed: pop),
        backgroundColor: bgScreen,
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<KasirProvider, KasirState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await getKasirProvider(context).fetchLaporanKasir();
                      await getKasirProvider(context).fetchTotalLaporanKasir();
                    },
                    child: Column(
                      children: [
                        _buildDateFilter(context, state),
                        _buildSummaryCards(state),
                        Expanded(child: _buildTableContainer(context, state)),
                        Gap(15),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter(BuildContext context, KasirState state) {
    final dateRange = DateHelper.joinDateRange(
      state.tanggalLaporanAwal!,
      state.tanggalLaporanAkhir!,
    );

    return Container(
      margin: paddingPage,
      padding: paddingCard,
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal",
                  style: context.bodySmall.withColor(context.mutedForeground),
                ),
                const Gap(4),
                Text(
                  dateRange,
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                ),
              ],
            ),
          ),
          const Gap(12),
          InkWell(
            onTap: () {
              FilterLaporanDialog.show(
                context,
                tanggalAwal: state.tanggalLaporanAwal,
                tanggalAkhir: state.tanggalLaporanAkhir,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    MdiIcons.filterVariant,
                    size: 18,
                    color: context.primaryForeground,
                  ),
                  const Gap(6),
                  Text(
                    "Filter",
                    style: context.bodyMedium
                        .withWeight(FontWeight.w600)
                        .withColor(context.primaryForeground),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(KasirState state) {
    int totalModal = 0;
    int totalPenjualan = 0;
    int totalLaba = 0;

    if (state.listTotalLaporanKasir.isNotEmpty) {
      final total = state.listTotalLaporanKasir.first;
      totalModal = total.jumlahmodal;
      totalPenjualan = total.jumlahbayar;
      totalLaba = total.laba;
    }

    return LaporanKasirSummaryCards(
      totalModal: totalModal,
      totalPenjualan: totalPenjualan,
      totalLaba: totalLaba,
    );
  }

  Widget _buildTableContainer(BuildContext context, KasirState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: context.border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const LaporanKasirTableHeader(),
          Expanded(child: _buildTransactionList(state)),
        ],
      ),
    );
  }

  Widget _buildTransactionList(KasirState state) {
    if (state.apiGetLaporanKasirStatus.isLoading) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.listLaporanKasir.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Text(
            "Tidak ada data laporan",
            style: context.bodyMedium.withColor(context.mutedForeground),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: state.listLaporanKasir.length,
      itemBuilder: (context, index) {
        final item = state.listLaporanKasir[index];
        return LaporanKasirItem(
          namaPelanggan: item.namapelanggan,
          waktu: item.waktutrx,
          qty: item.jumlahproduk,
          modal: item.jumlahmodal,
          jual: item.jumlahbayar,
          isOdd: index % 2 == 1,
        );
      },
    );
  }
}
