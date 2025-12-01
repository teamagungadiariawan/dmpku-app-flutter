import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AktivasiVoucherState extends Equatable {
  final ApiStatus apiFetchAktivasiVoucherProviderStatus;
  final String apiFetchAktivasiVoucherProviderMessage;
  final List<ProviderModel> aktivasiVoucherProviders;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  final ProviderModel selectedProvider;

  final ApiStatus apiFetchAktivasiVoucherProductStatus;
  final String apiFetchAktivasiVoucherProductMessage;
  final List<ProductModel> aktivasiVoucherProduct;

  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  final ProductModel selectedProduct;

  final String searchProvider;
  final TextEditingController? searchProviderController;

  const AktivasiVoucherState({
    this.apiFetchAktivasiVoucherProviderStatus = ApiStatus.initial,
    this.apiFetchAktivasiVoucherProviderMessage = '',
    this.aktivasiVoucherProviders = const [],
    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',
    this.selectedProvider = DEFAULT_PROVIDER,
    this.apiFetchAktivasiVoucherProductStatus = ApiStatus.initial,
    this.apiFetchAktivasiVoucherProductMessage = '',
    this.aktivasiVoucherProduct = const [],
    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,
    this.selectedProduct = DEFAULT_PRODUCT,
    this.searchProvider = '',
    this.searchProviderController,
  });

  AktivasiVoucherState copyWith({
    ApiStatus? apiFetchAktivasiVoucherProviderStatus,
    String? apiFetchAktivasiVoucherProviderMessage,
    List<ProviderModel>? aktivasiVoucherProviders,
    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,
    ProviderModel? selectedProvider,
    ApiStatus? apiFetchAktivasiVoucherProductStatus,
    String? apiFetchAktivasiVoucherProductMessage,
    List<ProductModel>? aktivasiVoucherProduct,
    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,
    ProductModel? selectedProduct,
    String? searchProvider,
    TextEditingController? searchProviderController,
  }) {
    return AktivasiVoucherState(
      apiFetchAktivasiVoucherProviderStatus:
          apiFetchAktivasiVoucherProviderStatus ??
              this.apiFetchAktivasiVoucherProviderStatus,
      apiFetchAktivasiVoucherProviderMessage:
          apiFetchAktivasiVoucherProviderMessage ??
              this.apiFetchAktivasiVoucherProviderMessage,
      aktivasiVoucherProviders:
          aktivasiVoucherProviders ?? this.aktivasiVoucherProviders,
      inputTujuanFocusNode: inputTujuanFocusNode ?? this.inputTujuanFocusNode,
      hasErrorInputTujuan: hasErrorInputTujuan ?? this.hasErrorInputTujuan,
      errorMessageInputTujuan:
          errorMessageInputTujuan ?? this.errorMessageInputTujuan,
      inputTujuanController:
          inputTujuanController ?? this.inputTujuanController,
      tujuan: tujuan ?? this.tujuan,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      apiFetchAktivasiVoucherProductStatus:
          apiFetchAktivasiVoucherProductStatus ??
              this.apiFetchAktivasiVoucherProductStatus,
      apiFetchAktivasiVoucherProductMessage:
          apiFetchAktivasiVoucherProductMessage ??
              this.apiFetchAktivasiVoucherProductMessage,
      aktivasiVoucherProduct:
          aktivasiVoucherProduct ?? this.aktivasiVoucherProduct,
      sortProduct: sortProduct ?? this.sortProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
          searchProductController ?? this.searchProductController,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      searchProvider: searchProvider ?? this.searchProvider,
      searchProviderController:
          searchProviderController ?? this.searchProviderController,
    );
  }

  @override
  List<Object?> get props => [
        apiFetchAktivasiVoucherProviderStatus,
        apiFetchAktivasiVoucherProviderMessage,
        aktivasiVoucherProviders,
        inputTujuanFocusNode,
        hasErrorInputTujuan,
        errorMessageInputTujuan,
        inputTujuanController,
        tujuan,
        selectedProvider,
        apiFetchAktivasiVoucherProductStatus,
        apiFetchAktivasiVoucherProductMessage,
        aktivasiVoucherProduct,
        sortProduct,
        searchProduct,
        searchProductController,
        selectedProduct,
        searchProvider,
        searchProviderController,
      ];
}

