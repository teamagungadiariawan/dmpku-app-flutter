import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasaAktifState extends Equatable {
  final ApiStatus apiFetchMasaAktifProviderStatus;
  final String apiFetchMasaAktifProviderMessage;
  final List<ProviderModel> masaAktifProviders;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  final ProviderModel selectedProvider;

  final ApiStatus apiFetchMasaAktifProductStatus;
  final String apiFetchMasaAktifProductMessage;
  final List<ProductModel> masaAktifProduct;

  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  final ProductModel selectedProduct;

  const MasaAktifState({
    this.apiFetchMasaAktifProviderStatus = ApiStatus.initial,
    this.apiFetchMasaAktifProviderMessage = '',
    this.masaAktifProviders = const [],

    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',

    this.selectedProvider = DEFAULT_PROVIDER,

    this.apiFetchMasaAktifProductStatus = ApiStatus.initial,
    this.apiFetchMasaAktifProductMessage = '',
    this.masaAktifProduct = const [],

    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    this.selectedProduct = DEFAULT_PRODUCT,
  });

  MasaAktifState copyWith({
    ApiStatus? apiFetchMasaAktifProviderStatus,
    String? apiFetchMasaAktifProviderMessage,
    List<ProviderModel>? masaAktifProviders,

    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,

    ProviderModel? selectedProvider,

    ApiStatus? apiFetchMasaAktifProductStatus,
    String? apiFetchMasaAktifProductMessage,
    List<ProductModel>? masaAktifProduct,

    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    ProductModel? selectedProduct,
  }) {
    return MasaAktifState(
      apiFetchMasaAktifProviderStatus:
      apiFetchMasaAktifProviderStatus ?? this.apiFetchMasaAktifProviderStatus,
      apiFetchMasaAktifProviderMessage:
      apiFetchMasaAktifProviderMessage ?? this.apiFetchMasaAktifProviderMessage,
      masaAktifProviders: masaAktifProviders ?? this.masaAktifProviders,

      inputTujuanFocusNode: inputTujuanFocusNode ?? this.inputTujuanFocusNode,
      hasErrorInputTujuan: hasErrorInputTujuan ?? this.hasErrorInputTujuan,
      errorMessageInputTujuan:
      errorMessageInputTujuan ?? this.errorMessageInputTujuan,
      inputTujuanController:
      inputTujuanController ?? this.inputTujuanController,
      tujuan: tujuan ?? this.tujuan,

      selectedProvider: selectedProvider ?? this.selectedProvider,

      apiFetchMasaAktifProductStatus:
      apiFetchMasaAktifProductStatus ?? this.apiFetchMasaAktifProductStatus,
      apiFetchMasaAktifProductMessage:
      apiFetchMasaAktifProductMessage ?? this.apiFetchMasaAktifProductMessage,
      masaAktifProduct: masaAktifProduct ?? this.masaAktifProduct,

      sortProduct: sortProduct ?? this.sortProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
      searchProductController ?? this.searchProductController,

      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchMasaAktifProviderStatus,
    apiFetchMasaAktifProviderMessage,
    masaAktifProviders,

    inputTujuanFocusNode,
    hasErrorInputTujuan,
    errorMessageInputTujuan,
    inputTujuanController,
    tujuan,

    selectedProvider,

    apiFetchMasaAktifProductStatus,
    apiFetchMasaAktifProductMessage,
    masaAktifProduct,

    sortProduct,
    searchProduct,
    searchProductController,

    selectedProduct,
  ];
}

class MasaAktifProvider extends Cubit<MasaAktifState> {
  final ProdukService _produkService = ProdukService();

  MasaAktifProvider()
      : super(
    MasaAktifState(
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
        apiFetchMasaAktifProductStatus: ApiStatus.initial,
        apiFetchMasaAktifProductMessage: '',
        masaAktifProduct: [],
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
      MasaAktifState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchMasaAktifProviderStatus: ApiStatus.initial,
        masaAktifProviders: [],
        apiFetchMasaAktifProductStatus: ApiStatus.initial,
        apiFetchMasaAktifProductMessage: '',
        masaAktifProduct: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
      ),
    );
  }

  void fetchMasaAktifProviders() async {
    if (state.apiFetchMasaAktifProviderStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchMasaAktifProviderStatus: ApiStatus.loading,
        apiFetchMasaAktifProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getMasaAktifGuestProviders();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchMasaAktifProviderStatus: ApiStatus.success,
            masaAktifProviders: data.providerList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchMasaAktifProviderStatus: ApiStatus.failure,
            apiFetchMasaAktifProviderMessage: 'Data provider masaAktif kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PROVIDERS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchMasaAktifProviderStatus: ApiStatus.failure,
          apiFetchMasaAktifProviderMessage: e.message,
        ),
      );
    }
  }

  void setSelectedProvider(ProviderModel provider) async {
    emit(state.copyWith(selectedProvider: provider));

    fetchMasaAktifProducts();
  }

  void fetchMasaAktifProducts() async {
    if (state.selectedProvider.idprovider == 0) return;

    if (state.apiFetchMasaAktifProductStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchMasaAktifProductStatus: ApiStatus.loading,
        apiFetchMasaAktifProductMessage: '',
        masaAktifProduct: [],
      ),
    );

    try {
      final result = await _produkService.getMasaAktifGuestProducts(
        idProvider: state.selectedProvider.idprovider,
      );

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchMasaAktifProductStatus: ApiStatus.success,
            masaAktifProduct: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchMasaAktifProductStatus: ApiStatus.failure,
            apiFetchMasaAktifProductMessage: 'Data produk masaAktif kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PRODUCTS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchMasaAktifProductStatus: ApiStatus.failure,
          apiFetchMasaAktifProductMessage: e.message,
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

MasaAktifProvider getMasaAktifProvider(BuildContext context) =>
    context.read<MasaAktifProvider>();
