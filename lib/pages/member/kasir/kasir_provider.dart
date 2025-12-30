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
import 'package:dmpku/model/kasir_payload.dart';

class KasirState extends Equatable {
  // Get Penjualan API
  final ApiStatus apiGetPenjualanStatus;
  final String apiGetPenjualanMessage;
  final DateTime tanggalPenjualan;
  final List<PenjualanModel> listPenjualan;
  // Input Penjualan API
  final ApiStatus apiInputPenjualanStatus;
  final String apiInputPenjualanMessage;
  // Get Produk API
  final ApiStatus apiGetProdukStatus;
  final String apiGetProdukMessage;
  final List<ProdukModel> listProduk;
  // Get Pelanggan API
  final ApiStatus apiGetPelangganStatus;
  final String apiGetPelangganMessage;
  final List<PelangganModel> listPelanggan;
  final PelangganModel? selectedPelanggan;
  // Tambah Produk Manual API
  final ApiStatus apiTambahProdukStatus;
  final String apiTambahProdukMessage;
  // Cart
  final List<CartItem> cartItems;
  // Refund
  final ApiStatus apiRefundStatus;
  final String apiRefundMessage;
  // Sukseskan
  final ApiStatus apiSukseskanStatus;
  final String apiSukseskanMessage;
  final PenjualanModel? selectedPenjualan;
  // Detail Penjualan
  final ApiStatus apiGetDetailPenjualanStatus;
  final String apiGetDetailPenjualanMessage;
  final List<ListPenjualanDetailModel> listPenjualanDetail;
  // Laporan Kasir
  final ApiStatus apiGetLaporanKasirStatus;
  final String apiGetLaporanKasirMessage;
  final List<LaporanKasirModel> listLaporanKasir;
  final List<TotalLaporanKasirModel> listTotalLaporanKasir;
  final DateTime tanggalLaporanAwal;
  final DateTime tanggalLaporanAkhir;

  const KasirState({
    this.apiGetPenjualanStatus = ApiStatus.initial,
    this.apiGetPenjualanMessage = '',
    required this.tanggalPenjualan,
    this.listPenjualan = const [],
    // Input Penjualan
    this.apiInputPenjualanStatus = ApiStatus.initial,
    this.apiInputPenjualanMessage = '',
    // Produk
    this.apiGetProdukStatus = ApiStatus.initial,
    this.apiGetProdukMessage = '',
    this.listProduk = const [],
    // Pelanggan
    this.apiGetPelangganStatus = ApiStatus.initial,
    this.apiGetPelangganMessage = '',
    this.listPelanggan = const [],
    this.selectedPelanggan,
    // Tambah Produk Manual
    this.apiTambahProdukStatus = ApiStatus.initial,
    this.apiTambahProdukMessage = '',
    // Cart
    this.cartItems = const [],
    // Refund
    this.apiRefundStatus = ApiStatus.initial,
    this.apiRefundMessage = '',
    // Sukseskan
    this.apiSukseskanStatus = ApiStatus.initial,
    this.apiSukseskanMessage = '',
    this.selectedPenjualan,
    // Detail Penjualan
    this.apiGetDetailPenjualanStatus = ApiStatus.initial,
    this.apiGetDetailPenjualanMessage = '',
    this.listPenjualanDetail = const [],
    // Laporan Kasir
    this.apiGetLaporanKasirStatus = ApiStatus.initial,
    this.apiGetLaporanKasirMessage = '',
    this.listLaporanKasir = const [],
    this.listTotalLaporanKasir = const [],
    required this.tanggalLaporanAwal,
    required this.tanggalLaporanAkhir,
  });

