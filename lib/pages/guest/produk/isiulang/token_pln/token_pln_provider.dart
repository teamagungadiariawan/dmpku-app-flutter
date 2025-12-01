import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenPlnState extends Equatable {
  final ApiStatus apiFetchTokenPlnProductStatus;
  final String apiFetchTokenPlnProductMessage;
  final List<ProductModel> tokenPlnProducts;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  final SortProductBy sortProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  final ProductModel selectedProduct;

  const TokenPlnState({
    this.apiFetchTokenPlnProductStatus = ApiStatus.initial,
    this.apiFetchTokenPlnProductMessage = '',
    this.tokenPlnProducts = const [],

    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',

    this.sortProduct = SortProductBy.hargaTerendah,
    this.searchProduct = '',
    this.searchProductController,

    this.selectedProduct = DEFAULT_PRODUCT,
  });

  TokenPlnState copyWith({
    ApiStatus? apiFetchTokenPlnProductStatus,
    String? apiFetchTokenPlnProductMessage,
    List<ProductModel>? tokenPlnProducts,

    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,

    SortProductBy? sortProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    ProductModel? selectedProduct,
  }) {
    return TokenPlnState(
      apiFetchTokenPlnProductStatus:
          apiFetchTokenPlnProductStatus ?? this.apiFetchTokenPlnProductStatus,
      apiFetchTokenPlnProductMessage:
          apiFetchTokenPlnProductMessage ?? this.apiFetchTokenPlnProductMessage,
      tokenPlnProducts: tokenPlnProducts ?? this.tokenPlnProducts,

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
    );
  }

  @override
  List<Object?> get props => [
    apiFetchTokenPlnProductStatus,
    apiFetchTokenPlnProductMessage,
    tokenPlnProducts,

    inputTujuanFocusNode,
    hasErrorInputTujuan,
    errorMessageInputTujuan,
    inputTujuanController,
    tujuan,

    sortProduct,
    searchProduct,
    searchProductController,

    selectedProduct,
  ];
}

class TokenPlnProvider extends Cubit<TokenPlnState> {
  final ProdukService _produkService = ProdukService();

  TokenPlnProvider()
    : super(
        TokenPlnState(
          inputTujuanFocusNode: FocusNode(),
          inputTujuanController: TextEditingController(),
          searchProductController: TextEditingController(),
        ),
      );


  void fetchTokenPlnProducts() async {
    if (state.apiFetchTokenPlnProductStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchTokenPlnProductStatus: ApiStatus.loading,
        apiFetchTokenPlnProductMessage: '',
      ),
    );

    try {
      final result = await _produkService.getTokenPlnGuestProducts();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchTokenPlnProductStatus: ApiStatus.success,
            tokenPlnProducts: data.productList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchTokenPlnProductStatus: ApiStatus.failure,
            apiFetchTokenPlnProductMessage: 'Data produk kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH TOP UP GAME PRODUCTS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchTokenPlnProductStatus: ApiStatus.failure,
          apiFetchTokenPlnProductMessage: e.message,
        ),
      );
    }
  }

  void resetState() {
    emit(
      TokenPlnState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchTokenPlnProductStatus: ApiStatus.initial,
        apiFetchTokenPlnProductMessage: '',
        tokenPlnProducts: [],
        hasErrorInputTujuan: false,
        errorMessageInputTujuan: '',
        sortProduct: SortProductBy.hargaTerendah,
        searchProduct: '',
        searchProductController: TextEditingController(),
        selectedProduct: DEFAULT_PRODUCT,
      ),
    );
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

  bool validateTujuan() {
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

    final minLength = 10;
    final maxLength = 20;

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

    final prefixList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
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
              'Tujuan tidak sesuai dengan prefix provider Token PLN',
        ),
      );
      return false;
    }

    var validTipeInput = TipeInput.numericOnly.isValid(state.tujuan);
    if (!validTipeInput) {
      emit(
        state.copyWith(
          hasErrorInputTujuan: true,
          errorMessageInputTujuan: TipeInput.numericOnly.errorMessage,
        ),
      );
      return false;
    }

    return true;
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

TokenPlnProvider getTokenPlnProvider(BuildContext context) =>
    context.read<TokenPlnProvider>();
