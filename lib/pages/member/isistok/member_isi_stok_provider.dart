import 'dart:async';

import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/bank_transfer_response.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/alfamart/detail_tiket_alfamart_page.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/detail_tiket_bank_transfer_page.dart';
import 'package:dmpku/pages/member/isistok/indomaret/detail_tiket_indomaret_page.dart';
import 'package:dmpku/pages/member/isistok/qris/detail_tiket_qris_page.dart';
import 'package:dmpku/pages/member/isistok/va/detail_tiket_va_page.dart';
import 'package:dmpku/service/member/deposit_service.dart';
import 'package:dmpku/model/mutasi_deposit_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberIsiStokState extends Equatable {
  final FocusNode? focusNodeNominal;
  final Duration tiketDuration;

  // ==========================================
  // 1. BANK TRANSFER STATE
  // ==========================================
  final ApiStatus apiGetListProviderStatus;
  final String apiGetListProviderMessage;
  final List<BankTransferModel> listBankTransfer;

  final ApiStatus apiBuatTiketBankStatus;
  final String apiBuatTiketBankMessage;

  final ApiStatus apiRiwayatTiketBankStatus;
  final String apiRiwayatTiketBankMessage;
  final List<RiwayatTiketBankModel> listRiwayatTiketBank;
  final RiwayatTiketBankModel selectedRiwayatTiket;

  // ==========================================
  // 2. VIRTUAL ACCOUNT (VA) STATE
  // ==========================================
  final ApiStatus apiGetListVaStatus;
  final String apiGetListVaMessage;
  final List<VaBankModel> listVaBank;

  final ApiStatus apiBuatVaStatus;
  final String apiBuatVaMessage;

  final ApiStatus apiRiwayatVaStatus;
  final String apiRiwayatVaMessage;
  final List<RiwayatTiketVAModel> listRiwayatVa;
  final RiwayatTiketVAModel selectedRiwayatVa;

  // ==========================================
  // 3. ALFAMART STATE
  // ==========================================
  final ApiStatus apiBuatAlfamartStatus;
  final String apiBuatAlfamartMessage;

  final ApiStatus apiRiwayatAlfamartStatus;
  final String apiRiwayatAlfamartMessage;
  final List<RiwayatTiketAlfamartModel> listRiwayatAlfamart;
  final RiwayatTiketAlfamartModel selectedRiwayatAlfamart;

  // ==========================================
  // 4. INDOMARET STATE
  // ==========================================
  final ApiStatus apiBuatIndomaretStatus;
  final String apiBuatIndomaretMessage;

  final ApiStatus apiRiwayatIndomaretStatus;
  final String apiRiwayatIndomaretMessage;
  final List<RiwayatTiketIndomaretModel> listRiwayatIndomaret;
  final RiwayatTiketIndomaretModel selectedRiwayatIndomaret;

  // ==========================================
  // 5. QRIS STATE
  // ==========================================
  final ApiStatus apiBuatQrisStatus;
  final String apiBuatQrisMessage;

  final ApiStatus apiRiwayatQrisStatus;
  final String apiRiwayatQrisMessage;
  final List<RiwayatTiketQRISModel> listRiwayatQris;
  final RiwayatTiketQRISModel selectedRiwayatQris;

  // ==========================================
  // 6. MUTASI DEPOSIT STATE
  // ==========================================
  final ApiStatus apiMutasiStatus;
  final String apiMutasiMessage;
  final List<MutasiDepositModel> listMutasiDeposit;
  final ListGroupedMutasiDepositResponse listMutasiDepositGrouped;
  final bool hasMoreMutasi;
  final int pageMutasi;
  final DateTime? dateStartFilter;
  final DateTime? dateEndFilter;

  const MemberIsiStokState({
    this.focusNodeNominal,
    this.tiketDuration = const Duration(seconds: -1),

    // Bank Transfer Defaults
    this.apiGetListProviderStatus = ApiStatus.initial,
    this.apiGetListProviderMessage = '',
    this.listBankTransfer = const [],
    this.apiBuatTiketBankStatus = ApiStatus.initial,
    this.apiBuatTiketBankMessage = '',
    this.apiRiwayatTiketBankStatus = ApiStatus.initial,
    this.apiRiwayatTiketBankMessage = '',
    this.listRiwayatTiketBank = const [],
    this.selectedRiwayatTiket = DEFAULT_RIWAYAT_TIKET_BANK_MODEL,

    // VA Defaults
    this.apiGetListVaStatus = ApiStatus.initial,
    this.apiGetListVaMessage = '',
    this.listVaBank = const [],
    this.apiBuatVaStatus = ApiStatus.initial,
    this.apiBuatVaMessage = '',
    this.apiRiwayatVaStatus = ApiStatus.initial,
    this.apiRiwayatVaMessage = '',
    this.listRiwayatVa = const [],
    this.selectedRiwayatVa = DEFAULT_RIWAYAT_TIKET_VA,

    // Alfamart Defaults
    this.apiBuatAlfamartStatus = ApiStatus.initial,
    this.apiBuatAlfamartMessage = '',
    this.apiRiwayatAlfamartStatus = ApiStatus.initial,
    this.apiRiwayatAlfamartMessage = '',
    this.listRiwayatAlfamart = const [],
    this.selectedRiwayatAlfamart = DEFAULT_RIWAYAT_TIKET_ALFAMART,

    // Indomaret Defaults
    this.apiBuatIndomaretStatus = ApiStatus.initial,
    this.apiBuatIndomaretMessage = '',
    this.apiRiwayatIndomaretStatus = ApiStatus.initial,
    this.apiRiwayatIndomaretMessage = '',
    this.listRiwayatIndomaret = const [],
    this.selectedRiwayatIndomaret = DEFAULT_RIWAYAT_TIKET_INDOMARET,

    // QRIS Defaults
    this.apiBuatQrisStatus = ApiStatus.initial,
    this.apiBuatQrisMessage = '',
    this.apiRiwayatQrisStatus = ApiStatus.initial,
    this.apiRiwayatQrisMessage = '',
    this.listRiwayatQris = const [],
    this.selectedRiwayatQris = DEFAULT_RIWAYAT_TIKET_QRIS,

    // Mutasi Defaults
    this.apiMutasiStatus = ApiStatus.initial,
    this.apiMutasiMessage = '',
    this.listMutasiDeposit = const [],
    this.listMutasiDepositGrouped =
        DEFAULT_LIST_GROUPED_MUTASI_DEPOSIT_RESPONSE,
    this.hasMoreMutasi = true,
    this.pageMutasi = 1,
    this.dateStartFilter,
    this.dateEndFilter,
  });

  MemberIsiStokState copyWith({
    FocusNode? focusNodeNominal,
    Duration? tiketDuration,

    // Bank Transfer Params
    ApiStatus? apiGetListProviderStatus,
    String? apiGetListProviderMessage,
    List<BankTransferModel>? listBankTransfer,
    ApiStatus? apiBuatTiketBankStatus,
    String? apiBuatTiketBankMessage,
    ApiStatus? apiRiwayatTiketBankStatus,
    String? apiRiwayatTiketBankMessage,
    List<RiwayatTiketBankModel>? listRiwayatTiketBank,
    RiwayatTiketBankModel? selectedRiwayatTiket,

    // VA Params
    ApiStatus? apiGetListVaStatus,
    String? apiGetListVaMessage,
    List<VaBankModel>? listVaBank,
    ApiStatus? apiBuatVaStatus,
    String? apiBuatVaMessage,
    ApiStatus? apiRiwayatVaStatus,
    String? apiRiwayatVaMessage,
    List<RiwayatTiketVAModel>? listRiwayatVa,
    RiwayatTiketVAModel? selectedRiwayatVa,

    // Alfamart Params
    ApiStatus? apiBuatAlfamartStatus,
    String? apiBuatAlfamartMessage,
    ApiStatus? apiRiwayatAlfamartStatus,
    String? apiRiwayatAlfamartMessage,
    List<RiwayatTiketAlfamartModel>? listRiwayatAlfamart,
    RiwayatTiketAlfamartModel? selectedRiwayatAlfamart,

    // Indomaret Params
    ApiStatus? apiBuatIndomaretStatus,
    String? apiBuatIndomaretMessage,
    ApiStatus? apiRiwayatIndomaretStatus,
    String? apiRiwayatIndomaretMessage,
    List<RiwayatTiketIndomaretModel>? listRiwayatIndomaret,
    RiwayatTiketIndomaretModel? selectedRiwayatIndomaret,

    // QRIS Params
    ApiStatus? apiBuatQrisStatus,
    String? apiBuatQrisMessage,
    ApiStatus? apiRiwayatQrisStatus,
    String? apiRiwayatQrisMessage,
    List<RiwayatTiketQRISModel>? listRiwayatQris,
    RiwayatTiketQRISModel? selectedRiwayatQris,

    // Mutasi Params
    ApiStatus? apiMutasiStatus,
    String? apiMutasiMessage,
    List<MutasiDepositModel>? listMutasiDeposit,
    ListGroupedMutasiDepositResponse? listMutasiDepositGrouped,
    bool? hasMoreMutasi,
    int? pageMutasi,
    DateTime? dateStartFilter,
    DateTime? dateEndFilter,
  }) {
    return MemberIsiStokState(
      focusNodeNominal: focusNodeNominal ?? this.focusNodeNominal,
      tiketDuration: tiketDuration ?? this.tiketDuration,

      // Bank Transfer Copy
      apiGetListProviderStatus:
          apiGetListProviderStatus ?? this.apiGetListProviderStatus,
      apiGetListProviderMessage:
          apiGetListProviderMessage ?? this.apiGetListProviderMessage,
      listBankTransfer: listBankTransfer ?? this.listBankTransfer,
      apiBuatTiketBankStatus:
          apiBuatTiketBankStatus ?? this.apiBuatTiketBankStatus,
      apiBuatTiketBankMessage:
          apiBuatTiketBankMessage ?? this.apiBuatTiketBankMessage,
      apiRiwayatTiketBankStatus:
          apiRiwayatTiketBankStatus ?? this.apiRiwayatTiketBankStatus,
      apiRiwayatTiketBankMessage:
          apiRiwayatTiketBankMessage ?? this.apiRiwayatTiketBankMessage,
      listRiwayatTiketBank: listRiwayatTiketBank ?? this.listRiwayatTiketBank,
      selectedRiwayatTiket: selectedRiwayatTiket ?? this.selectedRiwayatTiket,

      // VA Copy
      apiGetListVaStatus: apiGetListVaStatus ?? this.apiGetListVaStatus,
      apiGetListVaMessage: apiGetListVaMessage ?? this.apiGetListVaMessage,
      listVaBank: listVaBank ?? this.listVaBank,
      apiBuatVaStatus: apiBuatVaStatus ?? this.apiBuatVaStatus,
      apiBuatVaMessage: apiBuatVaMessage ?? this.apiBuatVaMessage,
      apiRiwayatVaStatus: apiRiwayatVaStatus ?? this.apiRiwayatVaStatus,
      apiRiwayatVaMessage: apiRiwayatVaMessage ?? this.apiRiwayatVaMessage,
      listRiwayatVa: listRiwayatVa ?? this.listRiwayatVa,
      selectedRiwayatVa: selectedRiwayatVa ?? this.selectedRiwayatVa,

      // Alfamart Copy
      apiBuatAlfamartStatus:
          apiBuatAlfamartStatus ?? this.apiBuatAlfamartStatus,
      apiBuatAlfamartMessage:
          apiBuatAlfamartMessage ?? this.apiBuatAlfamartMessage,
      apiRiwayatAlfamartStatus:
          apiRiwayatAlfamartStatus ?? this.apiRiwayatAlfamartStatus,
      apiRiwayatAlfamartMessage:
          apiRiwayatAlfamartMessage ?? this.apiRiwayatAlfamartMessage,
      listRiwayatAlfamart: listRiwayatAlfamart ?? this.listRiwayatAlfamart,
      selectedRiwayatAlfamart:
          selectedRiwayatAlfamart ?? this.selectedRiwayatAlfamart,

      // Indomaret Copy
      apiBuatIndomaretStatus:
          apiBuatIndomaretStatus ?? this.apiBuatIndomaretStatus,
      apiBuatIndomaretMessage:
          apiBuatIndomaretMessage ?? this.apiBuatIndomaretMessage,
      apiRiwayatIndomaretStatus:
          apiRiwayatIndomaretStatus ?? this.apiRiwayatIndomaretStatus,
      apiRiwayatIndomaretMessage:
          apiRiwayatIndomaretMessage ?? this.apiRiwayatIndomaretMessage,
      listRiwayatIndomaret: listRiwayatIndomaret ?? this.listRiwayatIndomaret,
      selectedRiwayatIndomaret:
          selectedRiwayatIndomaret ?? this.selectedRiwayatIndomaret,

      // QRIS Copy
      apiBuatQrisStatus: apiBuatQrisStatus ?? this.apiBuatQrisStatus,
      apiBuatQrisMessage: apiBuatQrisMessage ?? this.apiBuatQrisMessage,
      apiRiwayatQrisStatus: apiRiwayatQrisStatus ?? this.apiRiwayatQrisStatus,
      apiRiwayatQrisMessage:
          apiRiwayatQrisMessage ?? this.apiRiwayatQrisMessage,
      listRiwayatQris: listRiwayatQris ?? this.listRiwayatQris,
      selectedRiwayatQris: selectedRiwayatQris ?? this.selectedRiwayatQris,

      // Mutasi Copy
      apiMutasiStatus: apiMutasiStatus ?? this.apiMutasiStatus,
      apiMutasiMessage: apiMutasiMessage ?? this.apiMutasiMessage,
      listMutasiDeposit: listMutasiDeposit ?? this.listMutasiDeposit,
      listMutasiDepositGrouped:
          listMutasiDepositGrouped ?? this.listMutasiDepositGrouped,
      hasMoreMutasi: hasMoreMutasi ?? this.hasMoreMutasi,
      pageMutasi: pageMutasi ?? this.pageMutasi,
      dateStartFilter: dateStartFilter ?? this.dateStartFilter,
      dateEndFilter: dateEndFilter ?? this.dateEndFilter,
    );
  }

  @override
  List<Object?> get props => [
    focusNodeNominal,
    tiketDuration,

    // Bank Transfer Props
    apiGetListProviderStatus,
    apiGetListProviderMessage,
    listBankTransfer,
    apiBuatTiketBankStatus,
    apiBuatTiketBankMessage,
    apiRiwayatTiketBankStatus,
    apiRiwayatTiketBankMessage,
    listRiwayatTiketBank,
    selectedRiwayatTiket,

    // VA Props
    apiGetListVaStatus,
    apiGetListVaMessage,
    listVaBank,
    apiBuatVaStatus,
    apiBuatVaMessage,
    apiRiwayatVaStatus,
    apiRiwayatVaMessage,
    listRiwayatVa,
    selectedRiwayatVa,

    // Alfamart Props
    apiBuatAlfamartStatus,
    apiBuatAlfamartMessage,
    apiRiwayatAlfamartStatus,
    apiRiwayatAlfamartMessage,
    listRiwayatAlfamart,
    selectedRiwayatAlfamart,

    // Indomaret Props
    apiBuatIndomaretStatus,
    apiBuatIndomaretMessage,
    apiRiwayatIndomaretStatus,
    apiRiwayatIndomaretMessage,
    listRiwayatIndomaret,
    selectedRiwayatIndomaret,

    // QRIS Props
    apiBuatQrisStatus,
    apiBuatQrisMessage,
    apiRiwayatQrisStatus,
    apiRiwayatQrisMessage,
    listRiwayatQris,
    selectedRiwayatQris,

    // Mutasi Props
    apiMutasiStatus,
    apiMutasiMessage,
    listMutasiDeposit,
    listMutasiDepositGrouped,
    hasMoreMutasi,
    pageMutasi,
    dateStartFilter,
    dateEndFilter,
  ];
}