  KasirState copyWith({
    ApiStatus? apiGetPenjualanStatus,
    String? apiGetPenjualanMessage,
    DateTime? tanggalPenjualan,
    List<PenjualanModel>? listPenjualan,
    // Input Penjualan
    ApiStatus? apiInputPenjualanStatus,
    String? apiInputPenjualanMessage,
    // Produk
    ApiStatus? apiGetProdukStatus,
    String? apiGetProdukMessage,
    List<ProdukModel>? listProduk,
    // Pelanggan
    ApiStatus? apiGetPelangganStatus,
    String? apiGetPelangganMessage,
    List<PelangganModel>? listPelanggan,
    PelangganModel? selectedPelanggan,
    // Tambah Produk Manual
    ApiStatus? apiTambahProdukStatus,
    String? apiTambahProdukMessage,
    // Cart
    List<CartItem>? cartItems,
    // Refund
    ApiStatus? apiRefundStatus,
    String? apiRefundMessage,
    // Sukseskan
    ApiStatus? apiSukseskanStatus,
    String? apiSukseskanMessage,
    PenjualanModel? selectedPenjualan,
    // Detail Penjualan
    ApiStatus? apiGetDetailPenjualanStatus,
    String? apiGetDetailPenjualanMessage,
    List<ListPenjualanDetailModel>? listPenjualanDetail,
    // Laporan Kasir
    ApiStatus? apiGetLaporanKasirStatus,
    String? apiGetLaporanKasirMessage,
    List<LaporanKasirModel>? listLaporanKasir,
    List<TotalLaporanKasirModel>? listTotalLaporanKasir,
    DateTime? tanggalLaporanAwal,
    DateTime? tanggalLaporanAkhir,
    // Clear Flags
    bool clearSelectedPelanggan = false,
    bool clearSelectedPenjualan = false,
  }) {
    return KasirState(
      apiGetPenjualanStatus:
          apiGetPenjualanStatus ?? this.apiGetPenjualanStatus,
      apiGetPenjualanMessage:
          apiGetPenjualanMessage ?? this.apiGetPenjualanMessage,
      tanggalPenjualan: tanggalPenjualan ?? this.tanggalPenjualan,
      listPenjualan: listPenjualan ?? this.listPenjualan,
      apiInputPenjualanStatus:
          apiInputPenjualanStatus ?? this.apiInputPenjualanStatus,
      apiInputPenjualanMessage:
          apiInputPenjualanMessage ?? this.apiInputPenjualanMessage,
      apiGetProdukStatus: apiGetProdukStatus ?? this.apiGetProdukStatus,
      apiGetProdukMessage: apiGetProdukMessage ?? this.apiGetProdukMessage,
      listProduk: listProduk ?? this.listProduk,
      apiGetPelangganStatus:
          apiGetPelangganStatus ?? this.apiGetPelangganStatus,
      apiGetPelangganMessage:
          apiGetPelangganMessage ?? this.apiGetPelangganMessage,
      listPelanggan: listPelanggan ?? this.listPelanggan,
      selectedPelanggan: clearSelectedPelanggan
          ? null
          : (selectedPelanggan ?? this.selectedPelanggan),
      apiTambahProdukStatus:
          apiTambahProdukStatus ?? this.apiTambahProdukStatus,
      apiTambahProdukMessage:
          apiTambahProdukMessage ?? this.apiTambahProdukMessage,
      cartItems: cartItems ?? this.cartItems,
      apiRefundStatus: apiRefundStatus ?? this.apiRefundStatus,
      apiRefundMessage: apiRefundMessage ?? this.apiRefundMessage,
      apiSukseskanStatus: apiSukseskanStatus ?? this.apiSukseskanStatus,
      apiSukseskanMessage: apiSukseskanMessage ?? this.apiSukseskanMessage,
      selectedPenjualan: clearSelectedPenjualan
          ? null
          : (selectedPenjualan ?? this.selectedPenjualan),
      apiGetDetailPenjualanStatus:
          apiGetDetailPenjualanStatus ?? this.apiGetDetailPenjualanStatus,
      apiGetDetailPenjualanMessage:
          apiGetDetailPenjualanMessage ?? this.apiGetDetailPenjualanMessage,
      listPenjualanDetail: listPenjualanDetail ?? this.listPenjualanDetail,
      apiGetLaporanKasirStatus:
          apiGetLaporanKasirStatus ?? this.apiGetLaporanKasirStatus,
      apiGetLaporanKasirMessage:
          apiGetLaporanKasirMessage ?? this.apiGetLaporanKasirMessage,
      listLaporanKasir: listLaporanKasir ?? this.listLaporanKasir,
      listTotalLaporanKasir:
          listTotalLaporanKasir ?? this.listTotalLaporanKasir,
      tanggalLaporanAwal: tanggalLaporanAwal ?? this.tanggalLaporanAwal,
      tanggalLaporanAkhir: tanggalLaporanAkhir ?? this.tanggalLaporanAkhir,
    );
  }

