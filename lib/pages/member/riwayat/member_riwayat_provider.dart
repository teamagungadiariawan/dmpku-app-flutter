import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/jenis_filter_riwayat.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/service/member/riwayat_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberRiwayatState extends Equatable {
  // Riwayat Today State

  // Transaksi Today API
  final ApiStatus apiFetchRiwayatTodayStatus;
  final String apiFetchRiwayatTodayMessage;
  final List<RiwayatModel> riwayatTodayList;
  final ListGroupedRiwayatResponse riwayatTodayListGrouped;
  final RiwayatModel selectedRiwayatToday;
  final bool canLoadMoreRiwayatToday;

  // Kata Kunci Today
  final JenisFilterRiwayat jenisFilterToday;
  final String kataKunciToday;
  final TextEditingController? kataKunciTodayController;
  final int pageRiwayatToday;

  // End Riwayat Today State

  // Riwayat History State

  // Transaksi History API
  final ApiStatus apiFetchRiwayatHistoryStatus;
  final String apiFetchRiwayatHistoryMessage;
  final List<RiwayatModel> riwayatHistoryList;
  final ListGroupedRiwayatResponse riwayatHistoryListGrouped;
  final RiwayatModel selectedRiwayatHistory;
  final bool canLoadMoreRiwayatHistory;

  // Kata Kunci History
  final DateTime? waktuAwalHistory;
  final DateTime? waktuAkhirHistory;
  final JenisFilterRiwayat jenisFilterHistory;
  final String kataKunciHistory;
  final TextEditingController? kataKunciHistoryController;
  final int pageRiwayatHistory;

  // End Riwayat History State

  // Mutasi Stok State

  // Mutasi Stok API
  final ApiStatus apiFetchMutasiStokStatus;
  final String apiFetchMutasiStokMessage;
  final List<MutasiSaldoModel> mutasiStokList;
  final bool canLoadMoreMutasiStok;

  // Kata Kunci Mutasi Stok
  final DateTime? waktuAwalMutasiStok;
  final DateTime? waktuAkhirMutasiStok;
  final String kataKunciMutasiStok;
  final TextEditingController? kataKunciMutasiStokController;
  final int pageMutasiStok;

  // End Mutasi Stok State

  // Rekap Transaksi State

  // Rekap Transaksi API
  final ApiStatus apiFetchRekapTransaksiStatus;
  final String apiFetchRekapTransaksiMessage;
  final List<RekapTransaksiModel> rekapTransaksiList;
  final int totalJumlahTrx;
  final int totalNominalTrx;

  // Kata Kunci Rekap Transaksi
  final DateTime? waktuAwalRekapTransaksi;
  final String kataKunciRekapTransaksi;
  final TextEditingController? kataKunciRekapTransaksiController;

  // End Rekap Transaksi State

  const MemberRiwayatState({
    // Riwayat Today State

    // Transaksi Today API
    this.apiFetchRiwayatTodayStatus = ApiStatus.initial,
    this.apiFetchRiwayatTodayMessage = '',
    this.riwayatTodayList = const [],
    this.riwayatTodayListGrouped = DEFAULT_LIST_GROUPED_RIWAYAT_RESPONSE,
    this.selectedRiwayatToday = DEFAULT_RIWAYAT_MODEL,
    this.canLoadMoreRiwayatToday = true,

    // Kata Kunci Today
    this.jenisFilterToday = JenisFilterRiwayat.tujuan,
    this.kataKunciToday = '',
    this.kataKunciTodayController,
    this.pageRiwayatToday = 1,

    // End Riwayat Today State

    // Riwayat History State

    // Transaksi History API
    this.apiFetchRiwayatHistoryStatus = ApiStatus.initial,
    this.apiFetchRiwayatHistoryMessage = '',
    this.riwayatHistoryList = const [],
    this.riwayatHistoryListGrouped = DEFAULT_LIST_GROUPED_RIWAYAT_RESPONSE,
    this.selectedRiwayatHistory = DEFAULT_RIWAYAT_MODEL,
    this.canLoadMoreRiwayatHistory = true,

    // Kata Kunci History
    this.waktuAwalHistory,
    this.waktuAkhirHistory,
    this.jenisFilterHistory = JenisFilterRiwayat.tujuan,
    this.kataKunciHistory = '',
    this.kataKunciHistoryController,
    this.pageRiwayatHistory = 1,

    // End Riwayat History State

    // Mutasi Stok State

    // Mutasi Stok API
    this.apiFetchMutasiStokStatus = ApiStatus.initial,
    this.apiFetchMutasiStokMessage = '',
    this.mutasiStokList = const [],
    this.canLoadMoreMutasiStok = true,

    // Kata Kunci Mutasi Stok
    this.waktuAwalMutasiStok,
    this.waktuAkhirMutasiStok,
    this.kataKunciMutasiStok = '',
    this.kataKunciMutasiStokController,
    this.pageMutasiStok = 1,

    // End Mutasi Stok State

    // Rekap Transaksi State

    // Rekap Transaksi API
    this.apiFetchRekapTransaksiStatus = ApiStatus.initial,
    this.apiFetchRekapTransaksiMessage = '',
    this.rekapTransaksiList = const [],
    this.totalJumlahTrx = 0,
    this.totalNominalTrx = 0,

    // Kata Kunci Rekap Transaksi
    this.waktuAwalRekapTransaksi,
    this.kataKunciRekapTransaksi = '',
    this.kataKunciRekapTransaksiController,

    // End Rekap Transaksi State
  });

  MemberRiwayatState copyWith({
    // Riwayat Today State

    // Transaksi Today API
    ApiStatus? apiFetchRiwayatTodayStatus,
    String? apiFetchRiwayatTodayMessage,
    List<RiwayatModel>? riwayatTodayList,
    ListGroupedRiwayatResponse? riwayatTodayListGrouped,
    RiwayatModel? selectedRiwayatToday,
    bool? canLoadMoreRiwayatToday,

    // Kata Kunci Today
    JenisFilterRiwayat? jenisFilterToday,
    String? kataKunciToday,
    TextEditingController? kataKunciTodayController,
    int? pageRiwayatToday,

    // Riwayat History State

    // Transaksi History API
    ApiStatus? apiFetchRiwayatHistoryStatus,
    String? apiFetchRiwayatHistoryMessage,
    List<RiwayatModel>? riwayatHistoryList,
    ListGroupedRiwayatResponse? riwayatHistoryListGrouped,
    RiwayatModel? selectedRiwayatHistory,
    bool? canLoadMoreRiwayatHistory,

    // Kata Kunci History
    DateTime? waktuAwalHistory,
    DateTime? waktuAkhirHistory,
    JenisFilterRiwayat? jenisFilterHistory,
    String? kataKunciHistory,
    TextEditingController? kataKunciHistoryController,
    int? pageRiwayatHistory,

    // Mutasi Stok State

    // Mutasi Stok API
    ApiStatus? apiFetchMutasiStokStatus,
    String? apiFetchMutasiStokMessage,
    List<MutasiSaldoModel>? mutasiStokList,
    bool? canLoadMoreMutasiStok,

    // Kata Kunci Mutasi Stok
    DateTime? waktuAwalMutasiStok,
    DateTime? waktuAkhirMutasiStok,
    String? kataKunciMutasiStok,
    TextEditingController? kataKunciMutasiStokController,
    int? pageMutasiStok,

    // Rekap Transaksi State

    // Rekap Transaksi API
    ApiStatus? apiFetchRekapTransaksiStatus,
    String? apiFetchRekapTransaksiMessage,
    List<RekapTransaksiModel>? rekapTransaksiList,
    int? totalJumlahTrx,
    int? totalNominalTrx,

    // Kata Kunci Rekap Transaksi
    DateTime? waktuAwalRekapTransaksi,
    String? kataKunciRekapTransaksi,
    TextEditingController? kataKunciRekapTransaksiController,
  }) {
    return MemberRiwayatState(
      // Riwayat Today State

      // Transaksi Today API
      apiFetchRiwayatTodayStatus:
          apiFetchRiwayatTodayStatus ?? this.apiFetchRiwayatTodayStatus,
      apiFetchRiwayatTodayMessage:
          apiFetchRiwayatTodayMessage ?? this.apiFetchRiwayatTodayMessage,
      riwayatTodayList: riwayatTodayList ?? this.riwayatTodayList,
      riwayatTodayListGrouped:
          riwayatTodayListGrouped ?? this.riwayatTodayListGrouped,
      selectedRiwayatToday: selectedRiwayatToday ?? this.selectedRiwayatToday,
      canLoadMoreRiwayatToday:
          canLoadMoreRiwayatToday ?? this.canLoadMoreRiwayatToday,

      // Kata Kunci Today
      jenisFilterToday: jenisFilterToday ?? this.jenisFilterToday,
      kataKunciToday: kataKunciToday ?? this.kataKunciToday,
      kataKunciTodayController:
          kataKunciTodayController ?? this.kataKunciTodayController,
      pageRiwayatToday: pageRiwayatToday ?? this.pageRiwayatToday,

      // Riwayat History State

      // Transaksi History API
      apiFetchRiwayatHistoryStatus:
          apiFetchRiwayatHistoryStatus ?? this.apiFetchRiwayatHistoryStatus,
      apiFetchRiwayatHistoryMessage:
          apiFetchRiwayatHistoryMessage ?? this.apiFetchRiwayatHistoryMessage,
      riwayatHistoryList: riwayatHistoryList ?? this.riwayatHistoryList,
      riwayatHistoryListGrouped:
          riwayatHistoryListGrouped ?? this.riwayatHistoryListGrouped,
      selectedRiwayatHistory:
          selectedRiwayatHistory ?? this.selectedRiwayatHistory,
      canLoadMoreRiwayatHistory:
          canLoadMoreRiwayatHistory ?? this.canLoadMoreRiwayatHistory,

      // Kata Kunci History
      waktuAwalHistory: waktuAwalHistory ?? this.waktuAwalHistory,
      waktuAkhirHistory: waktuAkhirHistory ?? this.waktuAkhirHistory,
      jenisFilterHistory: jenisFilterHistory ?? this.jenisFilterHistory,
      kataKunciHistory: kataKunciHistory ?? this.kataKunciHistory,
      kataKunciHistoryController:
          kataKunciHistoryController ?? this.kataKunciHistoryController,
      pageRiwayatHistory: pageRiwayatHistory ?? this.pageRiwayatHistory,

      // Mutasi Stok State

      // Mutasi Stok API
      apiFetchMutasiStokStatus:
          apiFetchMutasiStokStatus ?? this.apiFetchMutasiStokStatus,
      apiFetchMutasiStokMessage:
          apiFetchMutasiStokMessage ?? this.apiFetchMutasiStokMessage,
      mutasiStokList: mutasiStokList ?? this.mutasiStokList,
      canLoadMoreMutasiStok:
          canLoadMoreMutasiStok ?? this.canLoadMoreMutasiStok,

      // Kata Kunci Mutasi Stok
      waktuAwalMutasiStok: waktuAwalMutasiStok ?? this.waktuAwalMutasiStok,
      waktuAkhirMutasiStok: waktuAkhirMutasiStok ?? this.waktuAkhirMutasiStok,
      kataKunciMutasiStok: kataKunciMutasiStok ?? this.kataKunciMutasiStok,
      kataKunciMutasiStokController:
          kataKunciMutasiStokController ?? this.kataKunciMutasiStokController,
      pageMutasiStok: pageMutasiStok ?? this.pageMutasiStok,

      // Rekap Transaksi State

      // Rekap Transaksi API
      apiFetchRekapTransaksiStatus:
          apiFetchRekapTransaksiStatus ?? this.apiFetchRekapTransaksiStatus,
      apiFetchRekapTransaksiMessage:
          apiFetchRekapTransaksiMessage ?? this.apiFetchRekapTransaksiMessage,
      rekapTransaksiList: rekapTransaksiList ?? this.rekapTransaksiList,
      totalJumlahTrx: totalJumlahTrx ?? this.totalJumlahTrx,
      totalNominalTrx: totalNominalTrx ?? this.totalNominalTrx,

      // Kata Kunci Rekap Transaksi
      waktuAwalRekapTransaksi:
          waktuAwalRekapTransaksi ?? this.waktuAwalRekapTransaksi,
      kataKunciRekapTransaksi:
          kataKunciRekapTransaksi ?? this.kataKunciRekapTransaksi,
      kataKunciRekapTransaksiController:
          kataKunciRekapTransaksiController ??
          this.kataKunciRekapTransaksiController,
    );
  }

  @override
  List<Object?> get props => [
    // Riwayat Today State

    // Transaksi Today API
    apiFetchRiwayatTodayStatus,
    apiFetchRiwayatTodayMessage,
    riwayatTodayList,
    riwayatTodayListGrouped,
    selectedRiwayatToday,
    canLoadMoreRiwayatToday,

    // Kata Kunci Today
    jenisFilterToday,
    kataKunciToday,
    kataKunciTodayController,
    pageRiwayatToday,

    // Riwayat History State

    // Transaksi History API
    apiFetchRiwayatHistoryStatus,
    apiFetchRiwayatHistoryMessage,
    riwayatHistoryList,
    riwayatHistoryListGrouped,
    selectedRiwayatHistory,
    canLoadMoreRiwayatHistory,

    // Kata Kunci History
    waktuAwalHistory,
    waktuAkhirHistory,
    jenisFilterHistory,
    kataKunciHistory,
    kataKunciHistoryController,
    pageRiwayatHistory,

    // Mutasi Stok State

    // Mutasi Stok API
    apiFetchMutasiStokStatus,
    apiFetchMutasiStokMessage,
    mutasiStokList,
    canLoadMoreMutasiStok,

    // Kata Kunci Mutasi Stok
    waktuAwalMutasiStok,
    waktuAkhirMutasiStok,
    kataKunciMutasiStok,
    kataKunciMutasiStokController,
    pageMutasiStok,

    // Rekap Transaksi State

    // Rekap Transaksi API
    apiFetchRekapTransaksiStatus,
    apiFetchRekapTransaksiMessage,
    rekapTransaksiList,
    totalJumlahTrx,
    totalNominalTrx,

    // Kata Kunci Rekap Transaksi
    waktuAwalRekapTransaksi,
    kataKunciRekapTransaksi,
    kataKunciRekapTransaksiController,
  ];
}

