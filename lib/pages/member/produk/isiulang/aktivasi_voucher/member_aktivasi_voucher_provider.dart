import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_aktivasi_voucher.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_pin_dialog.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class MemberAktivasiVoucherState extends Equatable {
  // Provider API
  final ApiStatus apiFetchProviderStatus;
  final String apiFetchProviderMessage;
  final List<ProviderModel> providers;
  final ProviderModel selectedProvider;
  final String searchProvider;
  final TextEditingController? searchProviderController;

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

  // Tujuan Berurutan
  final String tujuanAwal;
  final FocusNode? tujuanAwalFocusNode;
  final TextEditingController? tujuanAwalController;
  final bool tujuanAwalHasError;
  final String tujuanAwalErrorMessage;

  final String tujuanAkhir;
  final FocusNode? tujuanAkhirFocusNode;
  final TextEditingController? tujuanAkhirController;
  final bool tujuanAkhirHasError;
  final String tujuanAkhirErrorMessage;

  // Multi Tujuan
  final List<String> listTujuan;
  final List<TextEditingController> listTujuanController;
  final List<FocusNode> listTujuanFocusNode;
  final List<bool> listTujuanHasError;
  final List<String> listTujuanErrorMessage;
  final List<GlobalKey<ShakeErrorWidgetState>> listTujuanShakeKey;

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

  const MemberAktivasiVoucherState({
    // Provider
    this.apiFetchProviderStatus = ApiStatus.initial,
    this.apiFetchProviderMessage = '',
    this.providers = const [],
    this.selectedProvider = DEFAULT_PROVIDER,
    this.searchProvider = '',
    this.searchProviderController,
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
    // Berurutan
    this.tujuanAwal = '',
    this.tujuanAwalFocusNode,
    this.tujuanAwalController,
    this.tujuanAwalHasError = false,
    this.tujuanAwalErrorMessage = '',
    this.tujuanAkhir = '',
    this.tujuanAkhirFocusNode,
    this.tujuanAkhirController,
    this.tujuanAkhirHasError = false,
    this.tujuanAkhirErrorMessage = '',
    // Multi
    this.listTujuan = const [],
    this.listTujuanController = const [],
    this.listTujuanFocusNode = const [],
    this.listTujuanHasError = const [],
    this.listTujuanErrorMessage = const [],
    this.listTujuanShakeKey = const [],

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

  MemberAktivasiVoucherState copyWith({
    ApiStatus? apiFetchProviderStatus,
    String? apiFetchProviderMessage,
    List<ProviderModel>? providers,
    ProviderModel? selectedProvider,
    String? searchProvider,
    TextEditingController? searchProviderController,
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
    String? tujuanAwal,
    FocusNode? tujuanAwalFocusNode,
    TextEditingController? tujuanAwalController,
    bool? tujuanAwalHasError,
    String? tujuanAwalErrorMessage,
    String? tujuanAkhir,
    FocusNode? tujuanAkhirFocusNode,
    TextEditingController? tujuanAkhirController,
    bool? tujuanAkhirHasError,
    String? tujuanAkhirErrorMessage,
    List<String>? listTujuan,
    List<TextEditingController>? listTujuanController,
    List<FocusNode>? listTujuanFocusNode,
    List<bool>? listTujuanHasError,
    List<String>? listTujuanErrorMessage,
    List<GlobalKey<ShakeErrorWidgetState>>? listTujuanShakeKey,

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
    return MemberAktivasiVoucherState(
      apiFetchProviderStatus:
          apiFetchProviderStatus ?? this.apiFetchProviderStatus,
      apiFetchProviderMessage:
          apiFetchProviderMessage ?? this.apiFetchProviderMessage,
      providers: providers ?? this.providers,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      searchProvider: searchProvider ?? this.searchProvider,
      searchProviderController:
          searchProviderController ?? this.searchProviderController,
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
      tujuanAwal: tujuanAwal ?? this.tujuanAwal,
      tujuanAwalFocusNode: tujuanAwalFocusNode ?? this.tujuanAwalFocusNode,
      tujuanAwalController: tujuanAwalController ?? this.tujuanAwalController,
      tujuanAwalHasError: tujuanAwalHasError ?? this.tujuanAwalHasError,
      tujuanAwalErrorMessage:
          tujuanAwalErrorMessage ?? this.tujuanAwalErrorMessage,
      tujuanAkhir: tujuanAkhir ?? this.tujuanAkhir,
      tujuanAkhirFocusNode: tujuanAkhirFocusNode ?? this.tujuanAkhirFocusNode,
      tujuanAkhirController:
          tujuanAkhirController ?? this.tujuanAkhirController,
      tujuanAkhirHasError: tujuanAkhirHasError ?? this.tujuanAkhirHasError,
      tujuanAkhirErrorMessage:
          tujuanAkhirErrorMessage ?? this.tujuanAkhirErrorMessage,
      listTujuan: listTujuan ?? this.listTujuan,
      listTujuanController: listTujuanController ?? this.listTujuanController,
      listTujuanFocusNode: listTujuanFocusNode ?? this.listTujuanFocusNode,
      listTujuanHasError: listTujuanHasError ?? this.listTujuanHasError,
      listTujuanErrorMessage:
          listTujuanErrorMessage ?? this.listTujuanErrorMessage,
      listTujuanShakeKey: listTujuanShakeKey ?? this.listTujuanShakeKey,

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
    apiFetchProviderStatus,
    apiFetchProviderMessage,
    providers,
    selectedProvider,
    searchProvider,
    searchProviderController,
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
    tujuanAwal,
    tujuanAwalFocusNode,
    tujuanAwalController,
    tujuanAwalHasError,
    tujuanAwalErrorMessage,
    tujuanAkhir,
    tujuanAkhirFocusNode,
    tujuanAkhirController,
    tujuanAkhirHasError,
    tujuanAkhirErrorMessage,
    listTujuan,
    listTujuanController,
    listTujuanFocusNode,
    listTujuanHasError,
    listTujuanErrorMessage,
    listTujuanShakeKey,
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
class MemberAktivasiVoucherProvider extends Cubit<MemberAktivasiVoucherState> {
  final ProdukService _produkService = ProdukService();

  MemberAktivasiVoucherProvider()
    : super(
        MemberAktivasiVoucherState(
          tujuanFocusNode: FocusNode(),
          tujuanController: TextEditingController(),
          tujuanAwalFocusNode: FocusNode(),
          tujuanAwalController: TextEditingController(),
          tujuanAkhirFocusNode: FocusNode(),
          tujuanAkhirController: TextEditingController(),
          searchProductController: TextEditingController(),
          searchProviderController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.tujuanFocusNode?.dispose();
    state.tujuanController?.dispose();
    state.tujuanAwalFocusNode?.dispose();
    state.tujuanAwalController?.dispose();
    state.tujuanAkhirFocusNode?.dispose();
    state.tujuanAkhirController?.dispose();
    state.searchProductController?.dispose();
    state.searchProviderController?.dispose();
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

    KonfirmasiPinDialog.show<
      MemberAktivasiVoucherProvider,
      MemberAktivasiVoucherState
    >(
      context,
      // Title & Subtitle default
      title:
          'Konfirmasi Transaksi Masa Aktif ${state.selectedProduct.namaproduk}',
      subtitle: 'Masukkan PIN untuk melanjutkan transaksi masa aktif',
      // Title & Subtitle jika ada trx sebelumnya
      titleTrxSebelumnya: 'Konfirmasi Ulang Transaksi',
      subtitleTrxSebelumnya:
          'Transaksi serupa terdeteksi, harap konfirmasi ulang',
      bloc: this,
      isLoadingSelector: (state) => state.apiKonfirmasiStatus.isLoading,
      errorMessageSelector: (state) => state.apiKonfirmasiMessage,
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

    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.loading,
        apiKonfirmasiMessage: '',
      ),
    );

    try {
      List<ProsesTrxBanyak> prosesTrxBanyak = [];
      var pintrx = TipeInput.numericOnly.filter(pin);
      var tujuan = state.listTujuan;
      for (var i = 0; i < tujuan.length; i++) {
        var tuj = state.selectedProvider.inputTipe.filter(tujuan[i].trim());
        tuj = state.selectedProvider.inputTipe.filter(tuj);

        final result = await _produkService.bayarAktivasiVoucherMember(
          kodeproduk: state.selectedProduct.kodeproduk,
          tujuan: tuj,
          pintrx: pintrx,
          // Kirim trxke+1 jika ada trx sebelumnya (untuk konfirmasi ulang)
          trxke: 1,
        );

        final data = result.data;
        if (data == null) {
          prosesTrxBanyak.add(ProsesTrxBanyak(tujuan: tuj, success: false));
          continue;
        }

        if (!result.status) {
          prosesTrxBanyak.add(ProsesTrxBanyak(tujuan: tuj, success: false));
        } else {
          prosesTrxBanyak.add(ProsesTrxBanyak(tujuan: tuj, success: true));
        }
      }

      // cek apakah semua transaksi gagal
      bool allFailed = prosesTrxBanyak.every(
        (element) => element.success == false,
      );
      if (allFailed) {
        emit(
          state.copyWith(
            apiKonfirmasiStatus: ApiStatus.failure,
            apiKonfirmasiMessage:
                'Transaksi gagal untuk semua tujuan, silakan coba lagi',
          ),
        );
        pop();
        showErrorMessage(
          'Transaksi gagal untuk semua tujuan, silakan coba lagi',
        );

        return;
      } else {
        getTransaksiProsesProvider(
          context,
        ).setImage(NetworkImage(state.selectedProduct.imgproduk));
        getTransaksiProsesProvider(context).setProduct(state.selectedProduct);
        getTransaksiProsesProvider(
          context,
        ).setPotongStok(state.totalPotongStok);
        getTransaksiProsesProvider(context).setTujuanHistory(prosesTrxBanyak);
        getTransaksiProsesProvider(
          context,
        ).setWaktuTransaksi(DateTime.now().formatReg());

        pushNamedAndRemoveUntil(TransaksiProsesAktivasiVoucherPage.routeName);
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
  Future<void> fetchProviders() async {
    if (state.apiFetchProviderStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProviderStatus: ApiStatus.loading,
        apiFetchProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getAktivasiVoucherMemberProviders();
      if (!result.status) {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.failure,
            apiFetchProviderMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
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
            apiFetchProviderMessage: 'Data provider aktivasi voucher kosong',
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
      final result = await _produkService.getAktivasiVoucherMemberProducts(
        idProvider: state.selectedProvider.idprovider,
      );
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
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk aktivasi voucher kosong',
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

  void setSearchProvider(String search, {bool updateController = false}) {
    emit(state.copyWith(searchProvider: search));
    if (updateController)
      _updateController(state.searchProviderController, search);
  }

  void setTujuan(String value, {bool updateController = false}) {
    emit(state.copyWith(tujuan: value));
    if (updateController) _updateController(state.tujuanController, value);
  }

  void setTujuanAwal(String value, {bool updateController = false}) {
    emit(state.copyWith(tujuanAwal: value));
    if (updateController) _updateController(state.tujuanAwalController, value);

    updateListTujuanBerurutan();
  }

  void setTujuanAkhir(String value, {bool updateController = false}) {
    emit(state.copyWith(tujuanAkhir: value));
    if (updateController) _updateController(state.tujuanAkhirController, value);

    updateListTujuanBerurutan();
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  void updateListTujuanBerurutan() {
    var valid = validateBerurutan();

    debugPrint("UPDATE LIST TUJUAN BERURUTAN: $valid");
    if (!valid) return;

    var tujuanAwal = int.tryParse(state.tujuanAwal) ?? 0;
    var tujuanAkhir = int.tryParse(state.tujuanAkhir) ?? 0;

    debugPrint("tujuanAwal: $tujuanAwal, tujuanAkhir: $tujuanAkhir");

    List<String> listTujuan = [];
    for (var i = tujuanAwal; i <= tujuanAkhir; i++) {
      listTujuan.add(i.toString());
    }
    emit(state.copyWith(listTujuan: listTujuan));
  }

  void setNewKonfirmasi({bool berurutan = false}) async {
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    if (berurutan) {
      var valid = validateBerurutan();
      if (!valid) return;
    } else {
      var valid = validateMultiTujuan();
      if (!valid) return;
    }

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

    for (var i = 0; i < state.listTujuan.length; i++) {
      dtlTransaksi.addItem(
        KeyValue(
          key:
              "Tujuan ${state.listTujuan.length > 1 ? (i + 1).toString() : ''}",
          value: state.listTujuan[i],
        ),
      );
    }

    var dtlPotongStok = KeyValueResponse(items: []);
    dtlPotongStok.addItem(
      KeyValue(key: "Harga", value: state.selectedProduct.hargaFormmated),
    );
    dtlPotongStok.addItem(
      KeyValue(key: "Jumalh", value: state.listTujuan.length.toString()),
    );

    dtlPotongStok.addItem(KeyValue(key: "Biaya Admin", value: "0"));

    emit(
      state.copyWith(
        totalPotongStok:
            state.selectedProduct.hargaproduk * state.listTujuan.length,
        detailTransaksi: dtlTransaksi,
        detailPotongStok: dtlPotongStok,
      ),
    );

    pushNamed(MemberAktivasiVoucherKonfirmasiTransaksiPage.routeName);
  }

  // ============================================================
  // RESET METHODS
  // ============================================================
  void resetState() {
    emit(
      MemberAktivasiVoucherState(
        tujuanFocusNode: FocusNode(),
        tujuanController: TextEditingController(),
        tujuanAwalFocusNode: FocusNode(),
        tujuanAwalController: TextEditingController(),
        tujuanAkhirFocusNode: FocusNode(),
        tujuanAkhirController: TextEditingController(),
        searchProductController: TextEditingController(),
        searchProviderController: TextEditingController(),
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

  void resetBerurutan() {
    emit(
      state.copyWith(
        tujuanAwal: '',
        tujuanAwalHasError: false,
        tujuanAwalErrorMessage: '',
        tujuanAwalController: TextEditingController(),
        tujuanAkhir: '',
        tujuanAkhirHasError: false,
        tujuanAkhirErrorMessage: '',
        tujuanAkhirController: TextEditingController(),
      ),
    );
  }

  // ============================================================
  // VALIDATION - SINGLE TUJUAN
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
  // VALIDATION - BERURUTAN
  // ============================================================
  bool validateBerurutan() {
    final awal = state.tujuanAwal.trim();
    final akhir = state.tujuanAkhir.trim();

    String? errorAwal;
    String? errorAkhir;

    if (awal.isEmpty) {
      errorAwal = 'Tujuan awal tidak boleh kosong';
    }
    debugPrint("errorAwal: $errorAwal");

    if (akhir.isEmpty) {
      errorAkhir = 'Tujuan akhir tidak boleh kosong';
    }
    debugPrint("errorAkhir: $errorAkhir");

    // Cek tujuan awal
    if (awal.isNotEmpty) {
      final awalNum = int.tryParse(awal);
      if (awalNum == null) {
        errorAwal = 'Tujuan awal harus berupa angka';
      } else if (awalNum <= 0) {
        errorAwal = 'Tujuan awal harus lebih besar dari 0';
      }

      var validInput = state.selectedProvider.inputTipe.isValid(awal);
      if (!validInput) {
        errorAwal = state.selectedProvider.inputTipe.errorMessage;
      }
    }
    debugPrint("errorAwal after check: $errorAwal");

    // Cek tujuan akhir
    if (akhir.isNotEmpty) {
      final akhirNum = int.tryParse(akhir);
      if (akhirNum == null) {
        errorAkhir = 'Tujuan akhir harus berupa angka';
      } else if (akhirNum <= 0) {
        errorAkhir = 'Tujuan akhir harus lebih besar dari 0';
      }

      var validInput = state.selectedProvider.inputTipe.isValid(akhir);
      if (!validInput) {
        errorAkhir = state.selectedProvider.inputTipe.errorMessage;
      }
    }
    debugPrint("errorAkhir after check: $errorAkhir");

    if (awal.isNotEmpty && akhir.isNotEmpty) {
      final awalNum = int.tryParse(awal) ?? 0;
      final akhirNum = int.tryParse(akhir) ?? 0;

      if (awalNum > akhirNum) {
        errorAkhir =
            'Tujuan akhir harus lebih besar atau sama dengan tujuan awal';
      }
    }
    debugPrint("errorAkhir after range check: $errorAkhir");

    emit(
      state.copyWith(
        tujuanAwalHasError: errorAwal != null,
        tujuanAwalErrorMessage: errorAwal ?? '',
        tujuanAkhirHasError: errorAkhir != null,
        tujuanAkhirErrorMessage: errorAkhir ?? '',
      ),
    );

    return errorAwal == null && errorAkhir == null;
  }

  // ============================================================
  // MULTI TUJUAN
  // ============================================================
  void initMulti() {
    emit(
      state.copyWith(
        listTujuan: [''],
        listTujuanController: [TextEditingController()],
        listTujuanFocusNode: [FocusNode()],
        listTujuanHasError: [false],
        listTujuanErrorMessage: [''],
        listTujuanShakeKey: [GlobalKey<ShakeErrorWidgetState>()],
      ),
    );
  }

  void addMultiTujuan() {
    if (state.listTujuan.length == 10) {
      showWarningMessage('Maksimal 10 kode voucher dapat ditambahkan');
      return;
    }

    emit(
      state.copyWith(
        listTujuan: [...state.listTujuan, ''],
        listTujuanController: [
          ...state.listTujuanController,
          TextEditingController(),
        ],
        listTujuanFocusNode: [...state.listTujuanFocusNode, FocusNode()],
        listTujuanHasError: [...state.listTujuanHasError, false],
        listTujuanErrorMessage: [...state.listTujuanErrorMessage, ''],
        listTujuanShakeKey: [
          ...state.listTujuanShakeKey,
          GlobalKey<ShakeErrorWidgetState>(),
        ],
      ),
    );
  }

  void setMultiTujuan(
    int index,
    String value, {
    bool updateController = false,
  }) {
    final updated = List<String>.from(state.listTujuan)..[index] = value;
    emit(state.copyWith(listTujuan: updated));

    if (updateController) {
      _updateController(state.listTujuanController[index], value);
    }
  }

  void deleteMultiTujuan(int index) {
    emit(
      state.copyWith(
        listTujuan: List.from(state.listTujuan)..removeAt(index),
        listTujuanController: List.from(state.listTujuanController)
          ..removeAt(index),
        listTujuanFocusNode: List.from(state.listTujuanFocusNode)
          ..removeAt(index),
        listTujuanHasError: List.from(state.listTujuanHasError)
          ..removeAt(index),
        listTujuanErrorMessage: List.from(state.listTujuanErrorMessage)
          ..removeAt(index),
        listTujuanShakeKey: List.from(state.listTujuanShakeKey)
          ..removeAt(index),
      ),
    );
  }

  bool validateMultiTujuan({ProviderModel? provider}) {
    debugPrint("VALIDATE MULTI TUJUAN CALLED");
    final selectedProvider = provider ?? state.selectedProvider;
    final errors = state.listTujuan
        .map((t) => _validateTujuanValue(t.trim(), selectedProvider))
        .toList();

    emit(
      state.copyWith(
        listTujuanHasError: errors.map((e) => e != null).toList(),
        listTujuanErrorMessage: errors.map((e) => e ?? '').toList(),
      ),
    );

    debugPrint("MULTI TUJUAN ERRORS: $errors");

    return !errors.any((e) => e != null);
  }

  // ============================================================
  // PRIVATE VALIDATION HELPER
  // ============================================================
  String? _validateTujuanValue(String tujuan, ProviderModel provider) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
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

MemberAktivasiVoucherProvider getMemberAktivasiVoucherProvider(
  BuildContext context,
) => context.read<MemberAktivasiVoucherProvider>();
