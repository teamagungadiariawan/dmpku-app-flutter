import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/jenis_filter_riwayat.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_mutasi_stok_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_rekap_transaksi_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_riwayat_history_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/filter_riwayat_today_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_active_filter_chip.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_filter_control_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiwayatFilterSection extends StatelessWidget {
  final int selectedTabIndex;

  const RiwayatFilterSection({
    super.key,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
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
                if (selectedTabIndex == 0) _filterTransaksiToday(context),
                if (selectedTabIndex == 1) _filterTransaksiHis(context),
                if (selectedTabIndex == 2) _filterMutasiStok(context),
                if (selectedTabIndex == 3) _filterRekapTransaksi(context),
              ],
            ),
          ),
        ),
        _buildKetFilter(context),
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
        return RiwayatFilterControlRow(
          labelTitle: "Periode Aktif",
          labelValue: "Hari Ini",
          isLoading: state.apiFetchRiwayatTodayStatus.isLoading &&
              state.pageRiwayatToday == 1,
          onFilter: () {
            FilterRiwayatTodayDialog.show(
              context,
              initialFilter: state.jenisFilterToday,
              initialSearch: state.kataKunciToday,
            );
          },
          onRefresh: () {
            getMemberRiwayatProvider(context).resetPageRiwayatToday();
          },
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
        return RiwayatFilterControlRow(
          labelTitle: "Periode Aktif",
          labelValue: DateHelper.joinDateRange(
            state.waktuAwalHistory!,
            state.waktuAkhirHistory!,
          ),
          isLoading: state.apiFetchRiwayatHistoryStatus.isLoading &&
              state.pageRiwayatHistory == 1,
          onFilter: () {
            FilterRiwayatHistoryDialog.show(
              context,
              initialFilter: state.jenisFilterHistory,
              initialSearch: state.kataKunciHistory,
              waktuAwal: state.waktuAwalHistory!,
              waktuAkhir: state.waktuAkhirHistory!,
            );
          },
          onRefresh: () {
            getMemberRiwayatProvider(context).resetPageRiwayatHistory();
          },
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
        return RiwayatFilterControlRow(
          labelTitle: "Periode Aktif",
          labelValue: DateHelper.joinDateRange(
            state.waktuAwalMutasiStok!,
            state.waktuAkhirMutasiStok!,
          ),
          isLoading: false, // Mutasi Stok usually managed inside list loader
          onFilter: () {
            FilterMutasiStokDialog.show(context);
          },
          onRefresh: () {
            getMemberRiwayatProvider(context).resetPageMutasiStok();
          },
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
        return RiwayatFilterControlRow(
          labelTitle: "Periode Aktif",
          labelValue:
              DateHelper.formatSimpleDate(state.waktuAwalRekapTransaksi!),
          isLoading: state.apiFetchRekapTransaksiStatus.isLoading,
          onFilter: () {
            FilterRekapTransaksiDialog.show(
              context,
              waktuAwal: state.waktuAwalRekapTransaksi,
              initialSearch: state.kataKunciRekapTransaksi,
            );
          },
          onRefresh: () {
            getMemberRiwayatProvider(context).fetchRekapTransaksi();
          },
        );
      },
    );
  }

  Widget _buildKetFilter(BuildContext context) {
    return BlocBuilder<MemberRiwayatProvider, MemberRiwayatState>(
      buildWhen: (prev, curr) {
        return prev.kataKunciToday != curr.kataKunciToday ||
            prev.kataKunciHistory != curr.kataKunciHistory ||
            prev.kataKunciMutasiStok != curr.kataKunciMutasiStok ||
            prev.jenisFilterToday != curr.jenisFilterToday ||
            prev.jenisFilterHistory != curr.jenisFilterHistory;
      },
      builder: (context, state) {
        // Today
        if (selectedTabIndex == 0 && state.kataKunciToday.isNotEmpty) {
          return RiwayatActiveFilterChip(
            label:
                "${state.jenisFilterToday.label} : \"${state.kataKunciToday}\"",
            onReset: () {
              getMemberRiwayatProvider(context).resetSearchRiwayatToday();
              getMemberRiwayatProvider(context).resetPageRiwayatToday();
            },
          );
        }
        // History
        if (selectedTabIndex == 1 && state.kataKunciHistory.isNotEmpty) {
          return RiwayatActiveFilterChip(
            label:
                "${state.jenisFilterHistory.label} : \"${state.kataKunciHistory}\"",
            onReset: () {
              getMemberRiwayatProvider(context).resetSearchRiwayatHistory();
              getMemberRiwayatProvider(context).resetPageRiwayatHistory();
            },
          );
        }
        // Mutasi Stok
        if (selectedTabIndex == 2 && state.kataKunciMutasiStok.isNotEmpty) {
          return RiwayatActiveFilterChip(
            label: "KET : \"${state.kataKunciMutasiStok}\"",
            onReset: () {
              getMemberRiwayatProvider(context).resetSearchMutasiStok();
              getMemberRiwayatProvider(context).resetPageMutasiStok();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
