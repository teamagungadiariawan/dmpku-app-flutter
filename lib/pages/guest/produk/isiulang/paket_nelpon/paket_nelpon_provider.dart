import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaketNelponState extends Equatable {
  final ApiStatus apiFetchPaketNelponProviderStatus;
  final String apiFetchPaketNelponProviderMessage;
  final List<ProviderModel> paketNelponProviders;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  final ProviderModel selectedProvider;

  final ApiStatus apiFetchPaketNelponProductStatus;
  final String apiFetchPaketNelponProductMessage;
  final List<ProductModel> paketNelponProduct;

  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  final ProductModel selectedProduct;

  const PaketNelponState({
    this.apiFetchPaketNelponProviderStatus = ApiStatus.initial,
    this.apiFetchPaketNelponProviderMessage = '',
    this.paketNelponProviders = const [],

    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',

    this.selectedProvider = DEFAULT_PROVIDER,

    this.apiFetchPaketNelponProductStatus = ApiStatus.initial,
    this.apiFetchPaketNelponProductMessage = '',
    this.paketNelponProduct = const [],

    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    this.selectedProduct = DEFAULT_PRODUCT,
  });

  PaketNelponState copyWith({
    ApiStatus? apiFetchPaketNelponProviderStatus,
    String? apiFetchPaketNelponProviderMessage,
    List<ProviderModel>? paketNelponProviders,

    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,

    ProviderModel? selectedProvider,

    ApiStatus? apiFetchPaketNelponProductStatus,
    String? apiFetchPaketNelponProductMessage,
    List<ProductModel>? paketNelponProduct,

    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    ProductModel? selectedProduct,
  }) {
    return PaketNelponState(
      apiFetchPaketNelponProviderStatus:
      apiFetchPaketNelponProviderStatus ?? this.apiFetchPaketNelponProviderStatus,
      apiFetchPaketNelponProviderMessage:
      apiFetchPaketNelponProviderMessage ?? this.apiFetchPaketNelponProviderMessage,
      paketNelponProviders: paketNelponProviders ?? this.paketNelponProviders,

      inputTujuanFocusNode: inputTujuanFocusNode ?? this.inputTujuanFocusNode,
      hasErrorInputTujuan: hasErrorInputTujuan ?? this.hasErrorInputTujuan,
      errorMessageInputTujuan:
      errorMessageInputTujuan ?? this.errorMessageInputTujuan,
      inputTujuanController:
      inputTujuanController ?? this.inputTujuanController,
      tujuan: tujuan ?? this.tujuan,

      selectedProvider: selectedProvider ?? this.selectedProvider,

      apiFetchPaketNelponProductStatus:
      apiFetchPaketNelponProductStatus ?? this.apiFetchPaketNelponProductStatus,
      apiFetchPaketNelponProductMessage:
      apiFetchPaketNelponProductMessage ?? this.apiFetchPaketNelponProductMessage,
      paketNelponProduct: paketNelponProduct ?? this.paketNelponProduct,

      sortProduct: sortProduct ?? this.sortProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
      searchProductController ?? this.searchProductController,

      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchPaketNelponProviderStatus,
    apiFetchPaketNelponProviderMessage,
    paketNelponProviders,

    inputTujuanFocusNode,
    hasErrorInputTujuan,
    errorMessageInputTujuan,
    inputTujuanController,
    tujuan,

    selectedProvider,

    apiFetchPaketNelponProductStatus,
    apiFetchPaketNelponProductMessage,
    paketNelponProduct,

    sortProduct,
    searchProduct,
    searchProductController,

    selectedProduct,
  ];
}

class PaketNelponProvider extends Cubit<PaketNelponState> {
  final ProdukService _produkService = ProdukService();

  PaketNelponProvider()
      : super(
    PaketNelponState(
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
        apiFetchPaketNelponProductStatus: ApiStatus.initial,
        apiFetchPaketNelponProductMessage: '',
        paketNelponProduct: [],
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
      PaketNelponState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchPaketNelponProviderStatus: ApiStatus.initial,
        paketNelponProviders: [],
        apiFetchPaketNelponProductStatus: ApiStatus.initial,
        apiFetchPaketNelponProductMessage: '',
        paketNelponProduct: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
      ),
    );
  }

  void fetchPaketNelponProviders() async {
    debugPrint("FETCH PAKET NELPON PROVIDERS");

    if (state.apiFetchPaketNelponProviderStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchPaketNelponProviderStatus: ApiStatus.loading,
        apiFetchPaketNelponProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getPaketNelponGuestProviders();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchPaketNelponProviderStatus: ApiStatus.success,
            paketNelponProviders: data.providerList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchPaketNelponProviderStatus: ApiStatus.failure,
            apiFetchPaketNelponProviderMessage: 'Data provider paketNelpon kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PROVIDERS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchPaketNelponProviderStatus: ApiStatus.failure,
          apiFetchPaketNelponProviderMessage: e.message,
        ),
      );
    }
  }

  void setSelectedProvider(ProviderModel provider) async {
    emit(state.copyWith(selectedProvider: provider));

    fetchPaketNelponProducts();
  }

  void fetchPaketNelponProducts() async {
    if (state.selectedProvider.idprovider == 0) return;

    if (state.apiFetchPaketNelponProductStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchPaketNelponProductStatus: ApiStatus.loading,
        apiFetchPaketNelponProductMessage: '',
        paketNelponProduct: [],
      ),
    );

    try {
      final result = await _produkService.getPaketNelponGuestProducts(
        idProvider: state.selectedProvider.idprovider,
      );

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchPaketNelponProductStatus: ApiStatus.success,
            paketNelponProduct: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchPaketNelponProductStatus: ApiStatus.failure,
            apiFetchPaketNelponProductMessage: 'Data produk paketNelpon kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PRODUCTS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchPaketNelponProductStatus: ApiStatus.failure,
          apiFetchPaketNelponProductMessage: e.message,
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

PaketNelponProvider getPaketNelponProvider(BuildContext context) =>
    context.read<PaketNelponProvider>();
