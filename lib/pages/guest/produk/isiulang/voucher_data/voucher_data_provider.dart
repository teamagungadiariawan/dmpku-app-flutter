import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoucherDataState extends Equatable {
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

  const VoucherDataState({
    // Provider API
    this.apiFetchProviderStatus = ApiStatus.initial,
    this.apiFetchProviderMessage = '',
    this.providers = const [],
    this.selectedProvider = DEFAULT_PROVIDER,
    this.searchProvider = '',
    this.searchProviderController,
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
  });

  VoucherDataState copyWith({
    // Provider API
    ApiStatus? apiFetchProviderStatus,
    String? apiFetchProviderMessage,
    List<ProviderModel>? providers,
    ProviderModel? selectedProvider,
    String? searchProvider,
    TextEditingController? searchProviderController,
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
  }) {
    return VoucherDataState(
      // Provider API
      apiFetchProviderStatus:
          apiFetchProviderStatus ?? this.apiFetchProviderStatus,
      apiFetchProviderMessage:
          apiFetchProviderMessage ?? this.apiFetchProviderMessage,
      providers: providers ?? this.providers,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      searchProvider: searchProvider ?? this.searchProvider,
      searchProviderController:
          searchProviderController ?? this.searchProviderController,
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
    );
  }

  @override
  List<Object?> get props => [
    // Provider API
    apiFetchProviderStatus,
    apiFetchProviderMessage,
    providers,
    selectedProvider,
    searchProvider,
    searchProviderController,
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
  ];
}

class VoucherDataProvider extends Cubit<VoucherDataState> {
  final ProdukService _produkService = ProdukService();

  VoucherDataProvider()
    : super(
        VoucherDataState(
          tujuanFocusNode: FocusNode(),
          searchProviderController: TextEditingController(),
          searchProductController: TextEditingController(),
          tujuanController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.tujuanFocusNode?.dispose();
    state.searchProviderController?.dispose();
    state.searchProductController?.dispose();
    state.tujuanController?.dispose();
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
      final result = await _produkService.getVoucherDataGuestProviders();
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
      final result = await _produkService.getVoucherDataGuestProducts(
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
      VoucherDataState(
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

VoucherDataProvider getVoucherDataProvider(BuildContext context) =>
    context.read<VoucherDataProvider>();
