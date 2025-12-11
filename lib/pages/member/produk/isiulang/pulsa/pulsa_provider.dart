import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_konfirmasi_transaksi_page.dart';
import 'package:dmpku/service/member/product_service.dart';

// ============================================================
// STATE
// ============================================================
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_pin_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberPulsaState extends Equatable {
  // Provider API
  final ApiStatus apiFetchProviderStatus;
  final String apiFetchProviderMessage;
  final List<ProviderModel> providers;
  final ProviderModel selectedProvider;

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

  const MemberPulsaState({
    // Provider API
    this.apiFetchProviderStatus = ApiStatus.initial,
    this.apiFetchProviderMessage = '',
    this.providers = const [],
    this.selectedProvider = DEFAULT_PROVIDER,

    // Product API
    this.apiFetchProductStatus = ApiStatus.initial,
    this.apiFetchProductMessage = '',
    this.products = const [],
    this.selectedProduct = DEFAULT_PRODUCT,
    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    // Single Tujuan
    this.tujuan = '',
    this.tujuanFocusNode,
    this.tujuanController,
    this.tujuanHasError = false,
    this.tujuanErrorMessage = '',

    // Konfirmasi State
    this.totalPotongStok = 0,
    this.detailTransaksi = DEFAULT_KEY_VALUE_RESPONSE,
    this.detailPotongStok = DEFAULT_KEY_VALUE_RESPONSE,
    this.apiKonfirmasiStatus = ApiStatus.initial,
    this.apiKonfirmasiMessage = '',

    // Tambah untuk cek trx sebelumnya
    this.adaTrxSebelumnya = false,
    this.detailTrxSebelumnya = DEFAULT_KEY_VALUE_RESPONSE,
    this.trxke = 0,
  });

  MemberPulsaState copyWith({
    // Provider API
    ApiStatus? apiFetchProviderStatus,
    String? apiFetchProviderMessage,
    List<ProviderModel>? providers,
    ProviderModel? selectedProvider,

    // Product API
    ApiStatus? apiFetchProductStatus,
    String? apiFetchProductMessage,
    List<ProductModel>? products,
    ProductModel? selectedProduct,
    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    // Single Tujuan
    String? tujuan,
    FocusNode? tujuanFocusNode,
    TextEditingController? tujuanController,
    bool? tujuanHasError,
    String? tujuanErrorMessage,

    // Konfirmasi State
    int? totalPotongStok,
    KeyValueResponse? detailTransaksi,
    KeyValueResponse? detailPotongStok,
    ApiStatus? apiKonfirmasiStatus,
    String? apiKonfirmasiMessage,

    // Tambah untuk cek trx sebelumnya
    bool? adaTrxSebelumnya,
    KeyValueResponse? detailTrxSebelumnya,
    int? trxke,
  }) {
    return MemberPulsaState(
      // Provider API
      apiFetchProviderStatus:
          apiFetchProviderStatus ?? this.apiFetchProviderStatus,
      apiFetchProviderMessage:
          apiFetchProviderMessage ?? this.apiFetchProviderMessage,
      providers: providers ?? this.providers,
      selectedProvider: selectedProvider ?? this.selectedProvider,

      // Product API
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

      // Single Tujuan
      tujuan: tujuan ?? this.tujuan,
      tujuanFocusNode: tujuanFocusNode ?? this.tujuanFocusNode,
      tujuanController: tujuanController ?? this.tujuanController,
      tujuanHasError: tujuanHasError ?? this.tujuanHasError,
      tujuanErrorMessage: tujuanErrorMessage ?? this.tujuanErrorMessage,

      // Konfirmasi State
      totalPotongStok: totalPotongStok ?? this.totalPotongStok,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi,
      detailPotongStok: detailPotongStok ?? this.detailPotongStok,
      apiKonfirmasiStatus: apiKonfirmasiStatus ?? this.apiKonfirmasiStatus,
      apiKonfirmasiMessage: apiKonfirmasiMessage ?? this.apiKonfirmasiMessage,

      // Tambah untuk cek trx sebelumnya
      adaTrxSebelumnya: adaTrxSebelumnya ?? this.adaTrxSebelumnya,
      detailTrxSebelumnya: detailTrxSebelumnya ?? this.detailTrxSebelumnya,
      trxke: trxke ?? this.trxke,
    );
  }

  @override
  List<Object?> get props => [
    // Provider API
    apiFetchProviderStatus,
    apiFetchProviderMessage,
    providers,
    selectedProvider,
    // Product API
    apiFetchProductStatus,
    apiFetchProductMessage,
    products,
    selectedProduct,
    sortProduct,
    searchProduct,
    searchProductController,
    // Single Tujuan
    tujuan,
    tujuanFocusNode,
    tujuanController,
    tujuanHasError,
    tujuanErrorMessage,
    // Konfirmasi State
    totalPotongStok,
    detailTransaksi,
    detailPotongStok,
    apiKonfirmasiStatus,
    apiKonfirmasiMessage,
    // Tambah untuk cek trx sebelumnya
    adaTrxSebelumnya,
    detailTrxSebelumnya,
    trxke,
  ];
}