class MemberRiwayatProvider extends Cubit<MemberRiwayatState> {
  final RiwayatService _riwayatService = RiwayatService();

  @override
  Future<void> close() {
    state.kataKunciTodayController?.dispose();
    state.kataKunciHistoryController?.dispose();
    state.kataKunciMutasiStokController?.dispose();
    state.kataKunciRekapTransaksiController?.dispose();
    return super.close();
  }

  MemberRiwayatProvider()
    : super(
        MemberRiwayatState(
          kataKunciTodayController: TextEditingController(),
          kataKunciHistoryController: TextEditingController(),
          waktuAwalHistory: DateTime.now().subtract(const Duration(days: 4)),
          waktuAkhirHistory: DateTime.now().subtract(const Duration(days: 1)),

          kataKunciMutasiStokController: TextEditingController(),
          kataKunciRekapTransaksiController: TextEditingController(),

          waktuAwalMutasiStok: DateTime.now().subtract(const Duration(days: 4)),
          waktuAkhirMutasiStok: DateTime.now(),
          waktuAwalRekapTransaksi: DateTime.now().subtract(
            const Duration(days: 3),
          ),
        ),
      );

  // ============================================================
  // Riwayat Today
  // API CALLS
  // ============================================================

  Future<void> fetchRiwayatToday() async {
    if (state.apiFetchRiwayatTodayStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchRiwayatTodayStatus: ApiStatus.loading,
        apiFetchRiwayatTodayMessage: '',
      ),
    );

