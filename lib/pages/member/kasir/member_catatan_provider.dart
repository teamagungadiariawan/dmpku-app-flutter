import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/catatan_response.dart';
import 'package:dmpku/service/member/kasir_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberCatatanState extends Equatable {
  // List Catatan API
  final ApiStatus apiGetCatatanStatus;
  final String apiGetCatatanMessage;
  final List<CatatanModel> catatanList;
  final List<CatatanModel> catatanFiltered;

  // Search Filter
  final String searchQuery;
  final TextEditingController? searchController;

  // Tambah Catatan API
  final ApiStatus apiTambahCatatanStatus;
  final String apiTambahCatatanMessage;

  // Ubah Catatan API
  final ApiStatus apiUbahCatatanStatus;
  final String apiUbahCatatanMessage;

  // Hapus Catatan API
  final ApiStatus apiHapusCatatanStatus;
  final String apiHapusCatatanMessage;

  const MemberCatatanState({
    this.apiGetCatatanStatus = ApiStatus.initial,
    this.apiGetCatatanMessage = '',
    this.catatanList = const [],
    this.catatanFiltered = const [],
    this.searchQuery = '',
    this.searchController,
    this.apiTambahCatatanStatus = ApiStatus.initial,
    this.apiTambahCatatanMessage = '',
    this.apiUbahCatatanStatus = ApiStatus.initial,
    this.apiUbahCatatanMessage = '',
    this.apiHapusCatatanStatus = ApiStatus.initial,
    this.apiHapusCatatanMessage = '',
  });

  MemberCatatanState copyWith({
    ApiStatus? apiGetCatatanStatus,
    String? apiGetCatatanMessage,
    List<CatatanModel>? catatanList,
    List<CatatanModel>? catatanFiltered,
    String? searchQuery,
    TextEditingController? searchController,
    ApiStatus? apiTambahCatatanStatus,
    String? apiTambahCatatanMessage,
    ApiStatus? apiUbahCatatanStatus,
    String? apiUbahCatatanMessage,
    ApiStatus? apiHapusCatatanStatus,
    String? apiHapusCatatanMessage,
  }) {
    return MemberCatatanState(
      apiGetCatatanStatus: apiGetCatatanStatus ?? this.apiGetCatatanStatus,
      apiGetCatatanMessage: apiGetCatatanMessage ?? this.apiGetCatatanMessage,
      catatanList: catatanList ?? this.catatanList,
      catatanFiltered: catatanFiltered ?? this.catatanFiltered,
      searchQuery: searchQuery ?? this.searchQuery,
      searchController: searchController ?? this.searchController,
      apiTambahCatatanStatus:
          apiTambahCatatanStatus ?? this.apiTambahCatatanStatus,
      apiTambahCatatanMessage:
          apiTambahCatatanMessage ?? this.apiTambahCatatanMessage,
      apiUbahCatatanStatus: apiUbahCatatanStatus ?? this.apiUbahCatatanStatus,
      apiUbahCatatanMessage:
          apiUbahCatatanMessage ?? this.apiUbahCatatanMessage,
      apiHapusCatatanStatus:
          apiHapusCatatanStatus ?? this.apiHapusCatatanStatus,
      apiHapusCatatanMessage:
          apiHapusCatatanMessage ?? this.apiHapusCatatanMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiGetCatatanStatus,
    apiGetCatatanMessage,
    catatanList,
    catatanFiltered,
    searchQuery,
    searchController,
    apiTambahCatatanStatus,
    apiTambahCatatanMessage,
    apiUbahCatatanStatus,
    apiUbahCatatanMessage,
    apiHapusCatatanStatus,
    apiHapusCatatanMessage,
  ];
}

class MemberCatatanProvider extends Cubit<MemberCatatanState> {
  final _kasirService = KasirService();

  MemberCatatanProvider()
    : super(MemberCatatanState(searchController: TextEditingController()));

  // Get Catatan List
  Future<void> getCatatanList() async {
    // Unlike original, we might want to refresh even if loading if triggered manually,
    // but standard pattern often blocks. Keeping guard for now.
    if (state.apiGetCatatanStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetCatatanStatus: ApiStatus.loading,
        apiGetCatatanMessage: '',
      ),
    );

