import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_cuan_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberPaketCuanState extends Equatable {
  // Provider API
  final ApiStatus apiFetchProviderStatus;
  final String apiFetchProviderMessage;
  final List<ProviderModel> providers;
  final ProviderModel selectedProvider;

  // SubProvider API
  final ApiStatus apiFetchSubProviderStatus;
  final String apiFetchSubProviderMessage;
  final List<ProductModel> subProviders;
  final ProductModel selectedSubProvider;

  // Product API
  final ApiStatus apiFetchProductStatus;
  final String apiFetchProductMessage;
  final List<ProductCuanModel> products;
  final ProductCuanModel selectedProduct;
  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  // Single Tujuan
  final String tujuan;
  final FocusNode? tujuanFocusNode;
  final TextEditingController? tujuanController;
  final bool tujuanHasError;
  final String tujuanErrorMessage;

  const MemberPaketCuanState({
    this.apiFetchProviderStatus = ApiStatus.initial,
    this.apiFetchProviderMessage = '',
    this.providers = const [],
    this.selectedProvider = DEFAULT_PROVIDER,

    this.apiFetchSubProviderStatus = ApiStatus.initial,
    this.apiFetchSubProviderMessage = '',
    this.subProviders = const [],
    this.selectedSubProvider = DEFAULT_PRODUCT,

    this.apiFetchProductStatus = ApiStatus.initial,
    this.apiFetchProductMessage = '',
    this.products = const [],
    this.selectedProduct = DEFAULT_PRODUCT_CUAN,
    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    this.tujuan = '',
    this.tujuanFocusNode,
    this.tujuanController,
    this.tujuanHasError = false,
    this.tujuanErrorMessage = '',
  });

  MemberPaketCuanState copyWith({
    ApiStatus? apiFetchProviderStatus,
    String? apiFetchProviderMessage,
    List<ProviderModel>? providers,
    ProviderModel? selectedProvider,

    ApiStatus? apiFetchSubProviderStatus,
    String? apiFetchSubProviderMessage,
    List<ProductModel>? subProviders,
    ProductModel? selectedSubProvider,

    ApiStatus? apiFetchProductStatus,
    String? apiFetchProductMessage,
    List<ProductCuanModel>? products,
    ProductCuanModel? selectedProduct,
    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    String? tujuan,
    FocusNode? tujuanFocusNode,
    TextEditingController? tujuanController,
    bool? tujuanHasError,
    String? tujuanErrorMessage,
  }) {
    return MemberPaketCuanState(
      apiFetchProviderStatus:
          apiFetchProviderStatus ?? this.apiFetchProviderStatus,
      apiFetchProviderMessage:
          apiFetchProviderMessage ?? this.apiFetchProviderMessage,
      providers: providers ?? this.providers,
      selectedProvider: selectedProvider ?? this.selectedProvider,

      apiFetchSubProviderStatus:
          apiFetchSubProviderStatus ?? this.apiFetchSubProviderStatus,
      apiFetchSubProviderMessage:
          apiFetchSubProviderMessage ?? this.apiFetchSubProviderMessage,
      subProviders: subProviders ?? this.subProviders,
      selectedSubProvider: selectedSubProvider ?? this.selectedSubProvider,

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
    );
  }

  @override
  List<Object?> get props => [
    apiFetchProviderStatus,
    apiFetchProviderMessage,
    providers,
    selectedProvider,

    apiFetchSubProviderStatus,
    apiFetchSubProviderMessage,
    subProviders,
    selectedSubProvider,

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
  ];
}

class MemberPaketCuanProvider extends Cubit<MemberPaketCuanState> {
  final ProdukService _productService = ProdukService();

  MemberPaketCuanProvider()
    : super(
        MemberPaketCuanState(
          tujuanFocusNode: FocusNode(),
          tujuanController: TextEditingController(),
          searchProductController: TextEditingController(),
        ),
      );

  void resetState() {
    emit(const MemberPaketCuanState());
  }

  void resetSubProviderState() {
    emit(
      state.copyWith(
        apiFetchSubProviderStatus: ApiStatus.initial,
        apiFetchSubProviderMessage: '',
        subProviders: [],
        selectedSubProvider: DEFAULT_PRODUCT,
        selectedProvider: DEFAULT_PROVIDER,
      ),
    );
  }

  void resetProductState() {
    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.initial,
        apiFetchProductMessage: '',
        products: [],
        selectedProduct: DEFAULT_PRODUCT_CUAN,
        selectedSubProvider: DEFAULT_PRODUCT,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
      ),
    );
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
      final result = await _productService.getPaketCuanMemberProviders();
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
            apiFetchProviderMessage: 'Data provider voucher digital kosong',
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

  Future<void> fetchSubProviders() async {
    if (state.selectedProvider.idprovider == 0) return;

    if (state.apiFetchSubProviderStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchSubProviderStatus: ApiStatus.loading,
        apiFetchSubProviderMessage: '',
      ),
    );

    try {
      final result = await _productService.getPaketCuanMemberSubProviders(
        idProvider: state.selectedProvider.idprovider,
      );
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchSubProviderStatus: ApiStatus.success,
            subProviders: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchSubProviderStatus: ApiStatus.failure,
            apiFetchSubProviderMessage:
                'Data sub-provider voucher digital kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH SUB-PROVIDERS: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchSubProviderStatus: ApiStatus.failure,
          apiFetchSubProviderMessage: e.message,
        ),
      );
    }
  }

  Future<void> fetchProducts() async {
    if (state.selectedSubProvider.idproduk == 0) return;

    if (state.apiFetchProductStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.loading,
        apiFetchProductMessage: '',
      ),
    );

    try {
      final result = await _productService.getPaketCuanMemberProducts(
        kodeproduk: state.selectedSubProvider.kodeproduk,
        tujuan: state.tujuan,
      );
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.success,
            products: data.products,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk voucher digital kosong',
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
    fetchSubProviders();
  }

  void setSelectedSubProvider(ProductModel product) {
    emit(state.copyWith(selectedSubProvider: product));
    fetchProducts();
  }

  void setSelectedProduct(ProductCuanModel product) {
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

MemberPaketCuanProvider getMemberPaketCuanProvider(BuildContext context) =>
    context.read<MemberPaketCuanProvider>();
