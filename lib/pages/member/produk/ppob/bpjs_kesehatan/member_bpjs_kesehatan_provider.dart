import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/cek_tagihan_response.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/service/member/product_service.dart';
import 'package:dmpku/widgets/dialog/error_tagihan_dialog.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_pin_dialog.dart';
import 'package:dmpku/widgets/dialog/pilih_product_ppob_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberBpjsKesehatanState extends Equatable {
  // Product API
  final ApiStatus apiFetchProductStatus;
  final String apiFetchProductMessage;
  final List<ProductModel> products;
  final ProductModel selectedProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  // Single Tujuan
  final String tujuan;
  final FocusNode? tujuanFocusNode;
  final TextEditingController? tujuanController;
  final bool tujuanHasError;
  final String tujuanErrorMessage;

  // Cek Akun API
  final ApiStatus apiCekTagihanStatus;
  final String apiCekTagihanMessage;
  final KeyValueResponse cekTagihanResult;
  final String kodeBayar;

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

  const MemberBpjsKesehatanState({
    // Product API
    this.apiFetchProductStatus = ApiStatus.initial,
    this.apiFetchProductMessage = '',
    this.products = const [],
    this.selectedProduct = DEFAULT_PRODUCT,
    this.searchProduct = '',
    this.searchProductController,

    // Single Tujuan
    this.tujuan = '',
    this.tujuanFocusNode,
    this.tujuanController,
    this.tujuanHasError = false,
    this.tujuanErrorMessage = '',

    // Cek Akun API
    this.apiCekTagihanStatus = ApiStatus.initial,
    this.apiCekTagihanMessage = '',
    this.cekTagihanResult = DEFAULT_KEY_VALUE_RESPONSE,
    this.kodeBayar = '',

    // Konfirmasi State
    this.totalPotongStok = 0,
    this.detailTransaksi = DEFAULT_KEY_VALUE_RESPONSE,
    this.detailPotongStok = DEFAULT_KEY_VALUE_RESPONSE,
    this.apiKonfirmasiStatus = ApiStatus.initial,
    this.apiKonfirmasiMessage = '',

    // Tambah untuk cek trx sebelumnya
    this.adaTrxSebelumnya = false,
    this.detailTrxSebelumnya = DEFAULT_KEY_VALUE_RESPONSE,
    this.trxke = 0,
  });

  MemberBpjsKesehatanState copyWith({
    // Product API
    ApiStatus? apiFetchProductStatus,
    String? apiFetchProductMessage,
    List<ProductModel>? products,
    ProductModel? selectedProduct,
    String? searchProduct,
    TextEditingController? searchProductController,

    // Single Tujuan
    String? tujuan,
    FocusNode? tujuanFocusNode,
    TextEditingController? tujuanController,
    bool? tujuanHasError,
    String? tujuanErrorMessage,

    // Cek Akun API
    ApiStatus? apiCekTagihanStatus,
    String? apiCekTagihanMessage,
    KeyValueResponse? cekTagihanResult,
    String? kodeBayar,

    // Konfirmasi State
    int? totalPotongStok,
    KeyValueResponse? detailTransaksi,
    KeyValueResponse? detailPotongStok,
    ApiStatus? apiKonfirmasiStatus,
    String? apiKonfirmasiMessage,

    // Tambah untuk cek trx sebelumnya
    bool? adaTrxSebelumnya,
    KeyValueResponse? detailTrxSebelumnya,
    int? trxke,
  }) {
    return MemberBpjsKesehatanState(
      // Product API
      apiFetchProductStatus:
          apiFetchProductStatus ?? this.apiFetchProductStatus,
      apiFetchProductMessage:
          apiFetchProductMessage ?? this.apiFetchProductMessage,
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
          searchProductController ?? this.searchProductController,

      // Single Tujuan
      tujuan: tujuan ?? this.tujuan,
      tujuanFocusNode: tujuanFocusNode ?? this.tujuanFocusNode,
      tujuanController: tujuanController ?? this.tujuanController,
      tujuanHasError: tujuanHasError ?? this.tujuanHasError,
      tujuanErrorMessage: tujuanErrorMessage ?? this.tujuanErrorMessage,

      // Cek Akun API
      apiCekTagihanStatus: apiCekTagihanStatus ?? this.apiCekTagihanStatus,
      apiCekTagihanMessage: apiCekTagihanMessage ?? this.apiCekTagihanMessage,
      cekTagihanResult: cekTagihanResult ?? this.cekTagihanResult,
      kodeBayar: kodeBayar ?? this.kodeBayar,

      // Konfirmasi State
      totalPotongStok: totalPotongStok ?? this.totalPotongStok,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi,
      detailPotongStok: detailPotongStok ?? this.detailPotongStok,
      apiKonfirmasiStatus: apiKonfirmasiStatus ?? this.apiKonfirmasiStatus,
      apiKonfirmasiMessage: apiKonfirmasiMessage ?? this.apiKonfirmasiMessage,

      // Tambah untuk cek trx sebelumnya
      adaTrxSebelumnya: adaTrxSebelumnya ?? this.adaTrxSebelumnya,
      detailTrxSebelumnya: detailTrxSebelumnya ?? this.detailTrxSebelumnya,
      trxke: trxke ?? this.trxke,
    );
  }

  @override
  List<Object?> get props => [
    // Product API
    apiFetchProductStatus,
    apiFetchProductMessage,
    products,
    selectedProduct,
    searchProduct,
    searchProductController,

    // Single Tujuan
    tujuan,
    tujuanFocusNode,
    tujuanController,
    tujuanHasError,
    tujuanErrorMessage,

    // Cek Akun API
    apiCekTagihanStatus,
    apiCekTagihanMessage,
    cekTagihanResult,
    kodeBayar,

    // Konfirmasi State
    totalPotongStok,
    detailTransaksi,
    detailPotongStok,
    apiKonfirmasiStatus,
    apiKonfirmasiMessage,

    // Tambah untuk cek trx sebelumnya
    adaTrxSebelumnya,
    detailTrxSebelumnya,
    trxke,
  ];
}

