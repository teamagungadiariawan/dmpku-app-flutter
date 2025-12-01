import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopupGameState extends Equatable {
  final ApiStatus apiFetchTopupGameProviderStatus;
  final String apiFetchTopupGameProviderMessage;

  final List<ProviderModel> topupGameProviders;
  final List<ProviderModel> voucherGameProviders;

  final String searchProvider;
  final TextEditingController? searchProviderController;

  final ProviderModel selectedProvider;

  final ApiStatus apiFetchTopupGameProductStatus;
  final String apiFetchTopupGameProductMessage;
  final List<ProductModel> topupGameProducts;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  final ProductModel selectedProduct;

  final bool isCekAkun;
  final String titleForm;
  final String hintForm;

  const TopupGameState({
    this.apiFetchTopupGameProviderStatus = ApiStatus.initial,
    this.apiFetchTopupGameProviderMessage = '',

    this.topupGameProviders = const [],
    this.voucherGameProviders = const [],

    this.searchProvider = '',
    this.searchProviderController,

    this.selectedProvider = DEFAULT_PROVIDER,

    this.apiFetchTopupGameProductStatus = ApiStatus.initial,
    this.apiFetchTopupGameProductMessage = '',
    this.topupGameProducts = const [],

    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',

    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    this.selectedProduct = DEFAULT_PRODUCT,

    this.isCekAkun = false,
    this.titleForm = 'ID Game',
    this.hintForm = 'Contoh : 123XXXXXXX',
  });

  TopupGameState copyWith({
    ApiStatus? apiFetchTopupGameProviderStatus,
    String? apiFetchTopupGameProviderMessage,

    List<ProviderModel>? topupGameProviders,
    List<ProviderModel>? voucherGameProviders,

    String? searchProvider,
    TextEditingController? searchProviderController,

    ProviderModel? selectedProvider,

    ApiStatus? apiFetchTopupGameProductStatus,
    String? apiFetchTopupGameProductMessage,
    List<ProductModel>? topupGameProducts,

    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,

    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    ProductModel? selectedProduct,

    bool? isCekAkun,
    String? titleForm,
    String? hintForm,
  }) {
    return TopupGameState(
      apiFetchTopupGameProviderStatus:
          apiFetchTopupGameProviderStatus ??
          this.apiFetchTopupGameProviderStatus,
      apiFetchTopupGameProviderMessage:
          apiFetchTopupGameProviderMessage ??
          this.apiFetchTopupGameProviderMessage,

      topupGameProviders: topupGameProviders ?? this.topupGameProviders,
      voucherGameProviders: voucherGameProviders ?? this.voucherGameProviders,

      searchProvider: searchProvider ?? this.searchProvider,
      searchProviderController:
          searchProviderController ?? this.searchProviderController,

      selectedProvider: selectedProvider ?? this.selectedProvider,

      apiFetchTopupGameProductStatus:
          apiFetchTopupGameProductStatus ?? this.apiFetchTopupGameProductStatus,
      apiFetchTopupGameProductMessage:
          apiFetchTopupGameProductMessage ??
          this.apiFetchTopupGameProductMessage,
      topupGameProducts: topupGameProducts ?? this.topupGameProducts,

      inputTujuanFocusNode: inputTujuanFocusNode ?? this.inputTujuanFocusNode,
      hasErrorInputTujuan: hasErrorInputTujuan ?? this.hasErrorInputTujuan,
      errorMessageInputTujuan:
          errorMessageInputTujuan ?? this.errorMessageInputTujuan,
      inputTujuanController:
          inputTujuanController ?? this.inputTujuanController,
      tujuan: tujuan ?? this.tujuan,

      sortProduct: sortProduct ?? this.sortProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
          searchProductController ?? this.searchProductController,

      selectedProduct: selectedProduct ?? this.selectedProduct,

      isCekAkun: isCekAkun ?? this.isCekAkun,
      titleForm: titleForm ?? this.titleForm,
      hintForm: hintForm ?? this.hintForm,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchTopupGameProviderStatus,
    apiFetchTopupGameProviderMessage,

    topupGameProviders,
    voucherGameProviders,

    searchProvider,
    searchProviderController,

    selectedProvider,

    apiFetchTopupGameProductStatus,
    apiFetchTopupGameProductMessage,
    topupGameProducts,

    inputTujuanFocusNode,
    hasErrorInputTujuan,
    errorMessageInputTujuan,
    inputTujuanController,
    tujuan,

    sortProduct,
    searchProduct,
    searchProductController,

    selectedProduct,

    isCekAkun,
    titleForm,
    hintForm,
  ];
}

class TopupGameProvider extends Cubit<TopupGameState> {
  final ProdukService _produkService = ProdukService();

  TopupGameProvider()
    : super(
        TopupGameState(
          inputTujuanFocusNode: FocusNode(),
          inputTujuanController: TextEditingController(),
          searchProviderController: TextEditingController(),
          searchProductController: TextEditingController(),
        ),
      );

  void setSearchProvider(String val, {bool updateTextController = false}) {
    if (updateTextController) {
      state.searchProviderController?.text = val;
    }
    emit(state.copyWith(searchProvider: val));
  }

  void setSelectedProvider(
    ProviderModel provider, {
    String? titleForm,
    String? hintForm,
  }) {
    emit(state.copyWith(selectedProvider: provider));

    if (titleForm != null) {
      emit(state.copyWith(titleForm: titleForm));
    }

    if (hintForm != null) {
      emit(state.copyWith(hintForm: hintForm));
    }

    fetchTopupGameProducts();
  }

  void resetProduk() {
    emit(
      state.copyWith(
        apiFetchTopupGameProductStatus: ApiStatus.initial,
        apiFetchTopupGameProductMessage: '',
        topupGameProducts: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
        isCekAkun: false,
        titleForm: 'ID Game',
        hintForm: 'Contoh : 123XXXXXXX',
      ),
    );
  }

  void resetState() {
    emit(
      TopupGameState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchTopupGameProviderStatus: ApiStatus.initial,
        topupGameProviders: [],
        voucherGameProviders: [],
        searchProvider: '',
        searchProviderController: TextEditingController(),
        apiFetchTopupGameProductStatus: ApiStatus.initial,
        apiFetchTopupGameProductMessage: '',
        topupGameProducts: [],
        selectedProvider: DEFAULT_PROVIDER,
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
      ),
    );
  }

  void fetchTopupGameProviders() async {
    emit(
      state.copyWith(
        apiFetchTopupGameProviderStatus: ApiStatus.loading,
        apiFetchTopupGameProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getTopupGameGuestProviders();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchTopupGameProviderStatus: ApiStatus.success,
            topupGameProviders: data.topupgame,
            voucherGameProviders: data.vouchergame,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchTopupGameProviderStatus: ApiStatus.failure,
            apiFetchTopupGameProviderMessage: 'Data provider kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH TOP UP GAME PROVIDERS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchTopupGameProviderStatus: ApiStatus.failure,
          apiFetchTopupGameProviderMessage: e.message,
        ),
      );
    }
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

      switch (selectedProvider.tipeinput) {
        case "1":
          if (!RegExp(r'^[0-9]+$').hasMatch(tujuan)) {
            emit(
              state.copyWith(
                hasErrorInputTujuan: true,
                errorMessageInputTujuan: 'Tujuan harus berupa angka saja',
              ),
            );
            return false;
          }
          break;
        case "2":
          if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(tujuan)) {
            emit(
              state.copyWith(
                hasErrorInputTujuan: true,
                errorMessageInputTujuan:
                    'Tujuan harus berupa angka dan huruf saja',
              ),
            );
            return false;
          }
          break;
        case "3":
          if (!RegExp(r'^[a-zA-Z0-9@&=#\-. ]+$').hasMatch(tujuan)) {
            emit(
              state.copyWith(
                hasErrorInputTujuan: true,
                errorMessageInputTujuan:
                    'Tujuan mengandung karakter yang tidak diizinkan',
              ),
            );
            return false;
          }
          break;
      }
    }

    return true;
  }

  void fetchTopupGameProducts() async {
    if (state.selectedProvider.idprovider == 0) return;

    if (state.apiFetchTopupGameProductStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchTopupGameProductStatus: ApiStatus.loading,
        apiFetchTopupGameProductMessage: '',
      ),
    );

    try {
      final result = await _produkService.getTopupGameGuestProducts(
        idProvider: state.selectedProvider.idprovider,
      );

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchTopupGameProductStatus: ApiStatus.success,
            topupGameProducts: data.productList,
          ),
        );

        var isCekAkun = false;
        for (var product in data.productList) {
          if (product.kodeprodukcek != '') {
            isCekAkun = true;
            break;
          }
        }

        emit(state.copyWith(isCekAkun: isCekAkun));
      } else {
        emit(
          state.copyWith(
            apiFetchTopupGameProductStatus: ApiStatus.failure,
            apiFetchTopupGameProductMessage: 'Data produk kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH TOP UP GAME PRODUCTS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchTopupGameProductStatus: ApiStatus.failure,
          apiFetchTopupGameProductMessage: e.message,
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

TopupGameProvider getTopupGameProvider(BuildContext context) =>
    context.read<TopupGameProvider>();