// ============================================================
// CUBIT
// ============================================================
class MemberPulsaProvider extends Cubit<MemberPulsaState> {
  final ProdukService _produkService = ProdukService();

  MemberPulsaProvider()
    : super(
        MemberPulsaState(
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
    emit(state.copyWith(
      apiKonfirmasiStatus: ApiStatus.initial,
      apiKonfirmasiMessage: '',
      adaTrxSebelumnya: false,
      detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
      trxke: 0,
    ));

    KonfirmasiPinDialog.show<MemberPulsaProvider, MemberPulsaState>(
      context,
      // Title & Subtitle default
      title: 'Konfirmasi Transaksi Pulsa ${state.selectedProduct.namaproduk}',
      subtitle: 'Masukkan PIN untuk melanjutkan transaksi pulsa',
      // Title & Subtitle jika ada trx sebelumnya
      titleTrxSebelumnya: 'Konfirmasi Ulang Transaksi',
      subtitleTrxSebelumnya: 'Transaksi serupa terdeteksi, harap konfirmasi ulang',
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
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    if (state.apiKonfirmasiStatus.isLoading) return;

    emit(state.copyWith(
      apiKonfirmasiStatus: ApiStatus.loading,
      apiKonfirmasiMessage: '',
    ));

    try {
      var tujuan = state.selectedProvider.inputTipe.filter(state.tujuan.trim());
      var pintrx = TipeInput.numericOnly.filter(pin);

      final result = await _produkService.bayarPulsaMember(
        kodeproduk: state.selectedProduct.kodeproduk,
        tujuan: tujuan,
        pintrx: pintrx,
        // Kirim trxke+1 jika ada trx sebelumnya (untuk konfirmasi ulang)
        trxke: state.trxke > 0 ? state.trxke + 1 : 1,
      );

      final data = result.data;

      debugPrint("DEBUG KONFIRMASI RESPONSE: $data");

      if (data != null) {
        // Cek apakah ada transaksi sebelumnya (trxket > 0 dan belum dikonfirmasi ulang)
        // trxket > 0 menandakan sudah ada trx dengan data yang sama
        debugPrint("DEBUG KONFIRMASI TRXKE: ${data.trxke} vs STATE TRXKE: ${state.trxke}");
        if (data.trxke > 0 && state.trxke == 0) {
          // Set data trx sebelumnya, dialog akan otomatis update
          _setTrxSebelumnyaFromResponse(data);

          // Set status kembali ke initial agar user bisa input PIN lagi
          emit(state.copyWith(
            apiKonfirmasiStatus: ApiStatus.initial,
            apiKonfirmasiMessage: '',
          ));
          return;
        }

        // Transaksi berhasil diproses
        emit(state.copyWith(apiKonfirmasiStatus: ApiStatus.success));

        if (context.mounted) {
          Navigator.of(context).pop(); // Tutup dialog
          showSuccessMessage('Transaksi pulsa berhasil diproses!');

          // TODO: Navigate ke halaman sukses atau handle sesuai kebutuhan
          // pushReplacementNamed(TransaksiSuksesPage.routeName);
        }
      } else {
        emit(state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: 'Terjadi kesalahan, data kosong',
        ));
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION KONFIRMASI: ${e.message}");
      emit(state.copyWith(
        apiKonfirmasiStatus: ApiStatus.failure,
        apiKonfirmasiMessage: e.message,
      ));
    } catch (e) {
      debugPrint("EXCEPTION KONFIRMASI: $e");
      emit(state.copyWith(
        apiKonfirmasiStatus: ApiStatus.failure,
        apiKonfirmasiMessage: 'Terjadi kesalahan, silakan coba lagi',
      ));
    }
  }

  // ============================================================
  // API CALLS
  // ============================================================
  Future<void> fetchProviders() async {
    if (state.apiFetchProviderStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProviderStatus: ApiStatus.loading,
        apiFetchProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getPulsaMemberProviders();
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.success,
            providers: data.providerList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.failure,
            apiFetchProviderMessage: 'Data provider pulsa kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PROVIDERS: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchProviderStatus: ApiStatus.failure,
          apiFetchProviderMessage: e.message,
        ),
      );
    }
  }