  @override
  List<Object?> get props => [
    apiGetPenjualanStatus,
    apiGetPenjualanMessage,
    tanggalPenjualan,
    listPenjualan,
    apiInputPenjualanStatus,
    apiInputPenjualanMessage,
    apiGetProdukStatus,
    apiGetProdukMessage,
    listProduk,
    apiGetPelangganStatus,
    apiGetPelangganMessage,
    listPelanggan,
    selectedPelanggan,
    apiTambahProdukStatus,
    apiTambahProdukMessage,
    cartItems,
    apiRefundStatus,
    apiRefundMessage,
    apiSukseskanStatus,
    apiSukseskanMessage,
    selectedPenjualan,
    apiGetDetailPenjualanStatus,
    apiGetDetailPenjualanMessage,
    listPenjualanDetail,
    apiGetLaporanKasirStatus,
    apiGetLaporanKasirMessage,
    listLaporanKasir,
    listTotalLaporanKasir,
    tanggalLaporanAwal,
    tanggalLaporanAkhir,
  ];
}

class CartItem extends Equatable {
  final ProdukModel produk;
  final int quantity;
  final bool isTemporary;

  const CartItem({
    required this.produk,
    this.quantity = 1,
    this.isTemporary = false,
  });

  CartItem copyWith({ProdukModel? produk, int? quantity, bool? isTemporary}) {
    return CartItem(
      produk: produk ?? this.produk,
      quantity: quantity ?? this.quantity,
      isTemporary: isTemporary ?? this.isTemporary,
    );
  }

  @override
  List<Object?> get props => [produk, quantity, isTemporary];
}

class KasirProvider extends Cubit<KasirState> {
  final KasirService _kasirService = KasirService();

  KasirProvider()
    : super(
        KasirState(
          tanggalPenjualan: DateTime.now(), // Default to today
          tanggalLaporanAwal: DateTime.now(),
          tanggalLaporanAkhir: DateTime.now(),
        ),
      );

