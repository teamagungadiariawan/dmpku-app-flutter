import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class MemberTokenPlnState extends Equatable {
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

  const MemberTokenPlnState({
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
  });

  MemberTokenPlnState copyWith({
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
  }) {
    return MemberTokenPlnState(
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

// ============================================================
// CUBIT
// ============================================================
class MemberTokenPlnProvider extends Cubit<MemberTokenPlnState> {
  final ProdukService _produkService = ProdukService();

  MemberTokenPlnProvider()
    : super(
        MemberTokenPlnState(
          tujuanFocusNode: FocusNode(),
          tujuanController: TextEditingController(),
          searchProductController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.tujuanFocusNode?.dispose();
    state.tujuanController?.dispose();
    state.searchProductController?.dispose();
    return super.close();
  }

  // ============================================================
  // API CALLS
  // ============================================================
  Future<void> fetchProducts() async {
    if (state.apiFetchProductStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.loading,
        apiFetchProductMessage: '',
      ),
    );

    try {
      final result = await _produkService.getTokenPlnMemberProducts();
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
            apiFetchProductMessage: 'Data produk token pln kosong',
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
      MemberTokenPlnState(
        tujuanFocusNode: FocusNode(),
        tujuanController: TextEditingController(),
        searchProductController: TextEditingController(),
      ),
    );
  }

  // ============================================================
  // VALIDATION
  // ============================================================
  bool validateTujuan() {
    final error = _validateTujuanValue(state.tujuan.trim());

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
  String? _validateTujuanValue(String tujuan) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
    }

    // Validasi tipe input
    if (!TipeInput.numericOnly.isValid(tujuan)) {
      return TipeInput.numericOnly.errorMessage;
    }

    if (state.products.isNotEmpty) {
      var firstProduct = state.products.first;

      var minLength = firstProduct.mintujuan;
      var maxLength = firstProduct.maxtujuan;
      if (tujuan.length < minLength || tujuan.length > maxLength) {
        return 'Panjang tujuan harus antara $minLength hingga $maxLength karakter';
      }

      // Tipe input
      if (!firstProduct.inputTipe.isValid(tujuan)) {
        return firstProduct.inputTipe.errorMessage;
      }
    }

    return null;
  }
}

MemberTokenPlnProvider getMemberTokenPlnProvider(BuildContext context) =>
    context.read<MemberTokenPlnProvider>();
