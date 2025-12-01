import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaketDataState extends Equatable {
  final ApiStatus apiFetchPaketDataProviderStatus;
  final String apiFetchPaketDataProviderMessage;
  final List<ProviderModel> paketDataProviders;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  final ProviderModel selectedProvider;

  final ApiStatus apiFetchPaketDataProductStatus;
  final String apiFetchPaketDataProductMessage;
  final List<ProductModel> paketDataProduct;

  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  final ProductModel selectedProduct;

  const PaketDataState({
    this.apiFetchPaketDataProviderStatus = ApiStatus.initial,
    this.apiFetchPaketDataProviderMessage = '',
    this.paketDataProviders = const [],

    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',

    this.selectedProvider = DEFAULT_PROVIDER,

    this.apiFetchPaketDataProductStatus = ApiStatus.initial,
    this.apiFetchPaketDataProductMessage = '',
    this.paketDataProduct = const [],

    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    this.selectedProduct = DEFAULT_PRODUCT,
  });

  PaketDataState copyWith({
    ApiStatus? apiFetchPaketDataProviderStatus,
    String? apiFetchPaketDataProviderMessage,
    List<ProviderModel>? paketDataProviders,

    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,

    ProviderModel? selectedProvider,

    ApiStatus? apiFetchPaketDataProductStatus,
    String? apiFetchPaketDataProductMessage,
    List<ProductModel>? paketDataProduct,

    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    ProductModel? selectedProduct,
  }) {
    return PaketDataState(
      apiFetchPaketDataProviderStatus:
      apiFetchPaketDataProviderStatus ?? this.apiFetchPaketDataProviderStatus,
      apiFetchPaketDataProviderMessage:
      apiFetchPaketDataProviderMessage ?? this.apiFetchPaketDataProviderMessage,
      paketDataProviders: paketDataProviders ?? this.paketDataProviders,

      inputTujuanFocusNode: inputTujuanFocusNode ?? this.inputTujuanFocusNode,
      hasErrorInputTujuan: hasErrorInputTujuan ?? this.hasErrorInputTujuan,
      errorMessageInputTujuan:
      errorMessageInputTujuan ?? this.errorMessageInputTujuan,
      inputTujuanController:
      inputTujuanController ?? this.inputTujuanController,
      tujuan: tujuan ?? this.tujuan,

      selectedProvider: selectedProvider ?? this.selectedProvider,

      apiFetchPaketDataProductStatus:
      apiFetchPaketDataProductStatus ?? this.apiFetchPaketDataProductStatus,
      apiFetchPaketDataProductMessage:
      apiFetchPaketDataProductMessage ?? this.apiFetchPaketDataProductMessage,
      paketDataProduct: paketDataProduct ?? this.paketDataProduct,

      sortProduct: sortProduct ?? this.sortProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
      searchProductController ?? this.searchProductController,

      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchPaketDataProviderStatus,
    apiFetchPaketDataProviderMessage,
    paketDataProviders,

    inputTujuanFocusNode,
    hasErrorInputTujuan,
    errorMessageInputTujuan,
    inputTujuanController,
    tujuan,

    selectedProvider,

    apiFetchPaketDataProductStatus,
    apiFetchPaketDataProductMessage,
    paketDataProduct,

    sortProduct,
    searchProduct,
    searchProductController,

    selectedProduct,
  ];
}

class PaketDataProvider extends Cubit<PaketDataState> {
  final ProdukService _produkService = ProdukService();

  PaketDataProvider()
      : super(
    PaketDataState(
      inputTujuanFocusNode: FocusNode(),
      inputTujuanController: TextEditingController(),
      searchProductController: TextEditingController(),
    ),
  );

  void setTujuan(String tujuan, {bool updateTextController = false}) {
    emit(state.copyWith(tujuan: tujuan));

    if (updateTextController) {
      state.inputTujuanController?.text = tujuan;
      state.inputTujuanController?.selection = TextSelection.fromPosition(
        TextPosition(offset: tujuan.length),
      );
    }

    if (state.tujuan == '') {
      emit(
        state.copyWith(hasErrorInputTujuan: false, errorMessageInputTujuan: ''),
      );
      return;
    }

    if (tujuan.length > 2) {
      validateTujuan();
    }
  }

  bool validateTujuan({ProviderModel selectedProvider = DEFAULT_PROVIDER}) {
    emit(
      state.copyWith(hasErrorInputTujuan: false, errorMessageInputTujuan: ''),
    );

    final tujuan = state.tujuan.trim();

    if (tujuan.isEmpty) {
      emit(
        state.copyWith(
          hasErrorInputTujuan: true,
          errorMessageInputTujuan: 'Tujuan tidak boleh kosong',
        ),
      );

      return false;
    } else {
      if (!tujuan.startsWith('08')) {
        emit(
          state.copyWith(
            hasErrorInputTujuan: true,
            errorMessageInputTujuan: 'Tujuan harus diawali dengan 08',
          ),
        );
        return false;
      }
    }

    if (selectedProvider.idprovider != 0) {
      final minLength = selectedProvider.mintujuan;
      final maxLength = selectedProvider.maxtujuan;

      if (tujuan.length < minLength || tujuan.length > maxLength) {
        emit(
          state.copyWith(
            hasErrorInputTujuan: true,
            errorMessageInputTujuan:
            'Panjang tujuan harus antara $minLength hingga $maxLength karakter',
          ),
        );
        return false;
      }

      final prefixList = selectedProvider.prefixList;
      var valid = false;
      for (var prefik in prefixList) {
        var maxRange = state.tujuan.length < prefik.length
            ? state.tujuan.length
            : prefik.length;

        if (prefik.startsWith(state.tujuan.substring(0, maxRange))) {
          valid = true;
          break;
        }
      }

      if (!valid) {
        emit(
          state.copyWith(
            hasErrorInputTujuan: true,
            errorMessageInputTujuan:
            'Tujuan tidak sesuai dengan prefix provider ${selectedProvider.namaprovider}',
          ),
        );
        return false;
      }
    }

    return true;
  }

  void resetProduk() {
    emit(
      state.copyWith(
        apiFetchPaketDataProductStatus: ApiStatus.initial,
        apiFetchPaketDataProductMessage: '',
        paketDataProduct: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
      ),
    );
  }

  void resetState() {
    emit(
      PaketDataState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchPaketDataProviderStatus: ApiStatus.initial,
        paketDataProviders: [],
        apiFetchPaketDataProductStatus: ApiStatus.initial,
        apiFetchPaketDataProductMessage: '',
        paketDataProduct: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
      ),
    );
  }

  void fetchPaketDataProviders() async {
    if (state.apiFetchPaketDataProviderStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchPaketDataProviderStatus: ApiStatus.loading,
        apiFetchPaketDataProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getPaketDataGuestProviders();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchPaketDataProviderStatus: ApiStatus.success,
            paketDataProviders: data.providerList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchPaketDataProviderStatus: ApiStatus.failure,
            apiFetchPaketDataProviderMessage: 'Data provider paketData kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PROVIDERS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchPaketDataProviderStatus: ApiStatus.failure,
          apiFetchPaketDataProviderMessage: e.message,
        ),
      );
    }
  }

  void setSelectedProvider(ProviderModel provider) async {
    emit(state.copyWith(selectedProvider: provider));

    fetchPaketDataProducts();
  }

  void fetchPaketDataProducts() async {
    if (state.selectedProvider.idprovider == 0) return;

    if (state.apiFetchPaketDataProductStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchPaketDataProductStatus: ApiStatus.loading,
        apiFetchPaketDataProductMessage: '',
        paketDataProduct: [],
      ),
    );

    try {
      final result = await _produkService.getPaketDataGuestProducts(
        idProvider: state.selectedProvider.idprovider,
      );

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchPaketDataProductStatus: ApiStatus.success,
            paketDataProduct: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchPaketDataProductStatus: ApiStatus.failure,
            apiFetchPaketDataProductMessage: 'Data produk paketData kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PRODUCTS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchPaketDataProductStatus: ApiStatus.failure,
          apiFetchPaketDataProductMessage: e.message,
        ),
      );
    }
  }

  void setSortProduct(SortProductBy sortBy) {
    emit(state.copyWith(sortProduct: sortBy));
  }

  void setSearchProduct(String search, {bool updateTextController = false}) {
    emit(state.copyWith(searchProduct: search));

    if (updateTextController) {
      state.searchProductController?.text = search;
      state.searchProductController?.selection = TextSelection.fromPosition(
        TextPosition(offset: search.length),
      );
    }
  }

  void setSelectedProduct(ProductModel product) {
    emit(state.copyWith(selectedProduct: product));
  }
}

PaketDataProvider getPaketDataProvider(BuildContext context) =>
    context.read<PaketDataProvider>();