    try {
      final result = await _riwayatService.getRiwayatToday(
        tujuan: state.jenisFilterToday.isTujuan ? state.kataKunciToday : '',
        kodeproduk: state.jenisFilterToday.isKodeProduk
            ? state.kataKunciToday
            : '',
        namaproduk: state.jenisFilterToday.isNamaProduk
            ? state.kataKunciToday
            : '',
        page: state.pageRiwayatToday,
      );
      final data = result.data;

      if (data != null) {
        List<RiwayatModel> updatedList = [];

        if (data.riwayatList.isEmpty) {
          emit(state.copyWith(canLoadMoreRiwayatToday: false));
        } else {
          if (state.pageRiwayatToday == 1) {
            updatedList = List.from(data.riwayatList);
          } else {
            updatedList = List<RiwayatModel>.from(state.riwayatTodayList)
              ..addAll(data.riwayatList);
          }

          emit(
            state.copyWith(
              canLoadMoreRiwayatToday: data.riwayatList.length >= 20,
              riwayatTodayList: updatedList,
            ),
          );
        }

        emit(state.copyWith(apiFetchRiwayatTodayStatus: ApiStatus.success));
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH RIWAYAT TODAY: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchRiwayatTodayStatus: ApiStatus.failure,
          apiFetchRiwayatTodayMessage: e.message,
        ),
      );
    }
  }

  // ============================================================
  // Riwayat Today
  // Paging
  // ============================================================

  void nextPageRiwayatToday() {
    emit(state.copyWith(pageRiwayatToday: state.pageRiwayatToday + 1));
    fetchRiwayatToday();
  }

  void resetPageRiwayatToday() {
    emit(state.copyWith(pageRiwayatToday: 1, riwayatTodayList: []));
    fetchRiwayatToday();
  }

  void resetSearchRiwayatToday() {
    emit(
      state.copyWith(
        kataKunciToday: '',
        jenisFilterToday: JenisFilterRiwayat.tujuan,
      ),
    );
    _updateController(state.kataKunciTodayController, '');
  }

  // ============================================================
  // Riwayat Today
  // SETTERS
  // ============================================================

  void setJenisFilterToday(JenisFilterRiwayat jenisFilter) {
    emit(state.copyWith(jenisFilterToday: jenisFilter));
  }

  void setKataKunciToday(String kataKunci, {bool updateController = false}) {
    emit(state.copyWith(kataKunciToday: kataKunci));

    if (updateController) {
      _updateController(state.kataKunciTodayController, kataKunci);
    }
  }

  // ============================================================
  // Riwayat History
  // API CALLS
  // ============================================================

  Future<void> fetchRiwayatHistory() async {
    if (state.apiFetchRiwayatHistoryStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchRiwayatHistoryStatus: ApiStatus.loading,
        apiFetchRiwayatHistoryMessage: '',
      ),
    );

    try {
      final result = await _riwayatService.getRiwayatHistory(
        waktuawal: DateHelper.formatDate(state.waktuAwalHistory!),
        waktuakhir: DateHelper.formatDate(state.waktuAkhirHistory!),
        tujuan: state.jenisFilterHistory.isTujuan ? state.kataKunciHistory : '',
        kodeproduk: state.jenisFilterHistory.isKodeProduk
            ? state.kataKunciHistory
            : '',
        namaproduk: state.jenisFilterHistory.isNamaProduk
            ? state.kataKunciHistory
            : '',
        page: state.pageRiwayatHistory,
      );
      final data = result.data;

      if (data != null) {
        List<RiwayatModel> updatedList = [];
        bool canLoadMore = state.canLoadMoreRiwayatHistory;

        // 1. LOGIC PENGGABUNGAN LIST (FLAT)
        if (data.riwayatList.isEmpty) {
          if (state.pageRiwayatHistory > 1) {
            // Kalau page > 1 dan kosong, berarti data habis
            canLoadMore = data.riwayatList.length >= 20;
            updatedList = state.riwayatHistoryList; // Pakai data lama
          } else {
            // Kalau page 1 dan kosong, berarti emang gak ada data
            updatedList = [];
          }
        } else {
          // Kalau ada data
          canLoadMore = data.riwayatList.length >= 20;
          if (state.pageRiwayatHistory == 1) {
            updatedList = List.from(data.riwayatList);
          } else {
            updatedList = List<RiwayatModel>.from(state.riwayatHistoryList)
              ..addAll(data.riwayatList);
          }
        }

        // 2. GENERATE GROUPED LIST
        // Kita bungkus updatedList ke ListRiwayatResponse agar bisa dimakan factory grouped
        final groupedData = ListGroupedRiwayatResponse.fromListRiwayatResponse(
          ListRiwayatResponse(riwayatList: updatedList),
        );

        // 3. EMIT STATE
        emit(
          state.copyWith(
            apiFetchRiwayatHistoryStatus: ApiStatus.success,
            canLoadMoreRiwayatHistory: canLoadMore,
            riwayatHistoryList: updatedList,
            // Simpan Flat List (Penting buat next page)
            riwayatHistoryListGrouped:
                groupedData, // Simpan Grouped List (Buat UI)
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH RIWAYAT HISTORY: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchRiwayatHistoryStatus: ApiStatus.failure,
          apiFetchRiwayatHistoryMessage: e.message,
        ),
      );
    }
  }

  // ============================================================
  // Riwayat History
  // Paging
  // ============================================================

  void nextPageRiwayatHistory() {
    emit(state.copyWith(pageRiwayatHistory: state.pageRiwayatHistory + 1));
    fetchRiwayatHistory();
  }

  void resetPageRiwayatHistory() {
    emit(state.copyWith(pageRiwayatHistory: 1));
    fetchRiwayatHistory();
  }

  void resetSearchRiwayatHistory() {
    emit(
      state.copyWith(
        waktuAwalHistory: DateTime.now().subtract(const Duration(days: 4)),
        waktuAkhirHistory: DateTime.now().subtract(const Duration(days: 1)),
        kataKunciHistory: '',
        jenisFilterHistory: JenisFilterRiwayat.tujuan,
      ),
    );
    _updateController(state.kataKunciHistoryController, '');
  }

  // ============================================================
  // Riwayat History
  // SETTERS
  // ============================================================

  void setJenisFilterHistory(JenisFilterRiwayat jenisFilter) {
    emit(state.copyWith(jenisFilterHistory: jenisFilter));
  }

  void setKataKunciHistory(String kataKunci, {bool updateController = false}) {
    emit(state.copyWith(kataKunciHistory: kataKunci));

    if (updateController) {
      _updateController(state.kataKunciHistoryController, kataKunci);
    }
  }

  void setRangeWaktu(DateTime awal, DateTime akhir) {
    emit(state.copyWith(waktuAwalHistory: awal, waktuAkhirHistory: akhir));

    validateWaktuRange();
  }

  void setWaktuAwalHistory(DateTime waktuAwal) {
    emit(
      state.copyWith(
        waktuAwalHistory: waktuAwal,
        waktuAkhirHistory: waktuAwal.add(const Duration(days: 3)),
      ),
    );

    validateWaktuRange();
  }

  void setWaktuAkhirHistory(DateTime waktuAkhir) {
    emit(state.copyWith(waktuAkhirHistory: waktuAkhir));

    validateWaktuRange();
  }

  // ============================================================
  // Riwayat History
  // VALIDATORS
  // ============================================================

  bool validateWaktuRange() {
    if (state.waktuAwalHistory != null && state.waktuAkhirHistory != null) {
      final difference = state.waktuAkhirHistory!
          .difference(state.waktuAwalHistory!)
          .inDays;

      if (difference < 0) {
        showWarningMessage("Waktu Akhir tidak boleh sebelum Waktu Awal.");
        return false;
      } else if (difference > 7) {
        showWarningMessage("Rentang waktu maksimal adalah 7 hari.");
        return false;
      }
    }
    return true;
  }

  // ============================================================
  // Mutasi Stok
  // API CALLS
  // ============================================================

  Future<void> fetchMutasiStok() async {
    if (state.apiFetchMutasiStokStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchMutasiStokStatus: ApiStatus.loading,
        apiFetchMutasiStokMessage: '',
      ),
    );

    try {
      final result = await _riwayatService.getMutasiSaldo(
        tujuan: state.kataKunciMutasiStok,
        waktuawal: DateHelper.formatDate(state.waktuAwalMutasiStok!),
        waktuakhir: DateHelper.formatDate(state.waktuAkhirMutasiStok!),
        page: state.pageMutasiStok,
      );
      final data = result.data;

      if (data != null) {
        List<MutasiSaldoModel> updatedList = [];

        if (data.mutasiSaldoList.isEmpty) {
          emit(state.copyWith(canLoadMoreMutasiStok: false));
        } else {
          if (state.pageMutasiStok == 1) {
            updatedList = List.from(data.mutasiSaldoList);
          } else {
            updatedList = List<MutasiSaldoModel>.from(state.mutasiStokList)
              ..addAll(data.mutasiSaldoList);
          }

          emit(
            state.copyWith(
              canLoadMoreMutasiStok: data.mutasiSaldoList.length >= 30,
              mutasiStokList: updatedList,
            ),
          );
        }

        emit(state.copyWith(apiFetchMutasiStokStatus: ApiStatus.success));
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH MUTASI STOK: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchMutasiStokStatus: ApiStatus.failure,
          apiFetchMutasiStokMessage: e.message,
        ),
      );
    }
  }

  // ============================================================
  // Mutasi Stok
  // Paging
  // ============================================================

  void nextPageMutasiStok() {
    emit(state.copyWith(pageMutasiStok: state.pageMutasiStok + 1));
    fetchMutasiStok();
  }

  void resetPageMutasiStok() {
    emit(state.copyWith(pageMutasiStok: 1));
    fetchMutasiStok();
  }

  void resetSearchMutasiStok() {
    emit(
      state.copyWith(
        kataKunciMutasiStok: '',
        waktuAwalMutasiStok: DateTime.now().subtract(const Duration(days: 4)),
        waktuAkhirMutasiStok: DateTime.now(),
      ),
    );
    _updateController(state.kataKunciMutasiStokController, '');
  }

  // ============================================================
  // Mutasi Stok
  // SETTERS
  // ============================================================

  void setKataKunciMutasiStok(
    String kataKunci, {
    bool updateController = false,
  }) {
    emit(state.copyWith(kataKunciMutasiStok: kataKunci));

    if (updateController) {
      _updateController(state.kataKunciMutasiStokController, kataKunci);
    }
  }

  void setWaktuAwalMutasiStok(DateTime waktuAwal) {
    emit(
      state.copyWith(
        waktuAwalMutasiStok: waktuAwal,
        waktuAkhirMutasiStok: waktuAwal.add(const Duration(days: 2)),
      ),
    );

    validateWaktuRangeMutasiStok();
  }

  void setWaktuAkhirMutasiStok(DateTime waktuAkhir) {
    emit(state.copyWith(waktuAkhirMutasiStok: waktuAkhir));

    validateWaktuRangeMutasiStok();
  }

  void setRangeWaktuMutasiStok(DateTime awal, DateTime akhir) {
    emit(
      state.copyWith(waktuAwalMutasiStok: awal, waktuAkhirMutasiStok: akhir),
    );

    validateWaktuRangeMutasiStok();
  }

  // ============================================================
  // Mutasi Stok
  // VALIDATORS
  // ============================================================

  bool validateWaktuRangeMutasiStok() {
    if (state.waktuAwalMutasiStok != null &&
        state.waktuAkhirMutasiStok != null) {
      final difference = state.waktuAkhirMutasiStok!
          .difference(state.waktuAwalMutasiStok!)
          .inDays;

      if (difference < 0) {
        showWarningMessage("Waktu Akhir tidak boleh sebelum Waktu Awal.");
        return false;
      } else if (difference > 7) {
        showWarningMessage("Rentang waktu maksimal adalah 7 hari.");
        return false;
      }
    }
    return true;
  }

  // ============================================================
  // Rekap Transaksi
  // API CALLS
  // ============================================================

  Future<void> fetchRekapTransaksi() async {
    if (state.apiFetchRekapTransaksiStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchRekapTransaksiStatus: ApiStatus.loading,
        apiFetchRekapTransaksiMessage: '',
      ),
    );

    try {
      final result = await _riwayatService.getRekapTransaksi(
        waktu: DateHelper.formatDate(state.waktuAwalRekapTransaksi!),
        tujuan: state.kataKunciRekapTransaksi,
        page: 1,
      );
      final data = result.data;

      if (data != null) {
        var totalJumlahTrx = 0;
        var totalNominalTrx = 0;

        for (var item in data.rekapTransaksiList) {
          totalJumlahTrx += item.jumlahtrx;
          totalNominalTrx += item.totaldebet;
        }

        emit(
          state.copyWith(
            apiFetchRekapTransaksiStatus: ApiStatus.success,
            rekapTransaksiList: data.rekapTransaksiList,
            totalJumlahTrx: totalJumlahTrx,
            totalNominalTrx: totalNominalTrx,
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH REKAP TRANSAKSI: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchRekapTransaksiStatus: ApiStatus.failure,
          apiFetchRekapTransaksiMessage: e.message,
        ),
      );
    }
  }

  // ============================================================
  // Rekap Transaksi
  // SETTERS
  // ============================================================

  void setKataKunciRekapTransaksi(
    String kataKunci, {
    bool updateController = false,
  }) {
    emit(state.copyWith(kataKunciRekapTransaksi: kataKunci));

    if (updateController) {
      _updateController(state.kataKunciRekapTransaksiController, kataKunci);
    }
  }

  void setWaktuAwalRekapTransaksi(DateTime waktuAwal) {
    emit(state.copyWith(waktuAwalRekapTransaksi: waktuAwal));

    validateWaktuRangeRekapTransaksi();
  }

  void resetSearchRekapTransaksi() {
    emit(
      state.copyWith(
        kataKunciRekapTransaksi: '',
        waktuAwalRekapTransaksi: DateTime.now(),
      ),
    );
    _updateController(state.kataKunciRekapTransaksiController, '');
  }

  // ============================================================
  // Rekap Transaksi
  // VALIDATORS
  // ============================================================

  bool validateWaktuRangeRekapTransaksi() {
    if (state.waktuAwalRekapTransaksi != null) {
      final difference = DateTime.now()
          .difference(state.waktuAwalRekapTransaksi!)
          .inDays;

      // Note: Di kode awal kamu tertulis > 1 tapi pesannya "maksimal 7 hari".
      // Gue tetep ikutin logic > 1 sesuai code asal, tapi pastiin ini udah bener ya.
      if (difference > 31) {
        // Contoh kalau mau sebulan, atau sesuaikan kebutuhan.
        showWarningMessage("Rentang waktu maksimal adalah 7 hari.");
        return false;
      }
    }
    return true;
  }

  // ============================================================
  // Global SETTERS
  // ============================================================

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }
}

MemberRiwayatProvider getMemberRiwayatProvider(BuildContext context) {
  return context.read<MemberRiwayatProvider>();
}