  // ===========================================================================
  // LIST PENJUALAN
  // ===========================================================================
  Future<void> fetchListPenjualan() async {
    if (state.apiGetPenjualanStatus.isLoading) return;
    if (isClosed) return;

    emit(
      state.copyWith(
        apiGetPenjualanStatus: ApiStatus.loading,
        apiGetPenjualanMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (isClosed) return;
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

      if (isClosed) return;
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
      if (isClosed) return;
      emit(
        state.copyWith(
          apiGetPenjualanStatus: ApiStatus.failure,
          apiGetPenjualanMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION FETCH LIST PENJUALAN: $e");
      if (isClosed) return;
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

  Future<void> fetchListPenjualanDetail(int idPenjualan) async {
    if (state.apiGetDetailPenjualanStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetDetailPenjualanStatus: ApiStatus.loading,
        apiGetDetailPenjualanMessage: '',
        listPenjualanDetail: [],
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';
      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiGetDetailPenjualanStatus: ApiStatus.failure,
            apiGetDetailPenjualanMessage: 'Sesi anda telah berakhir',
          ),
        );
        return;
      }

      final result = await _kasirService.getListPenjualanDetail(
        idpenjualan: idPenjualan,
        kodemember: kodemember,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiGetDetailPenjualanStatus: ApiStatus.failure,
            apiGetDetailPenjualanMessage: result.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiGetDetailPenjualanStatus: ApiStatus.success,
          listPenjualanDetail: result.data ?? [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiGetDetailPenjualanStatus: ApiStatus.failure,
          apiGetDetailPenjualanMessage: e.toString(),
        ),
      );
    }
  }

  // ===========================================================================
  // LIST PRODUK
  // ===========================================================================
  Future<void> fetchListProduk() async {
    if (state.apiGetProdukStatus.isLoading) return;
    if (isClosed) return;

    emit(
      state.copyWith(
        apiGetProdukStatus: ApiStatus.loading,
        apiGetProdukMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (isClosed) return;
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

      if (isClosed) return;
      if (!result.status) {
        emit(
          state.copyWith(
            apiGetProdukStatus: ApiStatus.failure,
            apiGetProdukMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      final data = result.data;

      if (data == null) {
        emit(
          state.copyWith(
            apiGetProdukStatus: ApiStatus.failure,
            apiGetProdukMessage: 'Data produk kosong',
            listProduk: [],
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiGetProdukStatus: ApiStatus.success,
          apiGetProdukMessage: '',
          listProduk: data,
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH LIST PRODUK: ${e.message}");
      showWarningMessage(e.message);
      if (isClosed) return;
      emit(
        state.copyWith(
          apiGetProdukStatus: ApiStatus.failure,
          apiGetProdukMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION FETCH LIST PRODUK: $e");
      if (isClosed) return;
      emit(
        state.copyWith(
          apiGetProdukStatus: ApiStatus.failure,
          apiGetProdukMessage: "Terjadi kesalahan: $e",
        ),
      );
    }
  }

  // ===========================================================================
  // LIST PELANGGAN
  // ===========================================================================
  Future<void> fetchListPelanggan() async {
    if (state.apiGetPelangganStatus.isLoading) return;
    if (isClosed) return;

    emit(
      state.copyWith(
        apiGetPelangganStatus: ApiStatus.loading,
        apiGetPelangganMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (isClosed) return;
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

      if (isClosed) return;
      if (!result.status) {
        emit(
          state.copyWith(
            apiGetPelangganStatus: ApiStatus.failure,
            apiGetPelangganMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      final data = result.data;

      if (data == null) {
        emit(
          state.copyWith(
            apiGetPelangganStatus: ApiStatus.failure,
            apiGetPelangganMessage: 'Data pelanggan kosong',
            listPelanggan: [],
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiGetPelangganStatus: ApiStatus.success,
          apiGetPelangganMessage: '',
          listPelanggan: data,
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH LIST PELANGGAN: ${e.message}");
      showWarningMessage(e.message);
      if (isClosed) return;
      emit(
        state.copyWith(
          apiGetPelangganStatus: ApiStatus.failure,
          apiGetPelangganMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION FETCH LIST PELANGGAN: $e");
      if (isClosed) return;
      emit(
        state.copyWith(
          apiGetPelangganStatus: ApiStatus.failure,
          apiGetPelangganMessage: "Terjadi kesalahan: $e",
        ),
      );
    }
  }

  void onChangeSelectedPelanggan(PelangganModel? pelanggan) {
    emit(
      state.copyWith(
        selectedPelanggan: pelanggan,
        clearSelectedPelanggan: pelanggan == null,
      ),
    );
  }

  void setSelectedPenjualan(PenjualanModel? penjualan) {
    emit(
      state.copyWith(
        selectedPenjualan: penjualan,
        clearSelectedPenjualan: penjualan == null,
      ),
    );
  }

  // ===========================================================================
  // CART MANAGEMENT
  // ===========================================================================
  void addToCart(ProdukModel produk, {bool isTemporary = false}) {
    final List<CartItem> currentCart = List.from(state.cartItems);
    final index = currentCart.indexWhere(
      (item) => item.produk.idproduk == produk.idproduk,
    );

    if (index != -1) {
      // Update existing item
      final existingItem = currentCart[index];
      currentCart[index] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      // Add new item
      currentCart.add(
        CartItem(produk: produk, quantity: 1, isTemporary: isTemporary),
      );
    }

    emit(state.copyWith(cartItems: currentCart));
  }

  Future<void> removeFromCart(ProdukModel produk) async {
    final List<CartItem> currentCart = List.from(state.cartItems);
    final index = currentCart.indexWhere(
      (item) => item.produk.idproduk == produk.idproduk,
    );

    if (index == -1) return;

    final itemToRemove = currentCart[index];
    currentCart.removeAt(index);
    emit(state.copyWith(cartItems: currentCart));

    // If temporary, delete from server
    if (itemToRemove.isTemporary) {
      try {
        final kodemember =
            await SecureStorageHelper.instance.getKodeMember() ?? '';
        if (kodemember.isNotEmpty) {
          await _kasirService.hapusProduk(
            idproduk: itemToRemove.produk.idproduk,
            kodemember: kodemember,
          );
          // Refresh product list to reflect deletion
          fetchListProduk();
        }
      } catch (e) {
        debugPrint(
          "Failed to delete temporary product ${itemToRemove.produk.namaproduk}: $e",
        );
      }
    }
  }

  void updateCartQuantity(ProdukModel produk, int quantity) {
    if (quantity <= 0) {
      removeFromCart(produk);
      return;
    }

    final List<CartItem> currentCart = List.from(state.cartItems);
    final index = currentCart.indexWhere(
      (item) => item.produk.idproduk == produk.idproduk,
    );

    if (index != -1) {
      currentCart[index] = currentCart[index].copyWith(quantity: quantity);
      emit(state.copyWith(cartItems: currentCart));
    }
  }

  Future<void> clearCart() async {
    // Identify temporary items before clearing
    final temporaryItems = state.cartItems
        .where((item) => item.isTemporary)
        .toList();

    emit(state.copyWith(cartItems: [], selectedPelanggan: null));

    // Delete temporary items
    if (temporaryItems.isNotEmpty) {
      try {
        final kodemember =
            await SecureStorageHelper.instance.getKodeMember() ?? '';
        if (kodemember.isNotEmpty) {
          for (final item in temporaryItems) {
            try {
              await _kasirService.hapusProduk(
                idproduk: item.produk.idproduk,
                kodemember: kodemember,
              );
            } catch (e) {
              debugPrint("Failed to delete temp item: $e");
            }
          }
          // Refresh product list
          fetchListProduk();
        }
      } catch (e) {
        debugPrint("Error in clearCart cleanup: $e");
      }
    }
  }

  // ===========================================================================
  // TAMBAH PRODUK MANUAL
  // ===========================================================================
  Future<bool> tambahProdukManual({
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
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiTambahProdukStatus: ApiStatus.failure,
            apiTambahProdukMessage: 'Sesi anda telah berakhir',
          ),
        );
        return false;
      }

      // 1. Call API tambah produk
      final result = await _kasirService.tambahProduk(
        kodemember: kodemember,
        namaproduk: namaProduk,
        hargamodal: hargaModal,
        hargaproduk: hargaJual,
        satuan: satuan,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiTambahProdukStatus: ApiStatus.failure,
            apiTambahProdukMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      // 2. Fetch list produk to get the new list with ID
      final listResult = await _kasirService.getListProduk(kodemember);
      if (!listResult.status || listResult.data == null) {
        emit(
          state.copyWith(
            apiTambahProdukStatus: ApiStatus.failure,
            apiTambahProdukMessage: 'Gagal mengambil data produk terbaru',
          ),
        );
        return false;
      }

      final newList = listResult.data!;
      emit(
        state.copyWith(
          apiTambahProdukStatus: ApiStatus.success,
          apiTambahProdukMessage: 'Produk berhasil ditambahkan',
          listProduk: newList,
        ),
      );

      // 3. Find the new product and add to cart
      // Assuming the new product is the one with the highest ID or matching name
      // We will try to find by name for better accuracy if newly created
      ProdukModel? newProduct;
      try {
        // Try finding exact match by name. If multiple, take the last one (highest ID typically)
        newProduct = newList.lastWhere(
          (p) => p.namaproduk.toLowerCase() == namaProduk.toLowerCase(),
        );
      } catch (e) {
        // Fallback if not found by name
        if (newList.isNotEmpty) {
          newProduct = newList.last; // Assume added at end/highest ID
        }
      }

      if (newProduct != null) {
        addToCart(newProduct, isTemporary: true);
        showSuccessMessage('Produk berhasil ditambahkan ke keranjang');
      } else {
        showSuccessMessage('Produk berhasil disimpan');
      }

      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION TAMBAH PRODUK MANUAL: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiTambahProdukStatus: ApiStatus.failure,
          apiTambahProdukMessage: e.message,
        ),
      );
      return false;
    } catch (e) {
      debugPrint("EXCEPTION TAMBAH PRODUK MANUAL: $e");
      emit(
        state.copyWith(
          apiTambahProdukStatus: ApiStatus.failure,
          apiTambahProdukMessage: "Terjadi kesalahan: $e",
        ),
      );
      return false;
    }
  }

  // ===========================================================================
  // TRANSAKSI
  // ===========================================================================
  Future<bool> processTransaction({
    required int uangPelanggan,
    required int kembalian,
  }) async {
    if (state.cartItems.isEmpty) {
      showWarningMessage('Keranjang masih kosong');
      return false;
    }

    if (state.selectedPelanggan == null) {
      showWarningMessage('Silakan pilih pelanggan terlebih dahulu');
      return false;
    }

    if (state.apiInputPenjualanStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiInputPenjualanStatus: ApiStatus.loading,
        apiInputPenjualanMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiInputPenjualanStatus: ApiStatus.failure,
            apiInputPenjualanMessage: 'Sesi anda telah berakhir',
          ),
        );
        return false;
      }

      // Collect temporary items before processing transaction
      final temporaryItems = state.cartItems
          .where((item) => item.isTemporary)
          .toList();

      final payloads = state.cartItems
          .map(
            (item) => PenjualanPayload(
              idproduk: item.produk.idproduk,
              jumlah: item.quantity,
            ),
          )
          .toList();

      final result = await _kasirService.inputPenjualan(
        uangpelanggan: uangPelanggan,
        idpelanggan: state.selectedPelanggan!.idpelanggan,
        kembalian: kembalian,
        kodemember: kodemember,
        data: payloads,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiInputPenjualanStatus: ApiStatus.failure,
            apiInputPenjualanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      // Success
      emit(
        state.copyWith(
          apiInputPenjualanStatus: ApiStatus.success,
          apiInputPenjualanMessage: 'Transaksi berhasil',
          cartItems: [], // Clear cart
          selectedPelanggan: null,
        ),
      );

      showSuccessMessage('Transaksi berhasil disimpan');

      // Refresh list penjualan
      fetchListPenjualan();

      // Delete temporary items
      if (temporaryItems.isNotEmpty) {
        for (final item in temporaryItems) {
          try {
            await _kasirService.hapusProduk(
              idproduk: item.produk.idproduk,
              kodemember: kodemember,
            );
          } catch (e) {
            debugPrint(
              "Failed to delete temporary product ${item.produk.namaproduk}: $e",
            );
            // Fail silently or just log, transaction is already successful
          }
        }
        // Refresh product list after deletion
        fetchListProduk();
      }

      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION INPUT PENJUALAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiInputPenjualanStatus: ApiStatus.failure,
          apiInputPenjualanMessage: e.message,
        ),
      );
      return false;
    } catch (e) {
      debugPrint("EXCEPTION INPUT PENJUALAN: $e");
      emit(
        state.copyWith(
          apiInputPenjualanStatus: ApiStatus.failure,
          apiInputPenjualanMessage: "Terjadi kesalahan: $e",
        ),
      );
      return false;
    }
  }

  Future<bool> refundTransaction({required int idPenjualan}) async {
    if (state.apiRefundStatus.isLoading) return false;

    emit(
      state.copyWith(apiRefundStatus: ApiStatus.loading, apiRefundMessage: ''),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiRefundStatus: ApiStatus.failure,
            apiRefundMessage: 'Sesi anda telah berakhir',
          ),
        );
        return false;
      }

      final result = await _kasirService.refundPenjualan(
        idpenjualan: idPenjualan,
        kodemember: kodemember,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiRefundStatus: ApiStatus.failure,
            apiRefundMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiRefundStatus: ApiStatus.success,
          apiRefundMessage: 'Refund berhasil',
        ),
      );

      showSuccessMessage('Refund berhasil');
      fetchListPenjualan(); // Refresh list to show updated status
      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION REFUND: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiRefundStatus: ApiStatus.failure,
          apiRefundMessage: e.message,
        ),
      );
      return false;
    } catch (e) {
      debugPrint("EXCEPTION REFUND: $e");
      emit(
        state.copyWith(
          apiRefundStatus: ApiStatus.failure,
          apiRefundMessage: "Terjadi kesalahan: $e",
        ),
      );
      return false;
    }
  }

  Future<bool> sukseskanTransaction({required int idPenjualan}) async {
    if (state.apiSukseskanStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiSukseskanStatus: ApiStatus.loading,
        apiSukseskanMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiSukseskanStatus: ApiStatus.failure,
            apiSukseskanMessage: 'Sesi anda telah berakhir',
          ),
        );
        return false;
      }

      final result = await _kasirService.sukseskanPenjualan(
        idpenjualan: idPenjualan,
        kodemember: kodemember,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiSukseskanStatus: ApiStatus.failure,
            apiSukseskanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return false;
      }

      emit(
        state.copyWith(
          apiSukseskanStatus: ApiStatus.success,
          apiSukseskanMessage: 'Transaksi berhasil disukseskan',
        ),
      );

      showSuccessMessage('Transaksi berhasil disukseskan');
      fetchListPenjualan(); // Refresh list to show updated status
      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION SUKSESKAN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiSukseskanStatus: ApiStatus.failure,
          apiSukseskanMessage: e.message,
        ),
      );
      return false;
    } catch (e) {
      debugPrint("EXCEPTION SUKSESKAN: $e");
      emit(
        state.copyWith(
          apiSukseskanStatus: ApiStatus.failure,
          apiSukseskanMessage: "Terjadi kesalahan: $e",
        ),
      );
      return false;
    }
  }

  // ===========================================================================
  // LAPORAN KASIR
  // ===========================================================================
  void setTanggalLaporan(DateTime awal, DateTime akhir) {
    emit(state.copyWith(tanggalLaporanAwal: awal, tanggalLaporanAkhir: akhir));
  }

  Future<void> fetchLaporanKasir() async {
    if (state.apiGetLaporanKasirStatus.isLoading) return;
    if (isClosed) return;

    emit(
      state.copyWith(
        apiGetLaporanKasirStatus: ApiStatus.loading,
        apiGetLaporanKasirMessage: '',
      ),
    );

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) {
        emit(
          state.copyWith(
            apiGetLaporanKasirStatus: ApiStatus.failure,
            apiGetLaporanKasirMessage: 'Sesi anda telah berakhir',
            listLaporanKasir: [],
          ),
        );
        return;
      }

      final waktuAwal = DateHelper.formatYYYYMMDD(state.tanggalLaporanAwal);
      final waktuAkhir = DateHelper.formatYYYYMMDD(state.tanggalLaporanAkhir);

      final result = await _kasirService.getLaporanKasir(
        kodemember: kodemember,
        waktuawal: waktuAwal,
        waktuakhir: waktuAkhir,
      );

      if (!result.status || result.data == null) {
        emit(
          state.copyWith(
            apiGetLaporanKasirStatus: ApiStatus.failure,
            apiGetLaporanKasirMessage: result.message,
            listLaporanKasir: [],
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiGetLaporanKasirStatus: ApiStatus.success,
          apiGetLaporanKasirMessage: result.message,
          listLaporanKasir: result.data,
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET LAPORAN KASIR: ${e.message}");
      emit(
        state.copyWith(
          apiGetLaporanKasirStatus: ApiStatus.failure,
          apiGetLaporanKasirMessage: e.message,
          listLaporanKasir: [],
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION GET LAPORAN KASIR: $e");
      emit(
        state.copyWith(
          apiGetLaporanKasirStatus: ApiStatus.failure,
          apiGetLaporanKasirMessage: "Terjadi kesalahan: $e",
          listLaporanKasir: [],
        ),
      );
    }
  }

  Future<void> fetchTotalLaporanKasir() async {
    if (isClosed) return;

    try {
      final kodemember =
          await SecureStorageHelper.instance.getKodeMember() ?? '';

      if (kodemember.isEmpty) return;

      final waktuAwal = DateHelper.formatYYYYMMDD(state.tanggalLaporanAwal);
      final waktuAkhir = DateHelper.formatYYYYMMDD(state.tanggalLaporanAkhir);

      final result = await _kasirService.getTotalLaporanKasir(
        kodemember: kodemember,
        waktuawal: waktuAwal,
        waktuakhir: waktuAkhir,
      );

      if (!result.status || result.data == null) {
        emit(state.copyWith(listTotalLaporanKasir: []));
        return;
      }

      emit(state.copyWith(listTotalLaporanKasir: result.data));
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET TOTAL LAPORAN KASIR: ${e.message}");
      emit(state.copyWith(listTotalLaporanKasir: []));
    } catch (e) {
      debugPrint("EXCEPTION GET TOTAL LAPORAN KASIR: $e");
      emit(state.copyWith(listTotalLaporanKasir: []));
    }
  }
}

KasirProvider getKasirProvider(BuildContext context) =>
    context.read<KasirProvider>();