class MemberIsiStokProvider extends Cubit<MemberIsiStokState> {
  final DepositService _depositService = DepositService();
  Timer? _debounceTimer;

  MemberIsiStokProvider()
    : super(
        MemberIsiStokState(
          focusNodeNominal: FocusNode(),
          dateStartFilter: DateTime.now().subtract(const Duration(days: 1)),
          dateEndFilter: DateTime.now(),
        ),
      );

  // ===========================================================================
  // 1. BANK TRANSFER LOGIC
  // ===========================================================================

  Future<void> fetchListBankTransfer() async {
    if (state.apiGetListProviderStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetListProviderStatus: ApiStatus.loading,
        apiGetListProviderMessage: '',
      ),
    );

    try {
      final result = await _depositService.getListBankTransfer();

      if (!result.status) {
        emit(
          state.copyWith(
            apiGetListProviderStatus: ApiStatus.failure,
            apiGetListProviderMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      final data = result.data;

      if (data == null) {
        emit(
          state.copyWith(
            apiGetListProviderStatus: ApiStatus.failure,
            apiGetListProviderMessage: 'Data bank transfer kosong',
            listBankTransfer: [],
          ),
        );
        showWarningMessage('Data bank transfer kosong');
        return;
      } else {
        emit(
          state.copyWith(
            apiGetListProviderStatus: ApiStatus.success,
            apiGetListProviderMessage: '',
            listBankTransfer: data.banks,
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH LIST BANK TRANSFER:  ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetListProviderStatus: ApiStatus.failure,
          apiGetListProviderMessage: e.message,
        ),
      );
    }
  }

  Future<bool> buatTiketBankTransfer({
    required int idbank,
    required int nominal,
  }) async {
    if (state.apiBuatTiketBankStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiBuatTiketBankStatus: ApiStatus.loading,
        apiBuatTiketBankMessage: '',
      ),
    );

    try {
      final result = await _depositService.buatTiketBank(
        idbank: idbank,
        nominal: nominal,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiBuatTiketBankStatus: ApiStatus.failure,
            apiBuatTiketBankMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiBuatTiketBankStatus: ApiStatus.success,
          apiBuatTiketBankMessage: '',
        ),
      );

      final data = result.data;
      final akun = result.rekening;

      if (data != null && akun != null) {
        var riwayatTiket = DEFAULT_RIWAYAT_TIKET_BANK_MODEL;

        riwayatTiket = riwayatTiket.copyWith(
          biayaadmin: data.biayaadmin,
          deskripsi: akun.deskripsi,
          expireddata: result.expireddata,
          icon: akun.icon,
          jumlahnominalantriantiket: data.totaltiket,
          namaakun: akun.bank,
          namarekening: akun.namarekening,
          noantriantiket: data.antriantiket,
          nominalreqantriantiket: data.nominal,
          norekening: akun.rekening,
          status: 0,
          statusbank: 1,
          waktureq: data.waktu,
        );
        setSelectedRiwayatTiket(riwayatTiket);
        pushReplacementNamed(DetailTiketBankTransferPage.routeName);
      }

      fetchRiwayatTiketBankTransfer();

      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION BUAT TIKET BANK TRANSFER:  ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiBuatTiketBankStatus: ApiStatus.failure,
          apiBuatTiketBankMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<void> fetchRiwayatTiketBankTransfer() async {
    if (state.apiRiwayatTiketBankStatus.isLoading) return;

    emit(
      state.copyWith(
        apiRiwayatTiketBankStatus: ApiStatus.loading,
        apiRiwayatTiketBankMessage: '',
      ),
    );

    try {
      final result = await _depositService.getRiwayatTiketBank();

      debugPrint("RIWAYAT TIKET BANK RESULT: $result");

      if (!result.status) {
        emit(
          state.copyWith(
            apiRiwayatTiketBankStatus: ApiStatus.failure,
            apiRiwayatTiketBankMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      var data = result.data;
      if (data == null) {
        emit(
          state.copyWith(
            apiRiwayatTiketBankStatus: ApiStatus.failure,
            apiRiwayatTiketBankMessage: 'Data riwayat tiket bank kosong',
            listRiwayatTiketBank: [],
          ),
        );
        // showWarningMessage('Data riwayat tiket bank kosong');
        return;
      }

      emit(
        state.copyWith(
          apiRiwayatTiketBankStatus: ApiStatus.success,
          apiRiwayatTiketBankMessage: '',
          listRiwayatTiketBank: data,
        ),
      );
    } on ServerException catch (e) {
      debugPrint(
        "SERVER EXCEPTION FETCH RIWAYAT TIKET BANK TRANSFER:  ${e.message}",
      );
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiRiwayatTiketBankStatus: ApiStatus.failure,
          apiRiwayatTiketBankMessage: e.message,
        ),
      );
    }
  }

  void resetBankTransfer() {
    emit(
      state.copyWith(
        apiGetListProviderStatus: ApiStatus.initial,
        apiGetListProviderMessage: '',
        listBankTransfer: [],
      ),
    );
  }

  // ===========================================================================
  // 2. VIRTUAL ACCOUNT (VA) LOGIC
  // ===========================================================================

  Future<void> fetchListBankVa() async {
    if (state.apiGetListVaStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetListVaStatus: ApiStatus.loading,
        apiGetListVaMessage: '',
      ),
    );

    try {
      final result = await _depositService.getListBankVa();

      if (!result.status) {
        emit(
          state.copyWith(
            apiGetListVaStatus: ApiStatus.failure,
            apiGetListVaMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      final data = result.data;

      if (data == null || data.banks.isEmpty) {
        emit(
          state.copyWith(
            apiGetListVaStatus: ApiStatus.failure,
            apiGetListVaMessage: 'Data Bank VA kosong',
            listVaBank: [],
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiGetListVaStatus: ApiStatus.success,
          listVaBank: data.banks,
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH LIST VA: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetListVaStatus: ApiStatus.failure,
          apiGetListVaMessage: e.message,
        ),
      );
    }
  }

  Future<bool> buatTiketVa({required int idbank, required int nominal}) async {
    if (state.apiBuatVaStatus.isLoading) return false;

    emit(
      state.copyWith(apiBuatVaStatus: ApiStatus.loading, apiBuatVaMessage: ''),
    );

    try {
      final result = await _depositService.buatTiketVa(
        idbank: idbank,
        nominal: nominal,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiBuatVaStatus: ApiStatus.failure,
            apiBuatVaMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiBuatVaStatus: ApiStatus.success,
          apiBuatVaMessage: result.message,
        ),
      );

      final data = result.data;
      if (data != null) {
        setSelectedRiwayatVa(data);
        pushReplacementNamed(DetailTiketVaPage.routeName);
      }

      // Refresh list riwayat
      fetchRiwayatTiketVa();
      return true;
    } on ServerException catch (e) {
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiBuatVaStatus: ApiStatus.failure,
          apiBuatVaMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<void> fetchRiwayatTiketVa() async {
    if (state.apiRiwayatVaStatus.isLoading) return;

    emit(
      state.copyWith(
        apiRiwayatVaStatus: ApiStatus.loading,
        apiRiwayatVaMessage: '',
      ),
    );

    try {
      final result = await _depositService.getRiwayatTiketVa();

      if (!result.status) {
        emit(
          state.copyWith(
            apiRiwayatVaStatus: ApiStatus.failure,
            apiRiwayatVaMessage: result.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiRiwayatVaStatus: ApiStatus.success,
          listRiwayatVa: result.data ?? [],
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          apiRiwayatVaStatus: ApiStatus.failure,
          apiRiwayatVaMessage: e.message,
        ),
      );
    }
  }

  void resetVa() {
    emit(
      state.copyWith(
        apiGetListVaStatus: ApiStatus.initial,
        apiGetListVaMessage: '',
        listVaBank: [],
      ),
    );
  }

  // ===========================================================================
  // 3. ALFAMART LOGIC
  // ===========================================================================

  Future<bool> buatTiketAlfamart({required int nominal}) async {
    if (state.apiBuatAlfamartStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiBuatAlfamartStatus: ApiStatus.loading,
        apiBuatAlfamartMessage: '',
      ),
    );

    try {
      final result = await _depositService.buatTiketAlfamart(nominal: nominal);

      if (!result.status) {
        emit(
          state.copyWith(
            apiBuatAlfamartStatus: ApiStatus.failure,
            apiBuatAlfamartMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiBuatAlfamartStatus: ApiStatus.success,
          apiBuatAlfamartMessage: result.message,
        ),
      );

      final data = result.data;
      if (data != null) {
        debugPrint("DATA ALFAMART: $data");
        setSelectedRiwayatAlfamart(data);
        pushReplacementNamed(DetailTiketAlfamartPage.routeName);
      } else {
        debugPrint("DATA ALFAMART NULL");
      }

      // fetchRiwayatTiketAlfamart();
      return true;
    } on ServerException catch (e) {
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiBuatAlfamartStatus: ApiStatus.failure,
          apiBuatAlfamartMessage: e.message,
        ),
      );
      return false;
    } catch (e, stackTrace) {
      debugPrint("ERROR: $e");
      debugPrintStack(stackTrace: stackTrace);
      showWarningMessage(e.toString());
      emit(
        state.copyWith(
          apiBuatAlfamartStatus: ApiStatus.failure,
          apiBuatAlfamartMessage: e.toString(),
        ),
      );
      return false;
    }
  }

  Future<void> fetchRiwayatTiketAlfamart() async {
    if (state.apiRiwayatAlfamartStatus.isLoading) return;

    emit(
      state.copyWith(
        apiRiwayatAlfamartStatus: ApiStatus.loading,
        apiRiwayatAlfamartMessage: '',
      ),
    );

    try {
      final result = await _depositService.getRiwayatTiketAlfamart();

      if (!result.status) {
        emit(
          state.copyWith(
            apiRiwayatAlfamartStatus: ApiStatus.failure,
            apiRiwayatAlfamartMessage: result.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiRiwayatAlfamartStatus: ApiStatus.success,
          listRiwayatAlfamart: result.data ?? [],
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          apiRiwayatAlfamartStatus: ApiStatus.failure,
          apiRiwayatAlfamartMessage: e.message,
        ),
      );
    }
  }

  // ===========================================================================
  // 4. INDOMARET LOGIC
  // ===========================================================================

  Future<bool> buatTiketIndomaret({required int nominal}) async {
    if (state.apiBuatIndomaretStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiBuatIndomaretStatus: ApiStatus.loading,
        apiBuatIndomaretMessage: '',
      ),
    );

    try {
      final result = await _depositService.buatTiketIndomaret(nominal: nominal);

      if (!result.status) {
        emit(
          state.copyWith(
            apiBuatIndomaretStatus: ApiStatus.failure,
            apiBuatIndomaretMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiBuatIndomaretStatus: ApiStatus.success,
          apiBuatIndomaretMessage: result.message,
        ),
      );

      final data = result.data;
      if (data != null) {
        setSelectedRiwayatIndomaret(data);
        pushReplacementNamed(DetailTiketIndomaretPage.routeName);
      }

      // fetchRiwayatTiketIndomaret();
      return true;
    } on ServerException catch (e) {
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiBuatIndomaretStatus: ApiStatus.failure,
          apiBuatIndomaretMessage: e.message,
        ),
      );
      return false;
    } catch (e, stackTrace) {
      debugPrint("ERROR: $e");
      debugPrintStack(stackTrace: stackTrace);
      showWarningMessage(e.toString());
      emit(
        state.copyWith(
          apiBuatIndomaretStatus: ApiStatus.failure,
          apiBuatIndomaretMessage: e.toString(),
        ),
      );
      return false;
    }
  }

  Future<void> fetchRiwayatTiketIndomaret() async {
    if (state.apiRiwayatIndomaretStatus.isLoading) return;

    emit(
      state.copyWith(
        apiRiwayatIndomaretStatus: ApiStatus.loading,
        apiRiwayatIndomaretMessage: '',
      ),
    );

    try {
      final result = await _depositService.getRiwayatTiketIndomaret();

      if (!result.status) {
        emit(
          state.copyWith(
            apiRiwayatIndomaretStatus: ApiStatus.failure,
            apiRiwayatIndomaretMessage: result.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiRiwayatIndomaretStatus: ApiStatus.success,
          listRiwayatIndomaret: result.data ?? [],
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          apiRiwayatIndomaretStatus: ApiStatus.failure,
          apiRiwayatIndomaretMessage: e.message,
        ),
      );
    }
  }

  // ===========================================================================
  // 5. QRIS LOGIC
  // ===========================================================================

  Future<bool> buatTiketQris({required int nominal}) async {
    if (state.apiBuatQrisStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiBuatQrisStatus: ApiStatus.loading,
        apiBuatQrisMessage: '',
      ),
    );

    try {
      final result = await _depositService.buatTiketQris(nominal: nominal);

      if (!result.status) {
        emit(
          state.copyWith(
            apiBuatQrisStatus: ApiStatus.failure,
            apiBuatQrisMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiBuatQrisStatus: ApiStatus.success,
          apiBuatQrisMessage: result.message,
        ),
      );

      final data = result.data;
      if (data != null) {
        setSelectedRiwayatQris(data);
        pushReplacementNamed(DetailTiketQrisPage.routeName);
      }

      fetchRiwayatTiketQris();
      return true;
    } on ServerException catch (e) {
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiBuatQrisStatus: ApiStatus.failure,
          apiBuatQrisMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<void> fetchRiwayatTiketQris() async {
    if (state.apiRiwayatQrisStatus.isLoading) return;

    emit(
      state.copyWith(
        apiRiwayatQrisStatus: ApiStatus.loading,
        apiRiwayatQrisMessage: '',
      ),
    );

    try {
      final result = await _depositService.getRiwayatTiketQris();

      if (!result.status) {
        emit(
          state.copyWith(
            apiRiwayatQrisStatus: ApiStatus.failure,
            apiRiwayatQrisMessage: result.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiRiwayatQrisStatus: ApiStatus.success,
          listRiwayatQris: result.data ?? [],
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          apiRiwayatQrisStatus: ApiStatus.failure,
          apiRiwayatQrisMessage: e.message,
        ),
      );
    }
  }

  // ===========================================================================
  // 6. MUTASI DEPOSIT LOGIC
  // ===========================================================================

  void setDateFilterMutasi(DateTime start, DateTime end) {
    emit(state.copyWith(dateStartFilter: start, dateEndFilter: end));
  }

  // Mutasi Stok
  // Paging
  // ============================================================

  void nextPageMutasiDeposit() {
    emit(state.copyWith(pageMutasi: state.pageMutasi + 1));
    fetchMutasiDeposit();
  }

  void refreshMutasiDeposit() {
    emit(state.copyWith(pageMutasi: 1));
    fetchMutasiDeposit();
  }

  void resetMutasiDepositFilter() {
    emit(
      state.copyWith(
        pageMutasi: 1,
        dateStartFilter: DateTime.now().subtract(const Duration(days: 1)),
        dateEndFilter: DateTime.now(),
        listMutasiDeposit: [],
        listMutasiDepositGrouped: DEFAULT_LIST_GROUPED_MUTASI_DEPOSIT_RESPONSE,
        hasMoreMutasi: true,
      ),
    );
    fetchMutasiDeposit();
  }

  void clearMutasiDeposit() {
    emit(
      state.copyWith(
        pageMutasi: 1,
        dateStartFilter: DateTime.now().subtract(const Duration(days: 1)),
        dateEndFilter: DateTime.now(),
        listMutasiDeposit: [],
        listMutasiDepositGrouped: DEFAULT_LIST_GROUPED_MUTASI_DEPOSIT_RESPONSE,
        hasMoreMutasi: true,
        apiMutasiStatus: ApiStatus.initial,
        apiMutasiMessage: '',
      ),
    );
  }

  Future<void> fetchMutasiDeposit() async {
    // Prevent duplicate calls if already loading
    if (state.apiMutasiStatus.isLoading) return;

    // Show Loading
    emit(
      state.copyWith(apiMutasiStatus: ApiStatus.loading, apiMutasiMessage: ''),
    );

    try {
      // Use current date filter or default to today/yesterday if null
      final startDate =
          state.dateStartFilter ??
          DateTime.now().subtract(const Duration(days: 1));
      final endDate = state.dateEndFilter ?? DateTime.now();

      final result = await _depositService.getMutasiDeposit(
        waktuawal: DateHelper.formatDate(startDate),
        waktuakhir: DateHelper.formatDate(endDate),
        page: state.pageMutasi,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiMutasiStatus: ApiStatus.failure,
            apiMutasiMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      final newData = result.data;

      List<MutasiDepositModel> updatedList = [];
      bool hasMore = state.hasMoreMutasi;

      // 1. Logic Penggabungan List
      if (newData.isEmpty) {
        if (state.pageMutasi > 1) {
          // If page > 1 and empty, means we reached end
          hasMore = false; // or check length < expected page size
          updatedList = state.listMutasiDeposit;
        } else {
          // Page 1 and empty
          updatedList = [];
          hasMore = false;
        }
      } else {
        hasMore = newData.length >= 20; // Assuming 20 is page size
        if (state.pageMutasi == 1) {
          updatedList = List.from(newData);
        } else {
          updatedList = List<MutasiDepositModel>.from(state.listMutasiDeposit)
            ..addAll(newData);
        }
      }

      // 2. Generate Grouped List
      final groupedData =
          ListGroupedMutasiDepositResponse.fromListMutasiResponse(updatedList);

      // 3. Emit State
      emit(
        state.copyWith(
          apiMutasiStatus: ApiStatus.success,
          listMutasiDeposit: updatedList,
          listMutasiDepositGrouped: groupedData,
          hasMoreMutasi: hasMore,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          apiMutasiStatus: ApiStatus.failure,
          apiMutasiMessage: e.message,
        ),
      );
    }
  }

  // ===========================================================================
  // 7. HELPER & TIMER LOGIC (Existing)
  // ===========================================================================

  void startTimerDebounce(Duration duration) {
    _debounceTimer?.cancel();
    emit(state.copyWith(tiketDuration: duration));
    _debounceTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.tiketDuration - const Duration(seconds: 1);

      debugPrint(
        "OTP RESEND DURATION: ${remaining.inSeconds} seconds remaining",
      );

      if (remaining.isNegative || remaining == Duration.zero) {
        debugPrint("TIKET EXPIRED, STOP TIMER");
        stopTimerDebounce();
        emit(state.copyWith(tiketDuration: Duration.zero));
        // checkCurrentTiketStatus();
      } else {
        emit(state.copyWith(tiketDuration: remaining));
      }
    });
  }

  void stopTimerDebounce() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }

  void setSelectedRiwayatTiket(RiwayatTiketBankModel tiket) {
    emit(state.copyWith(selectedRiwayatTiket: tiket));

    if (tiket.status != 0) {
      stopTimerDebounce();
      emit(state.copyWith(tiketDuration: Duration.zero));
      return;
    }
    var dur = DateHelper.countdownFromString(tiket.expireddata);

    debugPrint("Expired Data ${tiket.expireddata.toString()}");

    startTimerDebounce(dur ?? Duration.zero);
  }

  void setSelectedRiwayatAlfamart(RiwayatTiketAlfamartModel tiket) {
    emit(state.copyWith(selectedRiwayatAlfamart: tiket));

    debugPrint("Expired Data ${tiket.expireddata.toString()}");

    if (tiket.status != 0) {
      debugPrint("TIKET EXPIRED, STOP TIMER");
      stopTimerDebounce();
      emit(state.copyWith(tiketDuration: Duration.zero));
      return;
    }
    var dur = DateHelper.countdownFromString(tiket.expireddata);
    startTimerDebounce(dur ?? Duration.zero);
  }

  void setSelectedRiwayatIndomaret(RiwayatTiketIndomaretModel tiket) {
    emit(state.copyWith(selectedRiwayatIndomaret: tiket));

    if (tiket.status != 0) {
      stopTimerDebounce();
      emit(state.copyWith(tiketDuration: Duration.zero));
      return;
    }
    var dur = DateHelper.countdownFromString(tiket.expireddata);
    startTimerDebounce(dur ?? Duration.zero);
  }

  void setSelectedRiwayatVa(RiwayatTiketVAModel tiket) {
    emit(state.copyWith(selectedRiwayatVa: tiket));

    if (tiket.status != 0) {
      stopTimerDebounce();
      emit(state.copyWith(tiketDuration: Duration.zero));
      return;
    }
    var dur = DateHelper.countdownFromString(tiket.expired);
    startTimerDebounce(dur ?? Duration.zero);
  }

  void setSelectedRiwayatQris(RiwayatTiketQRISModel tiket) {
    emit(state.copyWith(selectedRiwayatQris: tiket));

    if (tiket.status != 0) {
      stopTimerDebounce();
      emit(state.copyWith(tiketDuration: Duration.zero));
      return;
    }
    var dur = DateHelper.countdownFromString(tiket.expired);
    startTimerDebounce(dur ?? Duration.zero);
  }

  void checkCurrentTiketStatus() async {
    await fetchRiwayatTiketBankTransfer();

    var currentTiket = state.selectedRiwayatTiket;
    var updatedTiket = state.listRiwayatTiketBank.firstWhere(
      (tiket) =>
          tiket.noantriantiket == currentTiket.noantriantiket &&
          tiket.waktureq == currentTiket.waktureq,
      orElse: () => DEFAULT_RIWAYAT_TIKET_BANK_MODEL,
    );

    setSelectedRiwayatTiket(updatedTiket);
  }
}

MemberIsiStokProvider getMemberIsiStokProvider(BuildContext context) {
  return context.read<MemberIsiStokProvider>();
}
