import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class MemberTopupGameState extends Equatable {
  // Provider API
  final ApiStatus apiFetchProviderStatus;
  final String apiFetchProviderMessage;
  final List<ProviderModel> topupGameProviders;
  final List<ProviderModel> voucherGameProviders;
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

  // Others
  final bool isCekAkun;
  final String titleForm;
  final String hintForm;

  // Cek Akun API
  final ApiStatus apiCekAkunStatus;
  final String apiCekAkunMessage;
  final KeyValueResponse cekAkunResult;

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

  const MemberTopupGameState({
    // Provider
    this.apiFetchProviderStatus = ApiStatus.initial,
    this.apiFetchProviderMessage = '',
    this.topupGameProviders = const [],
    this.voucherGameProviders = const [],
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
    // Others
    this.isCekAkun = false,
    this.titleForm = 'ID Game',
    this.hintForm = 'Contoh : 123XXXXXXX',

    // Cek Akun
    this.apiCekAkunStatus = ApiStatus.initial,
    this.apiCekAkunMessage = '',
    this.cekAkunResult = DEFAULT_KEY_VALUE_RESPONSE,

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

  MemberTopupGameState copyWith({
    ApiStatus? apiFetchProviderStatus,
    String? apiFetchProviderMessage,
    List<ProviderModel>? topupGameProviders,
    List<ProviderModel>? voucherGameProviders,
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
    bool? isCekAkun,
    String? titleForm,
    String? hintForm,
    ApiStatus? apiCekAkunStatus,
    String? apiCekAkunMessage,
    KeyValueResponse? cekAkunResult,
    int? totalPotongStok,
    KeyValueResponse? detailTransaksi,
    KeyValueResponse? detailPotongStok,
    ApiStatus? apiKonfirmasiStatus,
    String? apiKonfirmasiMessage,
    bool? adaTrxSebelumnya,
    KeyValueResponse? detailTrxSebelumnya,
    int? trxke,
  }) {
    return MemberTopupGameState(
      apiFetchProviderStatus:
          apiFetchProviderStatus ?? this.apiFetchProviderStatus,
      apiFetchProviderMessage:
          apiFetchProviderMessage ?? this.apiFetchProviderMessage,
      topupGameProviders: topupGameProviders ?? this.topupGameProviders,
      voucherGameProviders: voucherGameProviders ?? this.voucherGameProviders,
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
      isCekAkun: isCekAkun ?? this.isCekAkun,
      titleForm: titleForm ?? this.titleForm,
      hintForm: hintForm ?? this.hintForm,
      apiCekAkunStatus: apiCekAkunStatus ?? this.apiCekAkunStatus,
      apiCekAkunMessage: apiCekAkunMessage ?? this.apiCekAkunMessage,
      cekAkunResult: cekAkunResult ?? this.cekAkunResult,
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
    apiFetchProviderStatus,
    apiFetchProviderMessage,
    topupGameProviders,
    voucherGameProviders,
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
    isCekAkun,
    titleForm,
    hintForm,
    apiCekAkunStatus,
    apiCekAkunMessage,
    cekAkunResult,
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
class MemberTopupGameProvider extends Cubit<MemberTopupGameState> {
  final ProdukService _produkService = ProdukService();

  MemberTopupGameProvider()
    : super(
        MemberTopupGameState(
          tujuanFocusNode: FocusNode(),
          tujuanController: TextEditingController(),
          searchProviderController: TextEditingController(),
          searchProductController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.tujuanFocusNode?.dispose();
    state.tujuanController?.dispose();
    state.searchProviderController?.dispose();
    state.searchProductController?.dispose();
    return super.close();
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
      final result = await _produkService.getTopupGameMemberProviders();
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.success,
            topupGameProviders: data.topupgame,
            voucherGameProviders: data.vouchergame,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.failure,
            apiFetchProviderMessage: 'Data provider topup game kosong',
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
      final result = await _produkService.getTopupGameMemberProducts(
        idProvider: state.selectedProvider.idprovider,
      );
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.success,
            products: data.productList,
            isCekAkun: data.productList.any((p) => p.kodeprodukcek.isNotEmpty),
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk topup game kosong',
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
  void setSelectedProvider(
    ProviderModel provider, {
    String? titleForm,
    String? hintForm,
  }) {
    emit(
      state.copyWith(
        selectedProvider: provider,
        titleForm: titleForm,
        hintForm: hintForm,
      ),
    );
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
    var val = value.trim();

    if (state.selectedProvider.idprovider != 0) {
      val = state.selectedProvider.inputTipe.filter(val);
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

  // ============================================================
  // RESET METHODS
  // ============================================================
  void resetState() {
    emit(
      MemberTopupGameState(
        tujuanFocusNode: FocusNode(),
        tujuanController: TextEditingController(),
        searchProviderController: TextEditingController(),
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
        isCekAkun: false,
        titleForm: 'ID Game',
        hintForm: 'Contoh : 123XXXXXXX',
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

MemberTopupGameProvider getMemberTopupGameProvider(BuildContext context) =>
    context.read<MemberTopupGameProvider>();
