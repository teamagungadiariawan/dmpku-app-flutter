import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/service/member/kasir_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KasirState extends Equatable {
  // Get Penjualan API
  final ApiStatus apiGetPenjualanStatus;
  final String apiGetPenjualanMessage;
  final DateTime tanggalPenjualan;
  final List<PenjualanModel> listPenjualan;

  const KasirState({
    this.apiGetPenjualanStatus = ApiStatus.initial,
    this.apiGetPenjualanMessage = '',
    required this.tanggalPenjualan,
    this.listPenjualan = const [],
  });

  KasirState copyWith({
    ApiStatus? apiGetPenjualanStatus,
    String? apiGetPenjualanMessage,
    DateTime? tanggalPenjualan,
    List<PenjualanModel>? listPenjualan,
  }) {
    return KasirState(
      apiGetPenjualanStatus:
          apiGetPenjualanStatus ?? this.apiGetPenjualanStatus,
      apiGetPenjualanMessage:
          apiGetPenjualanMessage ?? this.apiGetPenjualanMessage,
      tanggalPenjualan: tanggalPenjualan ?? this.tanggalPenjualan,
      listPenjualan: listPenjualan ?? this.listPenjualan,
    );
  }

  @override
  List<Object?> get props => [
    apiGetPenjualanStatus,
    apiGetPenjualanMessage,
    tanggalPenjualan,
    listPenjualan,
  ];
}

class KasirProvider extends Cubit<KasirState> {
  final KasirService _kasirService = KasirService();

  KasirProvider()
    : super(
        KasirState(
          tanggalPenjualan: DateTime.now(), // Default to today
        ),
      );

  // ===========================================================================
  // LIST PENJUALAN
  // ===========================================================================
  Future<void> fetchListPenjualan() async {
    if (state.apiGetPenjualanStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetPenjualanStatus: ApiStatus.loading,
        apiGetPenjualanMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiGetPenjualanStatus: ApiStatus.failure,
            apiGetPenjualanMessage: 'Sesi anda telah berakhir',
          ),
        );
        return;
      }

      // Format date: YYYY-MM-DD
      final dateStr = DateHelper.formatYYYYMMDD(state.tanggalPenjualan);

      final result = await _kasirService.getListPenjualan(
        waktuawal: dateStr,
        waktuakhir: dateStr,
        kodemember: kodemember,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiGetPenjualanStatus: ApiStatus.failure,
            apiGetPenjualanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      final data = result.data;

      if (data == null) {
        emit(
          state.copyWith(
            apiGetPenjualanStatus: ApiStatus.failure,
            apiGetPenjualanMessage: 'Data penjualan kosong',
            listPenjualan: [],
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiGetPenjualanStatus: ApiStatus.success,
          apiGetPenjualanMessage: '',
          listPenjualan: data.list,
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH LIST PENJUALAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetPenjualanStatus: ApiStatus.failure,
          apiGetPenjualanMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION FETCH LIST PENJUALAN: $e");
      emit(
        state.copyWith(
          apiGetPenjualanStatus: ApiStatus.failure,
          apiGetPenjualanMessage: "Terjadi kesalahan: $e",
        ),
      );
    }
  }

  void onChangeTanggalPenjualan(DateTime date) {
    emit(state.copyWith(tanggalPenjualan: date));
    fetchListPenjualan();
  }
}

KasirProvider getKasirProvider(BuildContext context) =>
    context.read<KasirProvider>();