class AktivasiVoucherProvider extends Cubit<AktivasiVoucherState> {
  final ProdukService _produkService = ProdukService();

  AktivasiVoucherProvider()
      : super(
          AktivasiVoucherState(
            inputTujuanFocusNode: FocusNode(),
            inputTujuanController: TextEditingController(),
            searchProductController: TextEditingController(),
            searchProviderController: TextEditingController(),
          ),
        );

  @override
  Future<void> close() {
    state.inputTujuanFocusNode?.dispose();
    state.inputTujuanController?.dispose();
    state.searchProductController?.dispose();
    state.searchProviderController?.dispose();
    return super.close();
  }

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
        apiFetchAktivasiVoucherProductStatus: ApiStatus.initial,
        apiFetchAktivasiVoucherProductMessage: '',
        aktivasiVoucherProduct: [],
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
      AktivasiVoucherState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchAktivasiVoucherProviderStatus: ApiStatus.initial,
        aktivasiVoucherProviders: [],
        apiFetchAktivasiVoucherProductStatus: ApiStatus.initial,
        apiFetchAktivasiVoucherProductMessage: '',
        aktivasiVoucherProduct: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
        searchProvider: '',
        searchProviderController: TextEditingController(),
      ),
    );
  }

  void fetchAktivasiVoucherProviders() async {
    if (state.apiFetchAktivasiVoucherProviderStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchAktivasiVoucherProviderStatus: ApiStatus.loading,
        apiFetchAktivasiVoucherProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getAktivasiVoucherGuestProviders();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchAktivasiVoucherProviderStatus: ApiStatus.success,
            aktivasiVoucherProviders: data.providerList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchAktivasiVoucherProviderStatus: ApiStatus.failure,
            apiFetchAktivasiVoucherProviderMessage:
                'Data provider aktivasiVoucher kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PROVIDERS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchAktivasiVoucherProviderStatus: ApiStatus.failure,
          apiFetchAktivasiVoucherProviderMessage: e.message,
        ),
      );
    }
  }

  void setSelectedProvider(ProviderModel provider) async {
    emit(state.copyWith(selectedProvider: provider));

    fetchAktivasiVoucherProducts();
  }

  void fetchAktivasiVoucherProducts() async {
    if (state.selectedProvider.idprovider == 0) return;

    if (state.apiFetchAktivasiVoucherProductStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchAktivasiVoucherProductStatus: ApiStatus.loading,
        apiFetchAktivasiVoucherProductMessage: '',
        aktivasiVoucherProduct: [],
      ),
    );

    try {
      final result = await _produkService.getAktivasiVoucherGuestProducts(
        idProvider: state.selectedProvider.idprovider,
      );

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchAktivasiVoucherProductStatus: ApiStatus.success,
            aktivasiVoucherProduct: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchAktivasiVoucherProductStatus: ApiStatus.failure,
            apiFetchAktivasiVoucherProductMessage:
                'Data produk aktivasiVoucher kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PRODUCTS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchAktivasiVoucherProductStatus: ApiStatus.failure,
          apiFetchAktivasiVoucherProductMessage: e.message,
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

  void setSearchProvider(String search, {bool updateTextController = false}) {
    emit(state.copyWith(searchProvider: search));

    if (updateTextController) {
      state.searchProviderController?.text = search;
      state.searchProviderController?.selection = TextSelection.fromPosition(
        TextPosition(offset: search.length),
      );
    }
  }

  void setSelectedProduct(ProductModel product) {
    emit(state.copyWith(selectedProduct: product));
  }
}

AktivasiVoucherProvider getAktivasiVoucherProvider(BuildContext context) =>
    context.read<AktivasiVoucherProvider>();
