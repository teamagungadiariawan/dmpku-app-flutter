import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_nominal_bebas_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_pin_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class MemberDompetDigitalState extends Equatable {
  // Provider API
  final ApiStatus apiFetchProviderStatus;
  final String apiFetchProviderMessage;
  final List<ProviderModel> nominalPilihanProviders;
  final List<ProductModel> nominalBebsasProducts;
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
  final bool isMaxim;

  // Single Tujuan
  final String tujuan;
  final FocusNode? tujuanFocusNode;
  final TextEditingController? tujuanController;
  final bool tujuanHasError;
  final String tujuanErrorMessage;

  // Nominal Trx
  final String nominalTrx;
  final TextEditingController? nominalTrxController;
  final bool nominalTrxHasError;
  final String nominalTrxErrorMessage;
  final int nominalTrxNumber;

  // Others
  final bool isCekAkun;
  final String titleForm;
  final String hintForm;

  // Cek Akun API
  final ApiStatus apiCekAkunStatus;
  final String apiCekAkunMessage;
  final KeyValueResponse cekAkunResult;
  final String kodeProdukCek;

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

  const MemberDompetDigitalState({
    // Provider
    this.apiFetchProviderStatus = ApiStatus.initial,
    this.apiFetchProviderMessage = '',
    this.nominalPilihanProviders = const [],
    this.nominalBebsasProducts = const [],
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
    this.isMaxim = false,
    // Single
    this.tujuan = '',
    this.tujuanFocusNode,
    this.tujuanController,
    this.tujuanHasError = false,
    this.tujuanErrorMessage = '',
    // Nominal Trx
    this.nominalTrx = '',
    this.nominalTrxController,
    this.nominalTrxHasError = false,
    this.nominalTrxErrorMessage = '',
    this.nominalTrxNumber = 0,
    // Others
    this.isCekAkun = false,
    this.titleForm = 'No. Tujuan',
    this.hintForm = 'Contoh : 081XXXXXXX',

    // Cek Akun
    this.apiCekAkunStatus = ApiStatus.initial,
    this.apiCekAkunMessage = '',
    this.cekAkunResult = DEFAULT_KEY_VALUE_RESPONSE,
    this.kodeProdukCek = '',

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

  MemberDompetDigitalState copyWith({
    ApiStatus? apiFetchProviderStatus,
    String? apiFetchProviderMessage,
    List<ProviderModel>? nominalPilihanProviders,
    List<ProductModel>? nominalBebsasProducts,
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
    bool? isMaxim,
    String? tujuan,
    FocusNode? tujuanFocusNode,
    TextEditingController? tujuanController,
    bool? tujuanHasError,
    String? tujuanErrorMessage,
    String? nominalTrx,
    TextEditingController? nominalTrxController,
    bool? nominalTrxHasError,
    String? nominalTrxErrorMessage,
    int? nominalTrxNumber,
    bool? isCekAkun,
    String? titleForm,
    String? hintForm,
    ApiStatus? apiCekAkunStatus,
    String? apiCekAkunMessage,
    KeyValueResponse? cekAkunResult,
    String? kodeProdukCek,
    // Konfirmasi
    int? totalPotongStok,
    KeyValueResponse? detailTransaksi,
    KeyValueResponse? detailPotongStok,
    ApiStatus? apiKonfirmasiStatus,
    String? apiKonfirmasiMessage,
    // Trx Sebelumnya
    bool? adaTrxSebelumnya,
    KeyValueResponse? detailTrxSebelumnya,
    int? trxke,
  }) {
    return MemberDompetDigitalState(
      apiFetchProviderStatus:
          apiFetchProviderStatus ?? this.apiFetchProviderStatus,
      apiFetchProviderMessage:
          apiFetchProviderMessage ?? this.apiFetchProviderMessage,
      nominalPilihanProviders:
          nominalPilihanProviders ?? this.nominalPilihanProviders,
      nominalBebsasProducts:
          nominalBebsasProducts ?? this.nominalBebsasProducts,
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
      isMaxim: isMaxim ?? this.isMaxim,
      tujuan: tujuan ?? this.tujuan,
      tujuanFocusNode: tujuanFocusNode ?? this.tujuanFocusNode,
      tujuanController: tujuanController ?? this.tujuanController,
      tujuanHasError: tujuanHasError ?? this.tujuanHasError,
      tujuanErrorMessage: tujuanErrorMessage ?? this.tujuanErrorMessage,
      nominalTrx: nominalTrx ?? this.nominalTrx,
      nominalTrxController: nominalTrxController ?? this.nominalTrxController,
      nominalTrxHasError: nominalTrxHasError ?? this.nominalTrxHasError,
      nominalTrxErrorMessage:
          nominalTrxErrorMessage ?? this.nominalTrxErrorMessage,
      nominalTrxNumber: nominalTrxNumber ?? this.nominalTrxNumber,
      isCekAkun: isCekAkun ?? this.isCekAkun,
      titleForm: titleForm ?? this.titleForm,
      hintForm: hintForm ?? this.hintForm,
      apiCekAkunStatus: apiCekAkunStatus ?? this.apiCekAkunStatus,
      apiCekAkunMessage: apiCekAkunMessage ?? this.apiCekAkunMessage,
      cekAkunResult: cekAkunResult ?? this.cekAkunResult,
      kodeProdukCek: kodeProdukCek ?? this.kodeProdukCek,
      // Konfirmasi
      totalPotongStok: totalPotongStok ?? this.totalPotongStok,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi,
      detailPotongStok: detailPotongStok ?? this.detailPotongStok,
      apiKonfirmasiStatus: apiKonfirmasiStatus ?? this.apiKonfirmasiStatus,
      apiKonfirmasiMessage: apiKonfirmasiMessage ?? this.apiKonfirmasiMessage,
      // Trx Sebelumnya
      adaTrxSebelumnya: adaTrxSebelumnya ?? this.adaTrxSebelumnya,
      detailTrxSebelumnya: detailTrxSebelumnya ?? this.detailTrxSebelumnya,
      trxke: trxke ?? this.trxke,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchProviderStatus,
    apiFetchProviderMessage,
    nominalPilihanProviders,
    nominalBebsasProducts,
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
    isMaxim,
    tujuan,
    tujuanFocusNode,
    tujuanController,
    tujuanHasError,
    tujuanErrorMessage,
    nominalTrx,
    nominalTrxController,
    nominalTrxHasError,
    nominalTrxErrorMessage,
    nominalTrxNumber,
    isCekAkun,
    titleForm,
    hintForm,
    apiCekAkunStatus,
    apiCekAkunMessage,
    cekAkunResult,
    kodeProdukCek,
    // Konfirmasi
    totalPotongStok,
    detailTransaksi,
    detailPotongStok,
    apiKonfirmasiStatus,
    apiKonfirmasiMessage,
    // Trx Sebelumnya
    adaTrxSebelumnya,
    detailTrxSebelumnya,
    trxke,
  ];
}

// ============================================================
// CUBIT
// ============================================================
class MemberDompetDigitalProvider extends Cubit<MemberDompetDigitalState> {
  final ProdukService _produkService = ProdukService();

  MemberDompetDigitalProvider()
    : super(
        MemberDompetDigitalState(
          tujuanFocusNode: FocusNode(),
          tujuanController: TextEditingController(),
          searchProviderController: TextEditingController(),
          searchProductController: TextEditingController(),
          nominalTrxController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.tujuanFocusNode?.dispose();
    state.tujuanController?.dispose();
    state.searchProviderController?.dispose();
    state.searchProductController?.dispose();
    state.nominalTrxController?.dispose();
    return super.close();
  }

  // ============================================================
  // KONFIRMASI METHODS
  // ============================================================

  void konfirmasiTrx(BuildContext context) async {
    // Reset state sebelum show dialog
    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.initial,
        apiKonfirmasiMessage: '',
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );

    KonfirmasiPinDialog.show<
      MemberDompetDigitalProvider,
      MemberDompetDigitalState
    >(
      context,
      // Title & Subtitle default
      title:
          'Konfirmasi Transaksi Dompet Digital ${state.selectedProduct.namaproduk}',
      subtitle: 'Masukkan PIN untuk melanjutkan transaksi',
      // Title & Subtitle jika ada trx sebelumnya
      titleTrxSebelumnya: 'Konfirmasi Ulang Transaksi',
      subtitleTrxSebelumnya:
          'Transaksi serupa terdeteksi, harap konfirmasi ulang',
      bloc: this,
      isLoadingSelector: (state) => state.apiKonfirmasiStatus.isLoading,
      errorMessageSelector: (state) => state.apiKonfirmasiMessage,
      trxSebelumnyaSelector: (state) => TrxSebelumnyaState(
        adaTrxSebelumnya: state.adaTrxSebelumnya,
        detailTrxSebelumnya: state.detailTrxSebelumnya,
      ),
      onConfirm: (pin) => _prosesKonfirmasi(context, pin),
    );
  }

  Future<void> _prosesKonfirmasi(BuildContext context, String pin) async {
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    if (state.apiKonfirmasiStatus.isLoading) return;

    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.loading,
        apiKonfirmasiMessage: '',
      ),
    );

    try {
      var tujuan = state.selectedProvider.inputTipe.filter(state.tujuan.trim());
      var pintrx = TipeInput.numericOnly.filter(pin);

      final result = await _produkService.bayarDompetDigitalMember(
        kodeproduk: state.selectedProduct.kodeproduk,
        tujuan: tujuan,
        pintrx: pintrx,
        // Kirim trxke+1 jika ada trx sebelumnya (untuk konfirmasi ulang)
        trxke: state.trxke > 0 ? state.trxke + 1 : 1,
      );

      final data = result.data;
      if (!result.status) {
        emit(
          state.copyWith(
            apiKonfirmasiStatus: ApiStatus.failure,
            apiKonfirmasiMessage: result.message,
          ),
        );

        if (data != null) {
          if (data.trxke > 0 && state.trxke == 0) {
            _setTrxSebelumnyaFromResponse(data);
            emit(
              state.copyWith(
                apiKonfirmasiStatus: ApiStatus.initial,
                apiKonfirmasiMessage: '',
              ),
            );
            return;
          }
        }

        return;
      } else {
        emit(state.copyWith(apiKonfirmasiStatus: ApiStatus.success));

        if (context.mounted) {
          getTransaksiProsesProvider(
            context,
          ).setImage(NetworkImage(state.selectedProduct.imgproduk));
          getTransaksiProsesProvider(context).setProduct(state.selectedProduct);
          getTransaksiProsesProvider(
            context,
          ).setPotongStok(state.totalPotongStok);
          getTransaksiProsesProvider(context).setTujuan(state.tujuan.trim());
          getTransaksiProsesProvider(
            context,
          ).setWaktuTransaksi(DateTime.now().formatReg());
          resetState();

          pushNamedAndRemoveUntil(TransaksiProsesAltPage.routeName);
        }
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION KONFIRMASI: ${e.message}");
      emit(
        state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION KONFIRMASI: $e");
      emit(
        state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: 'Terjadi kesalahan, silakan coba lagi',
        ),
      );
    }
  }

  void konfirmasiTrxNominalBebas(BuildContext context) async {
    // Reset state sebelum show dialog
    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.initial,
        apiKonfirmasiMessage: '',
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );

    KonfirmasiPinDialog.show<
      MemberDompetDigitalProvider,
      MemberDompetDigitalState
    >(
      context,
      // Title & Subtitle default
      title:
          'Konfirmasi Transaksi Dompet Digital ${state.selectedProduct.namaproduk}',
      subtitle: 'Masukkan PIN untuk melanjutkan transaksi',
      // Title & Subtitle jika ada trx sebelumnya
      titleTrxSebelumnya: 'Konfirmasi Ulang Transaksi',
      subtitleTrxSebelumnya:
          'Transaksi serupa terdeteksi, harap konfirmasi ulang',
      bloc: this,
      isLoadingSelector: (state) => state.apiKonfirmasiStatus.isLoading,
      errorMessageSelector: (state) => state.apiKonfirmasiMessage,
      trxSebelumnyaSelector: (state) => TrxSebelumnyaState(
        adaTrxSebelumnya: state.adaTrxSebelumnya,
        detailTrxSebelumnya: state.detailTrxSebelumnya,
      ),
      onConfirm: (pin) => _prosesKonfirmasiNominalBebas(context, pin),
    );
  }

  Future<void> _prosesKonfirmasiNominalBebas(
    BuildContext context,
    String pin,
  ) async {
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    if (state.apiKonfirmasiStatus.isLoading) return;

    emit(
      state.copyWith(
        apiKonfirmasiStatus: ApiStatus.loading,
        apiKonfirmasiMessage: '',
      ),
    );

    debugPrint("PROSES KONFIRMASI NOMINAL BEBAS");

    try {
      var tujuan = state.selectedProvider.inputTipe.filter(state.tujuan.trim());
      var pintrx = TipeInput.numericOnly.filter(pin);

      var nominal =
          int.tryParse(TipeInput.numericOnly.filter(state.nominalTrx)) ?? 0;

      final result = await _produkService.bayarNominalBebasDompetDigitalMember(
        kodeproduk: state.selectedProduct.kodeproduk,
        tujuan: tujuan,
        pintrx: pintrx,
        // Kirim trxke+1 jika ada trx sebelumnya (untuk konfirmasi ulang)
        trxke: state.trxke > 0 ? state.trxke + 1 : 1,
        nominal: nominal,
      );

      final data = result.data;
      if (!result.status) {
        emit(
          state.copyWith(
            apiKonfirmasiStatus: ApiStatus.failure,
            apiKonfirmasiMessage: result.message,
          ),
        );

        if (data != null) {
          if (data.trxke > 0 && state.trxke == 0) {
            _setTrxSebelumnyaFromResponse(data);
            emit(
              state.copyWith(
                apiKonfirmasiStatus: ApiStatus.initial,
                apiKonfirmasiMessage: '',
              ),
            );
            return;
          }
        }

        return;
      } else {
        emit(state.copyWith(apiKonfirmasiStatus: ApiStatus.success));

        if (context.mounted) {
          getTransaksiProsesProvider(
            context,
          ).setImage(NetworkImage(state.selectedProduct.imgproduk));
          getTransaksiProsesProvider(context).setProduct(
            state.selectedProduct.copyWith(hargaproduk: state.totalPotongStok),
          );
          getTransaksiProsesProvider(
            context,
          ).setPotongStok(state.totalPotongStok);
          getTransaksiProsesProvider(context).setTujuan(state.tujuan.trim());
          getTransaksiProsesProvider(
            context,
          ).setWaktuTransaksi(DateTime.now().formatReg());
          resetState();

          pushNamedAndRemoveUntil(TransaksiProsesAltPage.routeName);
        }
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION KONFIRMASI: ${e.message}");
      emit(
        state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: e.message,
        ),
      );
    } catch (e) {
      debugPrint("EXCEPTION KONFIRMASI: $e");
      emit(
        state.copyWith(
          apiKonfirmasiStatus: ApiStatus.failure,
          apiKonfirmasiMessage: 'Terjadi kesalahan, silakan coba lagi',
        ),
      );
    }
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
      final result = await _produkService.getDompetDigitalMemberProviders();
      if (!result.status) {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.failure,
            apiFetchProviderMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.success,
            nominalPilihanProviders: data.nominalpilihan,
            nominalBebsasProducts: data.nominalbebas,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProviderStatus: ApiStatus.failure,
            apiFetchProviderMessage: 'Data provider dompet digital kosong',
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
      final result = await _produkService.getDompetDigitalMemberProducts(
        idProvider: state.selectedProvider.idprovider,
      );
      if (!result.status) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.success,
            products: data.productList,
            isCekAkun: data.productList.any((p) => p.kodeprodukcek.isNotEmpty),
            kodeProdukCek: data.productList
                .firstWhere(
                  (p) => p.kodeprodukcek.isNotEmpty,
                  orElse: () => DEFAULT_PRODUCT,
                )
                .kodeprodukcek,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk dompet digital kosong',
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

  Future<void> cekAkun() async {
    var valid = validateTujuan(provider: state.selectedProvider);
    if (!valid) return;

    if (state.apiCekAkunStatus.isLoading) return;

    emit(
      state.copyWith(
        apiCekAkunStatus: ApiStatus.loading,
        apiCekAkunMessage: '',
      ),
    );

    try {
      final result = await _produkService.cekAkunDompetDigital(
        kodeproduk: state.kodeProdukCek,
        tujuan: state.tujuan,
      );
      if (!result.status) {
        emit(
          state.copyWith(
            apiCekAkunStatus: ApiStatus.failure,
            apiCekAkunMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
      final data = result.data;

      if (data != null) {
        var dataTrx = result.dataSplit;

        if (dataTrx != null) {
          var dataTransaksi = dataTrx.dataTransaksi ?? [];

          var res = KeyValueResponse(items: dataTransaksi);

          emit(
            state.copyWith(
              apiCekAkunStatus: ApiStatus.success,
              cekAkunResult: res,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiCekAkunStatus: ApiStatus.failure,
            apiCekAkunMessage: 'Data cek akun kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION CEK AKUN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiCekAkunStatus: ApiStatus.failure,
          apiCekAkunMessage: e.message,
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

    var isMAx = removeNonAlphanumeric(provider.namaprovider).contains("maxim");
    emit(state.copyWith(isMaxim: isMAx));

    if (isMAx) {
      emit(
        state.copyWith(
          titleForm: "ID Maxim Driver",
          hintForm: "Contoh : 1234XXXXX",
        ),
      );
    }

    fetchProducts();
  }

  void setSelectedProduct(ProductModel product, {bool isNominalBebas = false}) {
    emit(state.copyWith(selectedProduct: product));

    if (isNominalBebas) {
      emit(
        state.copyWith(
          selectedProvider: DEFAULT_PROVIDER.copyWith(
            tipeinput: state.selectedProduct.tipeinput.toString(),
            mintujuan: state.selectedProduct.mintujuan,
            maxtujuan: state.selectedProduct.maxtujuan,
            imgprovider: state.selectedProduct.imgproduk,
            idprovider: 1,
          ),
          kodeProdukCek: product.kodeprodukcek,
        ),
      );
    }
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
    } else {
      val = TipeInput.alphanumeric.filter(val);
    }

    emit(state.copyWith(tujuan: val));
    if (updateController) _updateController(state.tujuanController, val);

    validateTujuan(provider: state.selectedProvider);
  }

  void setNominalTrx(String value, {bool updateController = false}) {
    var val = TipeInput.numericOnly.filter(value.trim());
    int nominal = int.tryParse(val) ?? 0;

    val = ToCurrency(val);

    debugPrint("SET NOMINAL TRX: val=$val, nominal=$nominal");

    emit(state.copyWith(nominalTrx: val, nominalTrxNumber: nominal));
    if (updateController) _updateController(state.nominalTrxController, val);

    validateNominalTrx();
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  void setNewKonfirmasi() async {
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    var valid = validateTujuan(provider: state.selectedProvider);
    if (!valid) return;

    var dtlTransaksi = KeyValueResponse(items: []);

    dtlTransaksi.addItem(
      KeyValue(key: "Waktu", value: DateTime.now().formatReg()),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Nama Produk", value: state.selectedProduct.namaproduk),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Kode Produk", value: state.selectedProduct.kodeproduk),
    );

    if (state.isCekAkun && state.cekAkunResult.items.isNotEmpty) {
      for (var item in state.cekAkunResult.items) {
        dtlTransaksi.addItem(KeyValue(key: item.key, value: item.value));
      }
    } else {
      if (state.isMaxim) {
        dtlTransaksi.addItem(
          KeyValue(key: "ID Maxim Driver", value: state.tujuan.trim()),
        );
      } else {
        dtlTransaksi.addItem(
          KeyValue(key: "No. Tujuan", value: state.tujuan.trim()),
        );
      }
    }

    var dtlPotongStok = KeyValueResponse(items: []);
    dtlPotongStok.addItem(
      KeyValue(key: "Harga", value: state.selectedProduct.hargaFormmated),
    );
    dtlPotongStok.addItem(KeyValue(key: "Biaya Admin", value: "0"));

    emit(
      state.copyWith(
        totalPotongStok: state.selectedProduct.hargaproduk,
        detailTransaksi: dtlTransaksi,
        detailPotongStok: dtlPotongStok,
      ),
    );

    pushNamed(MemberDompetDigitalKonfirmasiTransaksiPage.routeName);
  }

  void setNewKonfirmasiNominalBebas() async {
    if (state.selectedProvider.idprovider == 0) {
      showWarningMessage('Provider tidak valid');
      return;
    }

    if (state.selectedProduct.idproduk == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    var valid = validateTujuan(provider: state.selectedProvider);
    if (!valid) return;

    valid = validateNominalTrx();
    if (!valid) return;

    await cekAkun();

    var dtlTransaksi = KeyValueResponse(items: []);

    dtlTransaksi.addItem(
      KeyValue(key: "Waktu", value: DateTime.now().formatReg()),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Nama Produk", value: state.selectedProduct.namaproduk),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Kode Produk", value: state.selectedProduct.kodeproduk),
    );

    if (state.isCekAkun && state.cekAkunResult.items.isNotEmpty) {
      for (var item in state.cekAkunResult.items) {
        dtlTransaksi.addItem(KeyValue(key: item.key, value: item.value));
      }
    } else {
      if (state.isMaxim) {
        dtlTransaksi.addItem(
          KeyValue(key: "ID Maxim Driver", value: state.tujuan.trim()),
        );
      } else {
        dtlTransaksi.addItem(
          KeyValue(key: "No. Tujuan", value: state.tujuan.trim()),
        );
      }
    }

    var dtlPotongStok = KeyValueResponse(items: []);
    dtlPotongStok.addItem(KeyValue(key: "Harga", value: state.nominalTrx));
    dtlPotongStok.addItem(
      KeyValue(key: "Biaya Admin", value: state.selectedProduct.hargaFormmated),
    );

    var intNOminal =
        int.tryParse(TipeInput.numericOnly.filter(state.nominalTrx)) ?? 0;
    var totalPotong = state.selectedProduct.hargaproduk + intNOminal;

    emit(
      state.copyWith(
        totalPotongStok: totalPotong,
        detailTransaksi: dtlTransaksi,
        detailPotongStok: dtlPotongStok,
      ),
    );

    pushNamed(MemberDompetDigitalNominalBebasKonfirmasiTransaksiPage.routeName);
  }

  void _setTrxSebelumnyaFromResponse(BayarResponse data) {
    var detail = KeyValueResponse(items: []);

    detail.addItem(KeyValue(key: 'Nama Produk', value: data.namaproduk));
    detail.addItem(KeyValue(key: 'Kode Produk', value: data.kodeproduk));
    detail.addItem(KeyValue(key: 'Tujuan', value: data.tujuan));
    detail.addItem(
      KeyValue(key: 'SN', value: data.sn.isNotEmpty ? data.sn : '-'),
    );
    detail.addItem(KeyValue(key: 'Transaksi Ke', value: data.trxke.toString()));
    detail.addItem(KeyValue(key: 'Status', value: data.status));
    detail.addItem(KeyValue(key: 'Waktu', value: data.waktutrx));

    emit(
      state.copyWith(
        adaTrxSebelumnya: true,
        detailTrxSebelumnya: detail,
        trxke: data.trxke,
      ),
    );
  }

  // ============================================================
  // RESET METHODS
  // ============================================================
  void resetState() {
    emit(
      MemberDompetDigitalState(
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
        titleForm: 'No. Tujuan',
        hintForm: 'Contoh : 081XXXXXXX',
        apiCekAkunStatus: ApiStatus.initial,
        apiCekAkunMessage: '',
        cekAkunResult: DEFAULT_KEY_VALUE_RESPONSE,
        kodeProdukCek: '',
        tujuan: '',
        tujuanHasError: false,
        tujuanErrorMessage: '',
        tujuanController: TextEditingController(),
        nominalTrx: '',
        nominalTrxHasError: false,
        nominalTrxErrorMessage: '',
        nominalTrxController: TextEditingController(),
        nominalTrxNumber: 0,
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

  bool validateNominalTrx() {
    String error = '';
    int nominal = 0;

    if (state.nominalTrx.isEmpty) {
      error = 'Nominal transaksi tidak boleh kosong';
    } else {
      nominal =
          int.tryParse(TipeInput.numericOnly.filter(state.nominalTrx)) ?? 0;
      if (nominal <= 0) {
        error = 'Nominal transaksi harus lebih dari 0';
      }
    }

    if (state.selectedProduct.idproduk != 0) {
      if (nominal < state.selectedProduct.minnominalbebas) {
        error =
            'Nominal transaksi tidak boleh kurang dari ${ToCurrency(state.selectedProduct.minnominalbebas.toString())}';
      } else if (nominal > state.selectedProduct.maxnominalbebas) {
        error =
            'Nominal transaksi tidak boleh lebih dari ${ToCurrency(state.selectedProduct.maxnominalbebas.toString())}';
      }
    }

    emit(
      state.copyWith(
        nominalTrxHasError: error.isNotEmpty,
        nominalTrxErrorMessage: error,
        nominalTrxNumber: nominal,
      ),
    );

    return error.isEmpty;
  }

  // ============================================================
  // PRIVATE VALIDATION HELPER
  // ============================================================
  String? _validateTujuanValue(String tujuan, ProviderModel provider) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
    }

    if (provider.idprovider == 0) return null;

    if (!removeNonAlphanumeric(
      state.selectedProvider.namaprovider,
    ).contains("maxim")) {
      if (!state.tujuan.startsWith("08")) {
        return 'Tujuan harus diawali dengan 08';
      }
    }

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

MemberDompetDigitalProvider getMemberDompetDigitalProvider(
  BuildContext context,
) => context.read<MemberDompetDigitalProvider>();
