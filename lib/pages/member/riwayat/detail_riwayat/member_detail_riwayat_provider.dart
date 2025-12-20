import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/cek_tagihan_response.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/service/member/riwayat_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberDetailRiwayatState extends Equatable {
  // Detail Transaksi API
  final ApiStatus detailTransaksiStatus;
  final String detailTransaksiMessage;

  // Selected Transaksi
  final RiwayatModel selectedTransaksi;
  final DataSplit dataSplit;
  final DetailTransaksiModel detailTransaksi;

  final bool isToday;

  const MemberDetailRiwayatState({
    this.detailTransaksiStatus = ApiStatus.initial,
    this.detailTransaksiMessage = '',
    this.selectedTransaksi = DEFAULT_RIWAYAT_MODEL,
    this.dataSplit = DEFAULT_DATA_SPLIT_RESPONSE,
    this.detailTransaksi = DEFAULT_DETAIL_TRANSAKSI_MODEL,
    this.isToday = true,
  });

  MemberDetailRiwayatState copyWith({
    ApiStatus? detailTransaksiStatus,
    String? detailTransaksiMessage,
    RiwayatModel? selectedTransaksi,
    DataSplit? dataSplit,
    DetailTransaksiModel? detailTransaksi,
    bool? isToday,
  }) {
    return MemberDetailRiwayatState(
      detailTransaksiStatus:
          detailTransaksiStatus ?? this.detailTransaksiStatus,
      detailTransaksiMessage:
          detailTransaksiMessage ?? this.detailTransaksiMessage,
      selectedTransaksi: selectedTransaksi ?? this.selectedTransaksi,
      dataSplit: dataSplit ?? this.dataSplit,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi,
      isToday: isToday ?? this.isToday,
    );
  }

  @override
  List<Object?> get props => [
    detailTransaksiStatus,
    detailTransaksiMessage,
    selectedTransaksi,
    dataSplit,
    detailTransaksi,
    isToday,
  ];
}

class MemberDetailRiwayatProvider extends Cubit<MemberDetailRiwayatState> {
  final RiwayatService _riwayatService = RiwayatService();

  MemberDetailRiwayatProvider() : super(const MemberDetailRiwayatState());

  void setSelectedTransaksi(RiwayatModel transaksi, bool isToday) {
    emit(state.copyWith(selectedTransaksi: transaksi, isToday: isToday));

    getDetailTransaksi();
  }

  void getDetailTransaksi() {
    if (state.isToday) {
      fetchDetailTransaksiToday();
    } else {
      fetchDetailTransaksiHistory();
    }
  }

  void resetDetailTransaksi() {
    emit(
      state.copyWith(
        detailTransaksiStatus: ApiStatus.initial,
        detailTransaksiMessage: '',
        dataSplit: DEFAULT_DATA_SPLIT_RESPONSE,
        detailTransaksi: DEFAULT_DETAIL_TRANSAKSI_MODEL,
      ),
    );
  }

  void fetchDetailTransaksiToday() async {
    if (state.selectedTransaksi.idtransaksiprod == 0) return;

    if (state.detailTransaksiStatus.isLoading) return;

    emit(
      state.copyWith(
        detailTransaksiStatus: ApiStatus.loading,
        detailTransaksiMessage: '',
      ),
    );

    try {
      final result = await _riwayatService.getDetailTransaksiToday(
        idtransaksiprod: state.selectedTransaksi.idtransaksiprod,
      );

      var dataSp = result.dataSplit ?? DEFAULT_DATA_SPLIT_RESPONSE;
      var detailTrx = result.data ?? DEFAULT_DETAIL_TRANSAKSI_MODEL;

      var dataTrx = dataSp.dataTransaksi
          ?.where((d) => d.value != '-' || d.value != '')
          .toList();
      var dataBiaya = dataSp.dataBiaya
          ?.where(
            (d) =>
        d.value != '-' ||
            d.value != '' &&
                removeNonAlphanumeric(d.key).trim().toLowerCase() !=
                    'totalbayar',
      )
          .toList();

      dataSp = dataSp.copyWith(dataTransaksi: dataTrx, dataBiaya: dataBiaya);

      if (detailTrx.idtransaksiprod != 0) {
        emit(
          state.copyWith(
            detailTransaksiStatus: ApiStatus.success,
            detailTransaksiMessage: 'Berhasil memuat detail transaksi.',
            dataSplit: dataSp,
            detailTransaksi: detailTrx,
          ),
        );
      } else {
        emit(
          state.copyWith(
            detailTransaksiStatus: ApiStatus.failure,
            detailTransaksiMessage: 'Data detail transaksi tidak ditemukan.',
          ),
        );
        showErrorMessage('Data detail transaksi tidak ditemukan.');
        pop();
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH DETAIL TRANSAKSI TODAY: $e");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          detailTransaksiStatus: ApiStatus.failure,
          detailTransaksiMessage: e.message,
        ),
      );
    }
  }

  void fetchDetailTransaksiHistory() async {
    if (state.selectedTransaksi.idtransaksiprod == 0) return;

    if (state.detailTransaksiStatus.isLoading) return;

    emit(
      state.copyWith(
        detailTransaksiStatus: ApiStatus.loading,
        detailTransaksiMessage: '',
      ),
    );

    try {
      final result = await _riwayatService.getDetailTransaksiHistory(
        idtransaksiprod: state.selectedTransaksi.idtransaksiprod,
      );

      var dataSp = result.dataSplit ?? DEFAULT_DATA_SPLIT_RESPONSE;
      var detailTrx = result.data ?? DEFAULT_DETAIL_TRANSAKSI_MODEL;

      var dataTrx = dataSp.dataTransaksi
          ?.where((d) => d.value != '-' || d.value != '')
          .toList();
      var dataBiaya = dataSp.dataBiaya
          ?.where(
            (d) =>
                d.value != '-' ||
                d.value != '' &&
                    removeNonAlphanumeric(d.key).trim().toLowerCase() !=
                        'totalbayar',
          )
          .toList();

      dataSp = dataSp.copyWith(dataTransaksi: dataTrx, dataBiaya: dataBiaya);

      if (detailTrx.idtransaksiprod != 0) {
        emit(
          state.copyWith(
            detailTransaksiStatus: ApiStatus.success,
            detailTransaksiMessage: 'Berhasil memuat detail transaksi.',
            dataSplit: dataSp,
            detailTransaksi: detailTrx,
          ),
        );
      } else {
        emit(
          state.copyWith(
            detailTransaksiStatus: ApiStatus.failure,
            detailTransaksiMessage: 'Data detail transaksi tidak ditemukan.',
          ),
        );
        showErrorMessage('Data detail transaksi tidak ditemukan.');
        pop();
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH DETAIL TRANSAKSI HISTORY: $e");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          detailTransaksiStatus: ApiStatus.failure,
          detailTransaksiMessage: e.message,
        ),
      );
    }
  }
}

MemberDetailRiwayatProvider getMemberDetailRiwayatProvider(
  BuildContext context,
) => context.read<MemberDetailRiwayatProvider>();
