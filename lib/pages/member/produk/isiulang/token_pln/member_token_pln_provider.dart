import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_pin_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class MemberTokenPlnState extends Equatable {
  // Product API
  final ApiStatus apiFetchProductStatus;
  final String apiFetchProductMessage;
  final List<ProductModel> products;
  final ProductModel selectedProduct;
  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  // Single Tujuan
  final String tujuan;
  final FocusNode? tujuanFocusNode;
  final TextEditingController? tujuanController;
  final bool tujuanHasError;
  final String tujuanErrorMessage;

  // Cek Akun API
  final ApiStatus apiCekAkunStatus;
  final String apiCekAkunMessage;
  final KeyValueResponse cekAkunResult;
  final String kodeProdukCek;

  // Konfirmasi State
  final int totalPotongStok;
  final KeyValueResponse detailTransaksi;
  final KeyValueResponse detailPotongStok;
  final ApiStatus apiKonfirmasiStatus;
  final String apiKonfirmasiMessage;

  // Tambah untuk cek trx sebelumnya
  final bool adaTrxSebelumnya;
  final KeyValueResponse detailTrxSebelumnya;
  final int trxke;

  const MemberTokenPlnState({
    // Product
    this.apiFetchProductStatus = ApiStatus.initial,
    this.apiFetchProductMessage = '',
    this.products = const [],
    this.selectedProduct = DEFAULT_PRODUCT,
    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,
    // Single
    this.tujuan = '',
    this.tujuanFocusNode,
    this.tujuanController,
    this.tujuanHasError = false,
    this.tujuanErrorMessage = '',
    // Cek Akun
    this.apiCekAkunStatus = ApiStatus.initial,
    this.apiCekAkunMessage = '',
    this.cekAkunResult = DEFAULT_KEY_VALUE_RESPONSE,
    this.kodeProdukCek = '',
    // Konfirmasi
    this.totalPotongStok = 0,
    this.detailTransaksi = DEFAULT_KEY_VALUE_RESPONSE,
    this.detailPotongStok = DEFAULT_KEY_VALUE_RESPONSE,
    this.apiKonfirmasiStatus = ApiStatus.initial,
    this.apiKonfirmasiMessage = '',
    // Trx Sebelumnya
    this.adaTrxSebelumnya = false,
    this.detailTrxSebelumnya = DEFAULT_KEY_VALUE_RESPONSE,
    this.trxke = 0,
  });

  MemberTokenPlnState copyWith({
    ApiStatus? apiFetchProductStatus,
    String? apiFetchProductMessage,
    List<ProductModel>? products,
    ProductModel? selectedProduct,
    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,
    String? tujuan,
    FocusNode? tujuanFocusNode,
    TextEditingController? tujuanController,
    bool? tujuanHasError,
    String? tujuanErrorMessage,
    ApiStatus? apiCekAkunStatus,
    String? apiCekAkunMessage,
    KeyValueResponse? cekAkunResult,
    String? kodeProdukCek,
    int? totalPotongStok,
    KeyValueResponse? detailTransaksi,
    KeyValueResponse? detailPotongStok,
    ApiStatus? apiKonfirmasiStatus,
    String? apiKonfirmasiMessage,
    bool? adaTrxSebelumnya,
    KeyValueResponse? detailTrxSebelumnya,
    int? trxke,
  }) {
    return MemberTokenPlnState(
      apiFetchProductStatus:
          apiFetchProductStatus ?? this.apiFetchProductStatus,
      apiFetchProductMessage:
          apiFetchProductMessage ?? this.apiFetchProductMessage,
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      sortProduct: sortProduct ?? this.sortProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
          searchProductController ?? this.searchProductController,
      tujuan: tujuan ?? this.tujuan,
      tujuanFocusNode: tujuanFocusNode ?? this.tujuanFocusNode,
      tujuanController: tujuanController ?? this.tujuanController,
      tujuanHasError: tujuanHasError ?? this.tujuanHasError,
      tujuanErrorMessage: tujuanErrorMessage ?? this.tujuanErrorMessage,
      apiCekAkunStatus: apiCekAkunStatus ?? this.apiCekAkunStatus,
      apiCekAkunMessage: apiCekAkunMessage ?? this.apiCekAkunMessage,
      cekAkunResult: cekAkunResult ?? this.cekAkunResult,
      kodeProdukCek: kodeProdukCek ?? this.kodeProdukCek,
      totalPotongStok: totalPotongStok ?? this.totalPotongStok,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi,
      detailPotongStok: detailPotongStok ?? this.detailPotongStok,
      apiKonfirmasiStatus: apiKonfirmasiStatus ?? this.apiKonfirmasiStatus,
      apiKonfirmasiMessage: apiKonfirmasiMessage ?? this.apiKonfirmasiMessage,
      adaTrxSebelumnya: adaTrxSebelumnya ?? this.adaTrxSebelumnya,
      detailTrxSebelumnya: detailTrxSebelumnya ?? this.detailTrxSebelumnya,
      trxke: trxke ?? this.trxke,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchProductStatus,
    apiFetchProductMessage,
    products,
    selectedProduct,
    sortProduct,
    searchProduct,
    searchProductController,
    tujuan,
    tujuanFocusNode,
    tujuanController,
    tujuanHasError,
    tujuanErrorMessage,
    apiCekAkunStatus,
    apiCekAkunMessage,
    cekAkunResult,
    kodeProdukCek,
    totalPotongStok,
    detailTransaksi,
    detailPotongStok,
    apiKonfirmasiStatus,
    apiKonfirmasiMessage,
    adaTrxSebelumnya,
    detailTrxSebelumnya,
    trxke,
  ];
}

// ============================================================
// CUBIT
// ============================================================
class MemberTokenPlnProvider extends Cubit<MemberTokenPlnState> {
  final ProdukService _produkService = ProdukService();

  MemberTokenPlnProvider()
    : super(
        MemberTokenPlnState(
          tujuanFocusNode: FocusNode(),
          tujuanController: TextEditingController(),
          searchProductController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.tujuanFocusNode?.dispose();
    state.tujuanController?.dispose();
    state.searchProductController?.dispose();
    return super.close();
  }

  // ============================================================
  // KONFIRMASI METHODS
  // ============================================================

  void konfirmasiTrx(BuildContext context) async {
    // Reset state sebelum show dialog
    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.initial,
        apiKonfirmasiMessage: '',
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );

    KonfirmasiPinDialog.show<MemberTokenPlnProvider, MemberTokenPlnState>(
      context,
      // Title & Subtitle default
      title:
          'Konfirmasi Transaksi Token PLN ${state.selectedProduct.namaproduk}',
      subtitle: 'Masukkan PIN untuk melanjutkan transaksi',
      // Title & Subtitle jika ada trx sebelumnya
      titleTrxSebelumnya: 'Konfirmasi Ulang Transaksi',
      subtitleTrxSebelumnya:
          'Transaksi serupa terdeteksi, harap konfirmasi ulang',
      bloc: this,
      isLoadingSelector: (state) => state.apiKonfirmasiStatus.isLoading,
      errorMessageSelector: (state) => state.apiKonfirmasiMessage,
      trxSebelumnyaSelector: (state) => TrxSebelumnyaState(
        adaTrxSebelumnya: state.adaTrxSebelumnya,
        detailTrxSebelumnya: state.detailTrxSebelumnya,
      ),
      onConfirm: (pin) => _prosesKonfirmasi(context, pin),
    );
  }

  Future<void> _prosesKonfirmasi(BuildContext context, String pin) async {
    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    if (state.apiKonfirmasiStatus.isLoading) return;

    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.loading,
        apiKonfirmasiMessage: '',
      ),
    );

    try {
      var tujuan = state.selectedProduct.inputTipe.filter(state.tujuan.trim());
      var pintrx = TipeInput.numericOnly.filter(pin);

      final result = await _produkService.bayarTokenPLNMember(
        kodeproduk: state.selectedProduct.kodeproduk,
        tujuan: tujuan,
        pintrx: pintrx,
        // Kirim trxke+1 jika ada trx sebelumnya (untuk konfirmasi ulang)
        trxke: state.trxke > 0 ? state.trxke + 1 : 1,
      );

      final data = result.data;
      if (!result.status) {
        emit(
          state.copyWith(
            apiKonfirmasiStatus: ApiStatus.failure,
            apiKonfirmasiMessage: result.message,
          ),
        );

        if (data != null) {
          if (data.trxke > 0 && state.trxke == 0) {
            _setTrxSebelumnyaFromResponse(data);
            emit(
              state.copyWith(
                apiKonfirmasiStatus: ApiStatus.initial,
                apiKonfirmasiMessage: '',
              ),
            );
            return;
          }
        }

        return;
      } else {
        emit(state.copyWith(apiKonfirmasiStatus: ApiStatus.success));

        if (context.mounted) {
          getTransaksiProsesProvider(
            context,
          ).setImage(NetworkImage(state.selectedProduct.imgproduk));
          getTransaksiProsesProvider(context).setProduct(state.selectedProduct);
          getTransaksiProsesProvider(
            context,
          ).setPotongStok(state.totalPotongStok);
          getTransaksiProsesProvider(context).setTujuan(state.tujuan.trim());
          getTransaksiProsesProvider(
            context,
          ).setWaktuTransaksi(DateTime.now().formatReg());
          resetState();

          pushNamedAndRemoveUntil(TransaksiProsesAltPage.routeName);
        }
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION KONFIRMASI: ${e.message}");
      emit(
        state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION KONFIRMASI: $e");
      emit(
        state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: 'Terjadi kesalahan, silakan coba lagi',
        ),
      );
    }
  }

  // ============================================================
  // API CALLS
  // ============================================================
  Future<void> fetchProducts() async {
    if (state.apiFetchProductStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.loading,
        apiFetchProductMessage: '',
      ),
    );

    try {
      final result = await _produkService.getTokenPlnMemberProducts();
      if (!result.status) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.success,
            products: data.productList,
            kodeProdukCek: data.productList
                .firstWhere(
                  (p) => p.kodeprodukcek.isNotEmpty,
                  orElse: () => DEFAULT_PRODUCT,
                )
                .kodeprodukcek,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk token pln kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PRODUCTS: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchProductStatus: ApiStatus.failure,
          apiFetchProductMessage: e.message,
        ),
      );
    }
  }

  Future<void> cekAkun() async {
    var valid = validateTujuan();
    if (!valid) return;

    if (state.apiCekAkunStatus.isLoading) return;

    emit(
      state.copyWith(
        apiCekAkunStatus: ApiStatus.loading,
        apiCekAkunMessage: '',
      ),
    );

    try {
      final result = await _produkService.cekAkunGame(
        kodeproduk: state.kodeProdukCek,
        tujuan: state.tujuan,
      );
      if (!result.status) {
        emit(
          state.copyWith(
            apiCekAkunStatus: ApiStatus.failure,
            apiCekAkunMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
      final data = result.data;

      if (data != null) {
        var dataTrx = result.dataSplit;

        if (dataTrx != null) {
          var dataTransaksi = dataTrx.dataTransaksi ?? [];

          var res = KeyValueResponse(items: dataTransaksi);

          emit(
            state.copyWith(
              apiCekAkunStatus: ApiStatus.success,
              cekAkunResult: res,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiCekAkunStatus: ApiStatus.failure,
            apiCekAkunMessage: 'Data cek akun kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION CEK AKUN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiCekAkunStatus: ApiStatus.failure,
          apiCekAkunMessage: e.message,
        ),
      );
    }
  }

  // ============================================================
  // SETTERS
  // ============================================================
  void setSelectedProduct(ProductModel product) {
    emit(state.copyWith(selectedProduct: product));
  }

  void setSortProduct(SortProductBy sortBy) {
    emit(state.copyWith(sortProduct: sortBy));
  }

  void setSearchProduct(String search, {bool updateController = false}) {
    emit(state.copyWith(searchProduct: search));
    if (updateController)
      _updateController(state.searchProductController, search);
  }

  void setTujuan(String value, {bool updateController = false}) {
    emit(state.copyWith(tujuan: value));
    if (updateController) _updateController(state.tujuanController, value);
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  void setNewKonfirmasi() async {
    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    if (state.cekAkunResult.items.isEmpty) {
      await cekAkun();
    }

    if (!checkTujuanMatchResult(state.cekAkunResult, state.tujuan.trim())) {
      await cekAkun();
    }

    var valid = validateTujuan();
    if (!valid) return;

    var dtlTransaksi = KeyValueResponse(items: []);

    dtlTransaksi.addItem(
      KeyValue(key: "Waktu", value: DateTime.now().formatReg()),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Nama Produk", value: state.selectedProduct.namaproduk),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Kode Produk", value: state.selectedProduct.kodeproduk),
    );

    if (state.cekAkunResult.items.isNotEmpty) {
      for (var item in state.cekAkunResult.items) {
        dtlTransaksi.addItem(KeyValue(key: item.key, value: item.value));
      }
    } else {
      dtlTransaksi.addItem(
        KeyValue(key: "ID Pelanggan", value: state.tujuan.trim()),
      );
    }

    var dtlPotongStok = KeyValueResponse(items: []);
    dtlPotongStok.addItem(
      KeyValue(key: "Harga", value: state.selectedProduct.hargaFormmated),
    );
    dtlPotongStok.addItem(KeyValue(key: "Biaya Admin", value: "0"));

    emit(
      state.copyWith(
        totalPotongStok: state.selectedProduct.hargaproduk,
        detailTransaksi: dtlTransaksi,
        detailPotongStok: dtlPotongStok,
      ),
    );

    pushNamed(MemberTokenPlnKonfirmasiTransaksiPage.routeName, arguments: this);
  }

  void _setTrxSebelumnyaFromResponse(BayarResponse data) {
    var detail = KeyValueResponse(items: []);

    detail.addItem(KeyValue(key: 'Nama Produk', value: data.namaproduk));
    detail.addItem(KeyValue(key: 'Kode Produk', value: data.kodeproduk));
    detail.addItem(KeyValue(key: 'Tujuan', value: data.tujuan));
    detail.addItem(
      KeyValue(key: 'SN', value: data.sn.isNotEmpty ? data.sn : '-'),
    );
    detail.addItem(KeyValue(key: 'Transaksi Ke', value: data.trxke.toString()));
    detail.addItem(KeyValue(key: 'Status', value: data.status));
    detail.addItem(KeyValue(key: 'Waktu', value: data.waktutrx));

    emit(
      state.copyWith(
        adaTrxSebelumnya: true,
        detailTrxSebelumnya: detail,
        trxke: data.trxke,
      ),
    );
  }

  // ============================================================
  // RESET METHODS
  // ============================================================
  void resetState() {
    emit(
      MemberTokenPlnState(
        tujuanFocusNode: FocusNode(),
        tujuanController: TextEditingController(),
        searchProductController: TextEditingController(),
      ),
    );
  }

  void resetKonfirmasi() {
    emit(
      state.copyWith(
        totalPotongStok: 0,
        detailTransaksi: DEFAULT_KEY_VALUE_RESPONSE,
        detailPotongStok: DEFAULT_KEY_VALUE_RESPONSE,
        apiKonfirmasiStatus: ApiStatus.initial,
        apiKonfirmasiMessage: '',
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );
  }

  void resetTrxSebelumnya() {
    emit(
      state.copyWith(
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );
  }

  // ============================================================
  // VALIDATION
  // ============================================================
  bool validateTujuan() {
    final error = _validateTujuanValue(state.tujuan.trim());

    emit(
      state.copyWith(
        tujuanHasError: error != null,
        tujuanErrorMessage: error ?? '',
      ),
    );

    return error == null;
  }

  // ============================================================
  // PRIVATE VALIDATION HELPER
  // ============================================================
  String? _validateTujuanValue(String tujuan) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
    }

    // Validasi tipe input
    if (!TipeInput.numericOnly.isValid(tujuan)) {
      return TipeInput.numericOnly.errorMessage;
    }

    if (state.products.isNotEmpty) {
      var firstProduct = state.products.first;

      var minLength = firstProduct.mintujuan;
      var maxLength = firstProduct.maxtujuan;
      if (tujuan.length < minLength || tujuan.length > maxLength) {
        return 'Panjang tujuan harus antara $minLength hingga $maxLength karakter';
      }

      // Tipe input
      if (!firstProduct.inputTipe.isValid(tujuan)) {
        return firstProduct.inputTipe.errorMessage;
      }
    }

    return null;
  }
}

MemberTokenPlnProvider getMemberTokenPlnProvider(BuildContext context) =>
    context.read<MemberTokenPlnProvider>();