    try {
      final result = await _kasirService.getCatatan();

      if (result.status) {
        var data = result.data;
        List<CatatanModel> list = data?.catatan ?? [];

        // Sorting: Priority descending (1 first)
        // Original logic: sort((a, b) => b.prioritas - a.prioritas)
        list.sort((a, b) => b.prioritas.compareTo(a.prioritas));

        emit(
          state.copyWith(
            apiGetCatatanStatus: ApiStatus.success,
            catatanList: list,
            catatanFiltered: list, // Initially filtered is same as full list
          ),
        );

        // Re-apply filter if search query exists
        filterCatatan();
      } else {
        emit(
          state.copyWith(
            apiGetCatatanStatus: ApiStatus.failure,
            apiGetCatatanMessage: result.message,
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET CATATAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetCatatanStatus: ApiStatus.failure,
          apiGetCatatanMessage: e.message,
        ),
      );
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    _updateController(state.searchController, query);
    filterCatatan();
  }

  void _updateController(TextEditingController? controller, String value) {
    if (controller?.text != value) {
      controller?.text = value;
      controller?.selection = TextSelection.fromPosition(
        TextPosition(offset: value.length),
      );
    }
  }

  void filterCatatan() {
    final query = state.searchQuery.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(catatanFiltered: List.from(state.catatanList)));
    } else {
      final filtered = state.catatanList.where((catatan) {
        return catatan.judul.toLowerCase().contains(query);
      }).toList();
      emit(state.copyWith(catatanFiltered: filtered));
    }
  }

  Future<bool> tambahCatatan(
    BuildContext context, {
    required String judul,
    required String isicatatan,
    required int perioritas,
  }) async {
    if (state.apiTambahCatatanStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiTambahCatatanStatus: ApiStatus.loading,
        apiTambahCatatanMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";

      final payload = TambahCatatanPayload(
        kodemember: kodemember,
        judul: judul,
        isicatatan: isicatatan,
        perioritas: perioritas,
      );

      final result = await _kasirService.tambahCatatan(payload);

      if (result.status) {
        emit(state.copyWith(apiTambahCatatanStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menambahkan catatan.");
        getCatatanList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiTambahCatatanStatus: ApiStatus.failure,
            apiTambahCatatanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION TAMBAH CATATAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiTambahCatatanStatus: ApiStatus.failure,
          apiTambahCatatanMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> ubahCatatan(
    BuildContext context, {
    required int idcatatan,
    required String judul,
    required String isicatatan,
    required int perioritas,
  }) async {
    if (state.apiUbahCatatanStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiUbahCatatanStatus: ApiStatus.loading,
        apiUbahCatatanMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";

      final payload = UbahCatatanPayload(
        idcatatan: idcatatan,
        kodemember: kodemember,
        judul: judul,
        isicatatan: isicatatan,
        perioritas: perioritas,
      );

      final result = await _kasirService.ubahCatatan(payload);

      if (result.status) {
        emit(state.copyWith(apiUbahCatatanStatus: ApiStatus.success));
        showSuccessMessage("Berhasil mengubah catatan.");
        getCatatanList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiUbahCatatanStatus: ApiStatus.failure,
            apiUbahCatatanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION UBAH CATATAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiUbahCatatanStatus: ApiStatus.failure,
          apiUbahCatatanMessage: e.message,
        ),
      );
      return false;
    }
  }

  // Specifically for toggling priority, behaving like 'sematkan' / 'lepaskan pin'
  Future<void> togglePinCatatan(BuildContext context, CatatanModel item) async {
    int newPriority = item.prioritas == 1 ? 0 : 1;
    // Reusing ubahCatatan for simplicity
    await ubahCatatan(
      context,
      idcatatan: item.idcatatan,
      judul: item.judul,
      isicatatan: item.isicatatan,
      perioritas: newPriority,
    );
  }

  Future<bool> deleteCatatan(
    BuildContext context, {
    required int idcatatan,
  }) async {
    if (state.apiHapusCatatanStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiHapusCatatanStatus: ApiStatus.loading,
        apiHapusCatatanMessage: '',
      ),
    );

    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember() ?? "";

      final payload = HapusCatatanPayload(
        idcatatan: idcatatan,
        kodemember: kodemember,
      );

      final result = await _kasirService.hapusCatatan(payload);

      if (result.status) {
        emit(state.copyWith(apiHapusCatatanStatus: ApiStatus.success));
        showSuccessMessage("Berhasil menghapus catatan.");
        getCatatanList();
        return true;
      } else {
        emit(
          state.copyWith(
            apiHapusCatatanStatus: ApiStatus.failure,
            apiHapusCatatanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION DELETE CATATAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiHapusCatatanStatus: ApiStatus.failure,
          apiHapusCatatanMessage: e.message,
        ),
      );
      return false;
    }
  }
}

MemberCatatanProvider getMemberCatatanProvider(BuildContext context) =>
    context.read<MemberCatatanProvider>();