  Future<void> fetchProducts() async {
    if (state.selectedProvider.idprovider == 0) return;
    if (state.apiFetchProductStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.loading,
        apiFetchProductMessage: '',
        products: [],
      ),
    );

    try {
      final result = await _produkService.getPulsaMemberProducts(
        idProvider: state.selectedProvider.idprovider,
      );
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.success,
            products: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk pulsa kosong',
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

  // ============================================================
  // SETTERS
  // ============================================================
  void setSelectedProvider(ProviderModel provider) {
    emit(state.copyWith(selectedProvider: provider));
    fetchProducts();
  }

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
    var val = value.trim();

    if (state.selectedProvider.idprovider != 0) {
      val = state.selectedProvider.inputTipe.filter(val);
    } else {
      val = TipeInput.numericOnly.filter(val);
    }

    emit(state.copyWith(tujuan: val));
    if (updateController) _updateController(state.tujuanController, val);

    validateTujuan(provider: state.selectedProvider);
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  void setNewKonfirmasi() async {
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    var valid = validateTujuan(provider: state.selectedProvider);
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
    dtlTransaksi.addItem(
      KeyValue(key: "No. Tujuan", value: state.tujuan.trim()),
    );

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

    pushNamed(MemberPulsaKonfirmasiTransaksiPage.routeName);
  }

  void _setTrxSebelumnyaFromResponse(BayarResponse data) {
    var detail = KeyValueResponse(items: []);

    detail.addItem(KeyValue(key: 'Nama Produk', value: data.namaproduk));
    detail.addItem(KeyValue(key: 'Kode Produk', value: data.kodeproduk));
    detail.addItem(KeyValue(key: 'Tujuan', value: data.tujuan));
    detail.addItem(KeyValue(key: 'SN', value: data.sn.isNotEmpty ? data.sn : '-'));
    detail.addItem(KeyValue(key: 'Transaksi Ke', value: data.trxke.toString()));
    detail.addItem(KeyValue(key: 'Status', value: data.status));
    detail.addItem(KeyValue(key: 'Waktu', value: data.waktutrx));

    emit(state.copyWith(
      adaTrxSebelumnya: true,
      detailTrxSebelumnya: detail,
      trxke: data.trxke,
    ));
  }

  // ============================================================
  // RESET METHODS
  // ============================================================
  void resetState() {
    emit(
      MemberPulsaState(
        tujuanFocusNode: FocusNode(),
        tujuanController: TextEditingController(),
        searchProductController: TextEditingController(),
      ),
    );
  }

  void resetProduct() {
    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.initial,
        apiFetchProductMessage: '',
        products: [],
        selectedProvider: DEFAULT_PROVIDER,
        selectedProduct: DEFAULT_PRODUCT,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
      ),
    );
  }

  void resetKonfirmasi() {
    emit(state.copyWith(
      totalPotongStok: 0,
      detailTransaksi: DEFAULT_KEY_VALUE_RESPONSE,
      detailPotongStok: DEFAULT_KEY_VALUE_RESPONSE,
      apiKonfirmasiStatus: ApiStatus.initial,
      apiKonfirmasiMessage: '',
      adaTrxSebelumnya: false,
      detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
      trxke: 0,
    ));
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
  bool validateTujuan({ProviderModel? provider}) {
    final selectedProvider = provider ?? state.selectedProvider;
    final error = _validateTujuanValue(state.tujuan.trim(), selectedProvider);

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
  String? _validateTujuanValue(String tujuan, ProviderModel provider) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
    }

    if (!tujuan.startsWith('08')) {
      return 'Tujuan harus diawali dengan 08';
    }

    if (provider.idprovider == 0) return null;

    // Validasi panjang
    if (tujuan.length < provider.mintujuan ||
        tujuan.length > provider.maxtujuan) {
      return 'Panjang tujuan harus antara ${provider.mintujuan} hingga ${provider.maxtujuan} karakter';
    }

    // Validasi prefix
    final isValidPrefix = provider.prefixList.any((prefix) {
      final maxRange = tujuan.length < prefix.length
          ? tujuan.length
          : prefix.length;
      return prefix.startsWith(tujuan.substring(0, maxRange));
    });

    if (!isValidPrefix) {
      return 'Tujuan tidak sesuai dengan prefix provider ${provider.namaprovider}';
    }

    // Validasi tipe input
    if (!provider.inputTipe.isValid(tujuan)) {
      return provider.inputTipe.errorMessage;
    }

    return null;
  }
}

MemberPulsaProvider getMemberPulsaProvider(BuildContext context) =>
    context.read<MemberPulsaProvider>();
