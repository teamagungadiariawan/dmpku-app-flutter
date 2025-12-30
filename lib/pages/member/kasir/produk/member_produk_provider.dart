import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/service/member/kasir_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberProdukState extends Equatable {
  // List Produk API
  final ApiStatus apiGetProdukStatus;
  final String apiGetProdukMessage;
  final List<ProdukModel> produkList;

  // Search Filter
  final String searchQuery;
  final TextEditingController? searchController;

  // Tambah Produk API
  final ApiStatus apiTambahProdukStatus;
  final String apiTambahProdukMessage;

  // Ubah Produk API
  final ApiStatus apiUbahProdukStatus;
  final String apiUbahProdukMessage;

  // Hapus Produk API
  final ApiStatus apiHapusProdukStatus;
  final String apiHapusProdukMessage;

  const MemberProdukState({
    this.apiGetProdukStatus = ApiStatus.initial,
    this.apiGetProdukMessage = '',
    this.produkList = const [],
    this.searchQuery = '',
    this.searchController,
    this.apiTambahProdukStatus = ApiStatus.initial,
    this.apiTambahProdukMessage = '',
    this.apiUbahProdukStatus = ApiStatus.initial,
    this.apiUbahProdukMessage = '',
    this.apiHapusProdukStatus = ApiStatus.initial,
    this.apiHapusProdukMessage = '',
  });

  MemberProdukState copyWith({
    ApiStatus? apiGetProdukStatus,
    String? apiGetProdukMessage,
    List<ProdukModel>? produkList,
    String? searchQuery,
    TextEditingController? searchController,
    ApiStatus? apiTambahProdukStatus,
    String? apiTambahProdukMessage,
    ApiStatus? apiUbahProdukStatus,
    String? apiUbahProdukMessage,
    ApiStatus? apiHapusProdukStatus,
    String? apiHapusProdukMessage,
  }) {
    return MemberProdukState(
      apiGetProdukStatus: apiGetProdukStatus ?? this.apiGetProdukStatus,
      apiGetProdukMessage: apiGetProdukMessage ?? this.apiGetProdukMessage,
      produkList: produkList ?? this.produkList,
      searchQuery: searchQuery ?? this.searchQuery,
      searchController: searchController ?? this.searchController,
      apiTambahProdukStatus:
          apiTambahProdukStatus ?? this.apiTambahProdukStatus,
      apiTambahProdukMessage:
          apiTambahProdukMessage ?? this.apiTambahProdukMessage,
      apiUbahProdukStatus: apiUbahProdukStatus ?? this.apiUbahProdukStatus,
      apiUbahProdukMessage: apiUbahProdukMessage ?? this.apiUbahProdukMessage,
      apiHapusProdukStatus: apiHapusProdukStatus ?? this.apiHapusProdukStatus,
      apiHapusProdukMessage:
          apiHapusProdukMessage ?? this.apiHapusProdukMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiGetProdukStatus,
    apiGetProdukMessage,
    produkList,
    searchQuery,
    searchController,
    apiTambahProdukStatus,
    apiTambahProdukMessage,
    apiUbahProdukStatus,
    apiUbahProdukMessage,
    apiHapusProdukStatus,
    apiHapusProdukMessage,
  ];
}

class MemberProdukProvider extends Cubit<MemberProdukState> {
  final _kasirService = KasirService();

  MemberProdukProvider()
    : super(MemberProdukState(searchController: TextEditingController()));

  @override
  Future<void> close() {
    state.searchController?.dispose();
    return super.close();
  }

  // Get Produk List
  Future<void> getProdukList() async {
    if (state.apiGetProdukStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetProdukStatus: ApiStatus.loading,
        apiGetProdukMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiGetProdukStatus: ApiStatus.failure,
            apiGetProdukMessage: 'Sesi anda telah berakhir',
          ),
        );
        return;
      }

      final result = await _kasirService.getListProduk(kodemember);

      if (result.status) {
        var data = result.data;
        emit(
          state.copyWith(
            apiGetProdukStatus: ApiStatus.success,
            produkList: data ?? [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiGetProdukStatus: ApiStatus.failure,
            apiGetProdukMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET PRODUK: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetProdukStatus: ApiStatus.failure,
          apiGetProdukMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION GET PRODUK: $e");
      emit(
        state.copyWith(
          apiGetProdukStatus: ApiStatus.failure,
          apiGetProdukMessage: "Terjadi kesalahan: $e",
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

  Future<bool> tambahProduk(
    BuildContext context, {
    required String namaProduk,
    required int hargaModal,
    required int hargaJual,
    required String satuan,
  }) async {
    if (state.apiTambahProdukStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiTambahProdukStatus: ApiStatus.loading,
        apiTambahProdukMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";

      final result = await _kasirService.tambahProduk(
        kodemember: kodemember,
        namaproduk: namaProduk,
        hargamodal: hargaModal,
        hargaproduk: hargaJual,
        satuan: satuan,
      );

      if (result.status) {
        emit(state.copyWith(apiTambahProdukStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menambahkan produk.");
        getProdukList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiTambahProdukStatus: ApiStatus.failure,
            apiTambahProdukMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION TAMBAH PRODUK: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiTambahProdukStatus: ApiStatus.failure,
          apiTambahProdukMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> ubahProduk(
    BuildContext context, {
    required int idProduk,
    required String namaProduk,
    required int hargaModal,
    required int hargaJual,
    required String satuan,
  }) async {
    if (state.apiUbahProdukStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiUbahProdukStatus: ApiStatus.loading,
        apiUbahProdukMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";
      final result = await _kasirService.ubahProduk(
        idproduk: idProduk,
        kodemember: kodemember,
        namaproduk: namaProduk,
        hargamodal: hargaModal,
        hargaproduk: hargaJual,
        satuan: satuan,
      );

      if (result.status) {
        emit(state.copyWith(apiUbahProdukStatus: ApiStatus.success));
        showSuccessMessage("Berhasil mengubah produk.");
        getProdukList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiUbahProdukStatus: ApiStatus.failure,
            apiUbahProdukMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION UBAH PRODUK: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiUbahProdukStatus: ApiStatus.failure,
          apiUbahProdukMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> hapusProduk(
    BuildContext context, {
    required int idProduk,
  }) async {
    if (state.apiHapusProdukStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiHapusProdukStatus: ApiStatus.loading,
        apiHapusProdukMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";
      final result = await _kasirService.hapusProduk(
        idproduk: idProduk,
        kodemember: kodemember,
      );

      if (result.status) {
        emit(state.copyWith(apiHapusProdukStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menghapus produk.");
        getProdukList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiHapusProdukStatus: ApiStatus.failure,
            apiHapusProdukMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION HAPUS PRODUK: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiHapusProdukStatus: ApiStatus.failure,
          apiHapusProdukMessage: e.message,
        ),
      );
      return false;
    }
  }
}

MemberProdukProvider getMemberProdukProvider(BuildContext context) =>
    context.read<MemberProdukProvider>();