class MemberBpjsKesehatanProvider extends Cubit<MemberBpjsKesehatanState> {
  final ProdukService _produkService = ProdukService();

  MemberBpjsKesehatanProvider()
    : super(
        MemberBpjsKesehatanState(
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
      MemberBpjsKesehatanProvider,
      MemberBpjsKesehatanState
    >(
      context,
      // Title & Subtitle default
      title: 'Konfirmasi Transaksi ${state.selectedProduct.namaproduk}',
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
    if (state.kodeBayar.isEmpty) {
      showWarningMessage('Kode bayar tidak valid');
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
      var tujuan = state.selectedProduct.inputTipe.filter(state.tujuan.trim());
      var pintrx = TipeInput.numericOnly.filter(pin);

      final result = await _produkService.bayarBpjsKesehatanMember(
        kodeproduk: state.selectedProduct.kodeproduk,
        tujuan: tujuan,
        pintrx: pintrx,
        // Kirim trxke+1 jika ada trx sebelumnya (untuk konfirmasi ulang)
        trxke: state.trxke > 0 ? state.trxke + 1 : 1,
        kodebayar: state.kodeBayar,
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
  Future<void> fetchProducts() async {
    if (state.apiFetchProductStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchProductStatus: ApiStatus.loading,
        apiFetchProductMessage: '',
        products: [],
      ),
    );

    try {
      final result = await _produkService.getBpjsKesehatanProducts();
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
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchProductStatus: ApiStatus.failure,
            apiFetchProductMessage: 'Data produk cek status voucher kosong',
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

  Future<void> cekTagihan(BuildContext context) async {
    var valid = validateTujuan();
    if (!valid) return;

    if (state.apiCekTagihanStatus.isLoading) return;

    emit(
      state.copyWith(
        apiCekTagihanStatus: ApiStatus.loading,
        apiCekTagihanMessage: '',
      ),
    );

    try {
      final result = await _produkService.cekBpjsKesehatan(
        kodeproduk: state.selectedProduct.kodeproduk,
        tujuan: state.tujuan,
      );

      if (!result.status) {
        kelolaCekTagihan(context, result);
        emit(
          state.copyWith(
            apiCekTagihanStatus: ApiStatus.failure,
            apiCekTagihanMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }

      kelolaCekTagihan(context, result);
      emit(state.copyWith(apiCekTagihanStatus: ApiStatus.success));
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION CEK AKUN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiCekTagihanStatus: ApiStatus.failure,
          apiCekTagihanMessage: e.message,
        ),
      );
    }
  }

  // ============================================================
  // SETTERS
  // ============================================================

  void setSelectedProduct(ProductModel product) {
    emit(state.copyWith(selectedProduct: product.copyWith(idproduk: 1)));
  }

  void setSearchProduct(String search, {bool updateController = false}) {
    emit(state.copyWith(searchProduct: search));
    if (updateController)
      _updateController(state.searchProductController, search);
  }

  void setTujuan(String value, {bool updateController = false}) {
    var val = value.trim();

    if (state.selectedProduct.idproduk != 0) {
      val = state.selectedProduct.inputTipe.filter(val);
    }

    emit(state.copyWith(tujuan: val));
    if (updateController) _updateController(state.tujuanController, val);

    validateTujuan();
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  void kelolaCekTagihan(BuildContext context, CekTagihanResponse response) {
    if (response.status) {
      if (response.dataSplit != null) {
        List<KeyValue> dataTransaksi = response.dataSplit?.dataTransaksi ?? [];
        List<KeyValue> dataBiaya = response.dataSplit?.dataBiaya ?? [];

        dataTransaksi = dataTransaksi
            .where((element) => element.value.trim() != '')
            .toList();

        dataBiaya = dataBiaya
            .where(
              (element) =>
                  element.value.trim() != '' &&
                  removeNonAlphanumeric(element.key).trim().toLowerCase() !=
                      'totalbayar',
            )
            .toList();

        var dtlTransaksi = KeyValueResponse(items: []);
        for (var item in dataTransaksi) {
          dtlTransaksi.addItem(item);
        }

        var dtlPotongStok = KeyValueResponse(items: []);
        for (var item in dataBiaya) {
          item = item.copyWith(key: item.key, value: ToCurrency(item.value));
          dtlPotongStok.addItem(item);
        }

        var totalPotongStok = 0;

        var dataTrx = response.data;
        if (dataTrx != null) {
          totalPotongStok = dataTrx.potongsaldotagihan;
        }

        emit(
          state.copyWith(
            totalPotongStok: totalPotongStok,
            detailTransaksi: dtlTransaksi,
            detailPotongStok: dtlPotongStok,
            kodeBayar: response.data?.kodebayar ?? '',
          ),
        );

        pushNamed(MemberBpjsKesehatanKonfirmasiTransaksiPage.routeName);
      }
    } else {
      List<KeyValue> dataTransaksi = response.dataSplit?.dataTransaksi ?? [];
      dataTransaksi = dataTransaksi
          .where((element) => element.value.trim() != '')
          .toList();

      ErrorTagihanDialog.show(
        context,
        title: response.message,
        result: KeyValueResponse(items: dataTransaksi),
      );
    }
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
      MemberBpjsKesehatanState(
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
        selectedProduct: DEFAULT_PRODUCT,
        tujuan: '',
        tujuanController: TextEditingController(),
        tujuanHasError: false,
        tujuanErrorMessage: '',
        apiCekTagihanStatus: ApiStatus.initial,
        apiCekTagihanMessage: '',
        cekTagihanResult: DEFAULT_KEY_VALUE_RESPONSE,
        kodeBayar: '',
      ),
    );
  }

  void resetKonfirmasi() {
    emit(
      state.copyWith(
        totalPotongStok: 0,
        detailTransaksi: DEFAULT_KEY_VALUE_RESPONSE,
        detailPotongStok: DEFAULT_KEY_VALUE_RESPONSE,
        apiKonfirmasiStatus: ApiStatus.initial,
        apiKonfirmasiMessage: '',
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );
  }

  // ============================================================
  // VALIDATION
  // ============================================================
  bool validateTujuan() {
    final error = _validateTujuanValue(
      state.tujuan.trim(),
      state.selectedProduct,
    );

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
  String? _validateTujuanValue(String tujuan, ProductModel product) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
    }

    if (product.idproduk == 0) return null;

    // Validasi panjang
    if (tujuan.length < product.mintujuan ||
        tujuan.length > product.maxtujuan) {
      return 'Panjang tujuan harus antara ${product.mintujuan} hingga ${product.maxtujuan} karakter';
    }

    // Validasi tipe input
    if (!product.inputTipe.isValid(tujuan)) {
      return product.inputTipe.errorMessage;
    }

    return null;
  }

  // ============================================================
  // DIALOG
  // ============================================================
  void showPilihProdukDialog(BuildContext context) async {
    // Panggil fetch jika data masih kosong (opsional)
    if (state.products.isEmpty) {
      await fetchProducts();
    }

    PilihProductPpobDialog.show<
      MemberBpjsKesehatanProvider,
      MemberBpjsKesehatanState
    >(
      context,
      title: 'Pilih BPJS Kesehatan',
      subtitle: 'Pilih produk BPJS Kesehatan dari daftar berikut',
      bloc: this,
      isLoadingSelector: (state) => state.apiFetchProductStatus.isLoading,
      itemsSelector: (state) => state.products,
      onRefresh: () async {
        await fetchProducts();
      },
      items: state.products,
      onSelected: (selectedProduct) {
        setSelectedProduct(selectedProduct);
      },
    );
  }
}

MemberBpjsKesehatanProvider getMemberBpjsKesehatanProvider(
  BuildContext context,
) => context.read<MemberBpjsKesehatanProvider>();
