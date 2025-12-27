import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/kategori_favorit.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/favorit_response.dart';
import 'package:dmpku/service/member/favorit_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberFavoritState extends Equatable {
  // List Favorit API
  final ApiStatus apiGetFavoritStatus;
  final String apiGetFavoritMessage;
  final List<FavoritModel> favoritList;

  // Search Filter
  final String searchQuery;
  final TextEditingController? searchController;

  // Tambah Favorit API
  final ApiStatus apiTambahFavoritStatus;
  final String apiTambahFavoritMessage;

  // Ubah Favorit API
  final ApiStatus apiUbahFavoritStatus;
  final String apiUbahFavoritMessage;

  // Hapus Favorit API
  final ApiStatus apiHapusFavoritStatus;
  final String apiHapusFavoritMessage;

  const MemberFavoritState({
    this.apiGetFavoritStatus = ApiStatus.initial,
    this.apiGetFavoritMessage = '',
    this.favoritList = const [],
    this.searchQuery = '',
    this.searchController,
    this.apiTambahFavoritStatus = ApiStatus.initial,
    this.apiTambahFavoritMessage = '',
    this.apiUbahFavoritStatus = ApiStatus.initial,
    this.apiUbahFavoritMessage = '',
    this.apiHapusFavoritStatus = ApiStatus.initial,
    this.apiHapusFavoritMessage = '',
  });

  MemberFavoritState copyWith({
    ApiStatus? apiGetFavoritStatus,
    String? apiGetFavoritMessage,
    List<FavoritModel>? favoritList,
    String? searchQuery,
    TextEditingController? searchController,
    ApiStatus? apiTambahFavoritStatus,
    String? apiTambahFavoritMessage,
    ApiStatus? apiUbahFavoritStatus,
    String? apiUbahFavoritMessage,
    ApiStatus? apiHapusFavoritStatus,
    String? apiHapusFavoritMessage,
  }) {
    return MemberFavoritState(
      apiGetFavoritStatus: apiGetFavoritStatus ?? this.apiGetFavoritStatus,
      apiGetFavoritMessage: apiGetFavoritMessage ?? this.apiGetFavoritMessage,
      favoritList: favoritList ?? this.favoritList,
      searchQuery: searchQuery ?? this.searchQuery,
      searchController: searchController ?? this.searchController,
      apiTambahFavoritStatus:
          apiTambahFavoritStatus ?? this.apiTambahFavoritStatus,
      apiTambahFavoritMessage:
          apiTambahFavoritMessage ?? this.apiTambahFavoritMessage,
      apiUbahFavoritStatus: apiUbahFavoritStatus ?? this.apiUbahFavoritStatus,
      apiUbahFavoritMessage:
          apiUbahFavoritMessage ?? this.apiUbahFavoritMessage,
      apiHapusFavoritStatus:
          apiHapusFavoritStatus ?? this.apiHapusFavoritStatus,
      apiHapusFavoritMessage:
          apiHapusFavoritMessage ?? this.apiHapusFavoritMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiGetFavoritStatus,
    apiGetFavoritMessage,
    favoritList,

    searchQuery,
    searchController,
    apiTambahFavoritStatus,
    apiTambahFavoritMessage,
    apiUbahFavoritStatus,
    apiUbahFavoritMessage,
    apiHapusFavoritStatus,
    apiHapusFavoritMessage,
  ];
}

class MemberFavoritProvider extends Cubit<MemberFavoritState> {
  final _favoritService = FavoritService();

  MemberFavoritProvider()
    : super(MemberFavoritState(searchController: TextEditingController()));

  @override
  Future<void> close() {
    state.searchController?.dispose();
    return super.close();
  }

  // Get Favorit List
  Future<void> getFavoritList() async {
    if (state.apiGetFavoritStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetFavoritStatus: ApiStatus.loading,
        apiGetFavoritMessage: '',
      ),
    );

    try {
      final result = await _favoritService.getFavorit();

      if (result.status) {
        var data = result.data;
        if (data != null) {
          emit(
            state.copyWith(
              apiGetFavoritStatus: ApiStatus.success,
              favoritList: data.favorit,
            ),
          );
        } else {
          emit(
            state.copyWith(
              apiGetFavoritStatus: ApiStatus.success,
              favoritList: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiGetFavoritStatus: ApiStatus.failure,
            apiGetFavoritMessage: result.message,
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET FAVORIT: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetFavoritStatus: ApiStatus.failure,
          apiGetFavoritMessage: e.message,
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

  Future<bool> saveFavorit(
    BuildContext context, {
    required Kategori kategori,
    required String nama,
    required String nomor,
  }) async {
    if (state.apiTambahFavoritStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiTambahFavoritStatus: ApiStatus.loading,
        apiTambahFavoritMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";

      final result = await _favoritService.tambahFavorit(
        nama: nama,
        nomor: nomor,
        namakategori: kategori.label,
        idkategori: kategori.id,
        kodemember: kodemember,
      );

      if (result.status) {
        emit(state.copyWith(apiTambahFavoritStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menambahkan favorit.");
        getFavoritList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiTambahFavoritStatus: ApiStatus.failure,
            apiTambahFavoritMessage: result.message,
          ),
        );

        showWarningMessage(result.message);

        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION SAVE FAVORIT: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiTambahFavoritStatus: ApiStatus.failure,
          apiTambahFavoritMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> editFavorit(
    BuildContext context, {
    required Kategori kategori,
    required int idfavorit,
    required String nama,
    required String nomor,
  }) async {
    if (state.apiUbahFavoritStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiUbahFavoritStatus: ApiStatus.loading,
        apiUbahFavoritMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";
      final result = await _favoritService.ubahFavorit(
        idfavorit: idfavorit,
        nama: nama,
        nomor: nomor,
        namakategori: kategori.label,
        idkategori: kategori.id,
        kodemember: kodemember,
      );

      if (result.status) {
        emit(state.copyWith(apiUbahFavoritStatus: ApiStatus.success));
        showSuccessMessage("Berhasil mengubah favorit.");
        getFavoritList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiUbahFavoritStatus: ApiStatus.failure,
            apiUbahFavoritMessage: result.message,
          ),
        );

        showWarningMessage(result.message);

        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION EDIT FAVORIT: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiUbahFavoritStatus: ApiStatus.failure,
          apiUbahFavoritMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> deleteFavorit(
    BuildContext context, {
    required int idfavorit,
  }) async {
    if (state.apiHapusFavoritStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiHapusFavoritStatus: ApiStatus.loading,
        apiHapusFavoritMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";
      final result = await _favoritService.hapusFavorit(
        idfavorit: idfavorit,
        kodemember: kodemember,
      );

      if (result.status) {
        emit(state.copyWith(apiHapusFavoritStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menghapus favorit.");
        getFavoritList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiHapusFavoritStatus: ApiStatus.failure,
            apiHapusFavoritMessage: result.message,
          ),
        );

        showWarningMessage(result.message);

        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION DELETE FAVORIT: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiHapusFavoritStatus: ApiStatus.failure,
          apiHapusFavoritMessage: e.message,
        ),
      );
      return false;
    }
  }
}

MemberFavoritProvider getMemberFavoritProvider(BuildContext context) =>
    context.read<MemberFavoritProvider>();
