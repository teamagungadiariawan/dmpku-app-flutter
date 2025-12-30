import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/service/member/kasir_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberPelangganState extends Equatable {
  // List Pelanggan API
  final ApiStatus apiGetPelangganStatus;
  final String apiGetPelangganMessage;
  final List<PelangganModel> pelangganList;

  // Search Filter
  final String searchQuery;
  final TextEditingController? searchController;

  // Tambah Pelanggan API
  final ApiStatus apiTambahPelangganStatus;
  final String apiTambahPelangganMessage;

  // Ubah Pelanggan API
  final ApiStatus apiUbahPelangganStatus;
  final String apiUbahPelangganMessage;

  // Hapus Pelanggan API
  final ApiStatus apiHapusPelangganStatus;
  final String apiHapusPelangganMessage;

  const MemberPelangganState({
    this.apiGetPelangganStatus = ApiStatus.initial,
    this.apiGetPelangganMessage = '',
    this.pelangganList = const [],
    this.searchQuery = '',
    this.searchController,
    this.apiTambahPelangganStatus = ApiStatus.initial,
    this.apiTambahPelangganMessage = '',
    this.apiUbahPelangganStatus = ApiStatus.initial,
    this.apiUbahPelangganMessage = '',
    this.apiHapusPelangganStatus = ApiStatus.initial,
    this.apiHapusPelangganMessage = '',
  });

  MemberPelangganState copyWith({
    ApiStatus? apiGetPelangganStatus,
    String? apiGetPelangganMessage,
    List<PelangganModel>? pelangganList,
    String? searchQuery,
    TextEditingController? searchController,
    ApiStatus? apiTambahPelangganStatus,
    String? apiTambahPelangganMessage,
    ApiStatus? apiUbahPelangganStatus,
    String? apiUbahPelangganMessage,
    ApiStatus? apiHapusPelangganStatus,
    String? apiHapusPelangganMessage,
  }) {
    return MemberPelangganState(
      apiGetPelangganStatus:
          apiGetPelangganStatus ?? this.apiGetPelangganStatus,
      apiGetPelangganMessage:
          apiGetPelangganMessage ?? this.apiGetPelangganMessage,
      pelangganList: pelangganList ?? this.pelangganList,
      searchQuery: searchQuery ?? this.searchQuery,
      searchController: searchController ?? this.searchController,
      apiTambahPelangganStatus:
          apiTambahPelangganStatus ?? this.apiTambahPelangganStatus,
      apiTambahPelangganMessage:
          apiTambahPelangganMessage ?? this.apiTambahPelangganMessage,
      apiUbahPelangganStatus:
          apiUbahPelangganStatus ?? this.apiUbahPelangganStatus,
      apiUbahPelangganMessage:
          apiUbahPelangganMessage ?? this.apiUbahPelangganMessage,
      apiHapusPelangganStatus:
          apiHapusPelangganStatus ?? this.apiHapusPelangganStatus,
      apiHapusPelangganMessage:
          apiHapusPelangganMessage ?? this.apiHapusPelangganMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiGetPelangganStatus,
    apiGetPelangganMessage,
    pelangganList,
    searchQuery,
    searchController,
    apiTambahPelangganStatus,
    apiTambahPelangganMessage,
    apiUbahPelangganStatus,
    apiUbahPelangganMessage,
    apiHapusPelangganStatus,
    apiHapusPelangganMessage,
  ];
}

class MemberPelangganProvider extends Cubit<MemberPelangganState> {
  final _kasirService = KasirService();

  MemberPelangganProvider()
    : super(MemberPelangganState(searchController: TextEditingController()));

  @override
  Future<void> close() {
    state.searchController?.dispose();
    return super.close();
  }

  // Get Pelanggan List
  Future<void> getPelangganList() async {
    if (state.apiGetPelangganStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetPelangganStatus: ApiStatus.loading,
        apiGetPelangganMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiGetPelangganStatus: ApiStatus.failure,
            apiGetPelangganMessage: 'Sesi anda telah berakhir',
          ),
        );
        return;
      }

      final result = await _kasirService.getPelanggan(kodemember);

      if (result.status) {
        var data = result.data;
        emit(
          state.copyWith(
            apiGetPelangganStatus: ApiStatus.success,
            pelangganList: data ?? [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiGetPelangganStatus: ApiStatus.failure,
            apiGetPelangganMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET PELANGGAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetPelangganStatus: ApiStatus.failure,
          apiGetPelangganMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION GET PELANGGAN: $e");
      emit(
        state.copyWith(
          apiGetPelangganStatus: ApiStatus.failure,
          apiGetPelangganMessage: "Terjadi kesalahan: $e",
        ),
      );
    }
  }

  void setSearchQuery(String query, {bool updateController = true}) {
    emit(state.copyWith(searchQuery: query));

    if (updateController) {
      _updateController(state.searchController, query);
    }
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  Future<bool> tambahPelanggan(
    BuildContext context, {
    required String namaPelanggan,
    required String alamat,
    required String noHp,
  }) async {
    if (state.apiTambahPelangganStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiTambahPelangganStatus: ApiStatus.loading,
        apiTambahPelangganMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";

      final result = await _kasirService.tambahPelanggan(
        kodemember: kodemember,
        namapelanggan: namaPelanggan,
        alamatpelanggan: alamat,
        nohppelanggan: noHp,
      );

      if (result.status) {
        emit(state.copyWith(apiTambahPelangganStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menambahkan pelanggan.");
        getPelangganList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiTambahPelangganStatus: ApiStatus.failure,
            apiTambahPelangganMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION TAMBAH PELANGGAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiTambahPelangganStatus: ApiStatus.failure,
          apiTambahPelangganMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> ubahPelanggan(
    BuildContext context, {
    required int idPelanggan,
    required String namaPelanggan,
    required String alamat,
    required String noHp,
  }) async {
    if (state.apiUbahPelangganStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiUbahPelangganStatus: ApiStatus.loading,
        apiUbahPelangganMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";
      final result = await _kasirService.ubahPelanggan(
        idpelanggan: idPelanggan,
        kodemember: kodemember,
        namapelanggan: namaPelanggan,
        alamatpelanggan: alamat,
        nohppelanggan: noHp,
      );

      if (result.status) {
        emit(state.copyWith(apiUbahPelangganStatus: ApiStatus.success));
        showSuccessMessage("Berhasil mengubah pelanggan.");
        getPelangganList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiUbahPelangganStatus: ApiStatus.failure,
            apiUbahPelangganMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION UBAH PELANGGAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiUbahPelangganStatus: ApiStatus.failure,
          apiUbahPelangganMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> hapusPelanggan(
    BuildContext context, {
    required int idPelanggan,
  }) async {
    if (state.apiHapusPelangganStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiHapusPelangganStatus: ApiStatus.loading,
        apiHapusPelangganMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";
      final result = await _kasirService.hapusPelanggan(
        idpelanggan: idPelanggan,
        kodemember: kodemember,
      );

      if (result.status) {
        emit(state.copyWith(apiHapusPelangganStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menghapus pelanggan.");
        getPelangganList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiHapusPelangganStatus: ApiStatus.failure,
            apiHapusPelangganMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION HAPUS PELANGGAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiHapusPelangganStatus: ApiStatus.failure,
          apiHapusPelangganMessage: e.message,
        ),
      );
      return false;
    }
  }
}

MemberPelangganProvider getMemberPelangganProvider(BuildContext context) =>
    context.read<MemberPelangganProvider>();
