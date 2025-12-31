import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/cek_tagihan_response.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/promo_response.dart';
import 'package:dmpku/pages/member/produk/promo/member_promo_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/service/member/promo_service.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_pin_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class MemberPromoState extends Equatable {
  // Promo Products API
  final ApiStatus apiFetchPromoStatus;
  final String apiFetchPromoMessage;
  final List<PromoProdukModel> promoCategories;
  final PromoProdukModel selectedCategory;
  final ProviderPromoModel selectedProvider;
  final ProdukPromoModel selectedProduct;
  final String searchProduct;
  final TextEditingController? searchProductController;

  // Tujuan
  final String tujuan;
  final FocusNode? tujuanFocusNode;
  final TextEditingController? tujuanController;
  final bool tujuanHasError;
  final String tujuanErrorMessage;

  // Cek Akun API
  final ApiStatus apiCekAkunStatus;
  final String apiCekAkunMessage;
  final CekTagihanResponse? cekAkunData;

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

  const MemberPromoState({
    // Promo Products API
    this.apiFetchPromoStatus = ApiStatus.initial,
    this.apiFetchPromoMessage = '',
    this.promoCategories = const [],
    required this.selectedCategory,
    required this.selectedProvider,
    required this.selectedProduct,
    this.searchProduct = '',
    this.searchProductController,
    // Tujuan
    this.tujuan = '',
    this.tujuanFocusNode,
    this.tujuanController,
    this.tujuanHasError = false,
    this.tujuanErrorMessage = '',
    // Cek Akun API
    this.apiCekAkunStatus = ApiStatus.initial,
    this.apiCekAkunMessage = '',
    this.cekAkunData,
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

  MemberPromoState copyWith({
    // Promo Products API
    ApiStatus? apiFetchPromoStatus,
    String? apiFetchPromoMessage,
    List<PromoProdukModel>? promoCategories,
    PromoProdukModel? selectedCategory,
    ProviderPromoModel? selectedProvider,
    ProdukPromoModel? selectedProduct,
    String? searchProduct,
    TextEditingController? searchProductController,
    // Tujuan
    String? tujuan,
    FocusNode? tujuanFocusNode,
    TextEditingController? tujuanController,
    bool? tujuanHasError,
    String? tujuanErrorMessage,
    // Cek Akun API
    ApiStatus? apiCekAkunStatus,
    String? apiCekAkunMessage,
    CekTagihanResponse? cekAkunData,
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
    return MemberPromoState(
      // Promo Products API
      apiFetchPromoStatus: apiFetchPromoStatus ?? this.apiFetchPromoStatus,
      apiFetchPromoMessage: apiFetchPromoMessage ?? this.apiFetchPromoMessage,
      promoCategories: promoCategories ?? this.promoCategories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      searchProduct: searchProduct ?? this.searchProduct,
      searchProductController:
          searchProductController ?? this.searchProductController,
      // Tujuan
      tujuan: tujuan ?? this.tujuan,
      tujuanFocusNode: tujuanFocusNode ?? this.tujuanFocusNode,
      tujuanController: tujuanController ?? this.tujuanController,
      tujuanHasError: tujuanHasError ?? this.tujuanHasError,
      tujuanErrorMessage: tujuanErrorMessage ?? this.tujuanErrorMessage,
      // Cek Akun API
      apiCekAkunStatus: apiCekAkunStatus ?? this.apiCekAkunStatus,
      apiCekAkunMessage: apiCekAkunMessage ?? this.apiCekAkunMessage,
      cekAkunData: cekAkunData ?? this.cekAkunData,
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
    // Promo Products API
    apiFetchPromoStatus,
    apiFetchPromoMessage,
    promoCategories,
    selectedCategory,
    selectedProvider,
    selectedProduct,
    searchProduct,
    searchProductController,
    // Tujuan
    tujuan,
    tujuanFocusNode,
    tujuanController,
    tujuanHasError,
    tujuanErrorMessage,
    // Cek Akun API
    apiCekAkunStatus,
    apiCekAkunMessage,
    cekAkunData,
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

// Default values
final defaultPromoCategory = PromoProdukModel(
  data: [],
  kategoripromo: 0,
  namakategoripromo: '',
);

final defaultPromoProvider = ProviderPromoModel(
  idprovider: 0,
  namaprovider: '',
  data: [],
);

final defaultPromoProduct = ProdukPromoModel(
  idprodukpromo: 0,
  kategoripromo: 0,
  namakategoripromo: '',
  waktuberakhir: '',
  idprovider: 0,
  namaprovider: '',
  tipeinput: 0,
  mintujuan: 0,
  maxtujuan: 0,
  idproduk: 0,
  tipeproduk: 0,
  kodeproduk: '',
  namaproduk: '',
  deskripsiproduk: '',
  nominalproduk: 0,
  hargaproduk: 0,
  imgproduk: '',
  urutanproduk: 0,
  statusproduk: 0,
  kodeprodukcek: '',
);

// ============================================================
// CUBIT
// ============================================================
class MemberPromoProvider extends Cubit<MemberPromoState> {
  final PromoService _promoService = PromoService();

  MemberPromoProvider()
    : super(
        MemberPromoState(
          selectedCategory: defaultPromoCategory,
          selectedProvider: defaultPromoProvider,
          selectedProduct: defaultPromoProduct,
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
  Future<void> fetchPromoProducts() async {
    if (state.apiFetchPromoStatus.isLoading) return;

    emit(
      state.copyWith(
        apiFetchPromoStatus: ApiStatus.loading,
        apiFetchPromoMessage: '',
      ),
    );

    try {
      final result = await _promoService.getProdukPromo();
      if (!result.status) {
        emit(
          state.copyWith(
            apiFetchPromoStatus: ApiStatus.failure,
            apiFetchPromoMessage: result.message,
          ),
        );
        showWarningMessage(result.message);
        return;
      }
      final data = result.data;

      if (data != null && data.data.isNotEmpty) {
        final firstCategory = data.data.first;
        final firstProvider = firstCategory.data.isNotEmpty
            ? firstCategory.data.first
            : defaultPromoProvider;

        emit(
          state.copyWith(
            apiFetchPromoStatus: ApiStatus.success,
            promoCategories: data.data,
            selectedCategory: firstCategory,
            selectedProvider: firstProvider,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchPromoStatus: ApiStatus.failure,
            apiFetchPromoMessage: 'Data produk promo kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PROMO PRODUCTS: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchPromoStatus: ApiStatus.failure,
          apiFetchPromoMessage: e.message,
        ),
      );
    }
  }

  Future<void> cekAkun() async {
    if (state.selectedProduct.idprodukpromo == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    var valid = validateTujuan();
    if (!valid) return;

    if (state.apiCekAkunStatus.isLoading) return;

    emit(
      state.copyWith(
        apiCekAkunStatus: ApiStatus.loading,
        apiCekAkunMessage: '',
        cekAkunData: null,
      ),
    );

    try {
      var tujuan = TipeInput.fromValue(
        state.selectedProduct.tipeinput.toString(),
      ).filter(state.tujuan.trim());

      final result = await _promoService.cekAkun(
        kodeproduk: state.selectedProduct.kodeprodukcek,
        tujuan: tujuan,
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

      emit(
        state.copyWith(
          apiCekAkunStatus: ApiStatus.success,
          cekAkunData: result,
          totalPotongStok: result.data?.totaltagihan ?? 0,
          detailTransaksi: KeyValueResponse(
            items: result.dataSplit?.dataTransaksi ?? [],
          ),
          detailPotongStok: KeyValueResponse(
            items: result.dataSplit?.dataBiaya ?? [],
          ),
        ),
      );
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
  // KONFIRMASI METHODS
  // ============================================================
  void setNewKonfirmasi() async {
    if (state.selectedProduct.idprodukpromo == 0) {
      showWarningMessage('Produk tidak valid');
      return;
    }

    emit(state.copyWith(cekAkunData: null));

    if (state.selectedProduct.kodeprodukcek.isNotEmpty) {
      if (state.cekAkunData == null) {
        await cekAkun();
      } else {
        if (!checkTujuanMatchResult(
          state.detailTransaksi,
          state.tujuan.trim(),
        )) {
          await cekAkun();
        }
      }
    }

    var valid = validateTujuan();
    if (!valid) return;

    var dtlTransaksi = KeyValueResponse(items: []);

    debugPrint("JUMLAH DETAIL TRANSAKSI: ${dtlTransaksi.items.length}");

    dtlTransaksi.addItem(
      KeyValue(key: "Waktu", value: DateTime.now().formatReg()),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Nama Produk", value: state.selectedProduct.namaproduk),
    );
    dtlTransaksi.addItem(
      KeyValue(key: "Kode Produk", value: state.selectedProduct.kodeproduk),
    );

    debugPrint("JUMLAH DETAIL TRANSAKSI: ${dtlTransaksi.items.length}");
    if (state.cekAkunData != null) {
      var cekAkunRes = state.cekAkunData?.dataSplit?.dataTransaksi ?? [];

      for (var item in cekAkunRes) {
        dtlTransaksi.addItem(KeyValue(key: item.key, value: item.value));
      }
    } else {
      dtlTransaksi.addItem(KeyValue(key: "Tujuan", value: state.tujuan.trim()));
    }

    var dtlPotongStok = KeyValueResponse(items: []);
    int finalTotalPotongStok = 0;

    debugPrint("JUMLAH DETAIL POTONG STOK: ${dtlPotongStok.items.length}");

    if (state.cekAkunData != null && state.detailPotongStok.items.isNotEmpty) {
      for (var item in state.detailPotongStok.items) {
        dtlPotongStok.addItem(item);
      }
      finalTotalPotongStok = state.totalPotongStok;
    } else {
      dtlPotongStok.addItem(
        KeyValue(
          key: "Harga",
          value: ToRupiah(state.selectedProduct.hargaproduk.toString()),
        ),
      );
      dtlPotongStok.addItem(KeyValue(key: "Biaya Admin", value: "0"));
      finalTotalPotongStok = state.selectedProduct.hargaproduk;
    }

    emit(
      state.copyWith(
        totalPotongStok: finalTotalPotongStok,
        detailTransaksi: dtlTransaksi,
        detailPotongStok: dtlPotongStok,
      ),
    );

    pushNamed(MemberPromoKonfirmasiTransaksiPage.routeName, arguments: this);
  }

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

    KonfirmasiPinDialog.show<MemberPromoProvider, MemberPromoState>(
      context,
      // Title & Subtitle default
      title: 'Konfirmasi Transaksi Promo ${state.selectedProduct.namaproduk}',
      subtitle: 'Masukkan PIN untuk melanjutkan transaksi promo',
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
    if (state.selectedProduct.idprodukpromo == 0) {
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
      var tujuan = TipeInput.fromValue(
        state.selectedProduct.tipeinput.toString(),
      ).filter(state.tujuan.trim());
      var pintrx = TipeInput.numericOnly.filter(pin);

      final result = await _promoService.bayar(
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
  // SETTERS
  // ============================================================
  void setSelectedCategory(PromoProdukModel category) {
    emit(
      state.copyWith(
        selectedCategory: category,
        selectedProvider: defaultPromoProvider,
        selectedProduct: defaultPromoProduct,
      ),
    );
  }

  void setSelectedProvider(ProviderPromoModel provider) {
    emit(
      state.copyWith(
        selectedProvider: provider,
        selectedProduct: defaultPromoProduct,
      ),
    );
  }

  void setSelectedProduct(ProdukPromoModel product) {
    emit(state.copyWith(selectedProduct: product));
  }

  void setSearchProduct(String search, {bool updateController = false}) {
    emit(state.copyWith(searchProduct: search));
    if (updateController) {
      _updateController(state.searchProductController, search);
    }
  }

  void setTujuan(String value, {bool updateController = false}) {
    var val = value.trim();

    if (state.selectedProduct.idprodukpromo != 0) {
      val = TipeInput.fromValue(
        state.selectedProduct.tipeinput.toString(),
      ).filter(val);
    } else {
      val = TipeInput.numericOnly.filter(val);
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

  // ============================================================
  // RESET METHODS
  // ============================================================
  void resetState() {
    emit(
      MemberPromoState(
        selectedCategory: defaultPromoCategory,
        selectedProvider: defaultPromoProvider,
        selectedProduct: defaultPromoProduct,
        tujuanFocusNode: FocusNode(),
        tujuanController: TextEditingController(),
        searchProductController: TextEditingController(),
      ),
    );
  }

  void resetProduct() {
    emit(
      state.copyWith(
        selectedCategory: defaultPromoCategory,
        selectedProvider: defaultPromoProvider,
        selectedProduct: defaultPromoProduct,
        searchProduct: '',
        searchProductController: TextEditingController(),
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

  void resetTrxSebelumnya() {
    emit(
      state.copyWith(
        adaTrxSebelumnya: false,
        detailTrxSebelumnya: DEFAULT_KEY_VALUE_RESPONSE,
        trxke: 0,
      ),
    );
  }

  void resetCekAkun() {
    emit(
      state.copyWith(
        apiCekAkunStatus: ApiStatus.initial,
        apiCekAkunMessage: '',
        cekAkunData: null,
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
  String? _validateTujuanValue(String tujuan, ProdukPromoModel product) {
    if (tujuan.isEmpty) {
      return 'Tujuan tidak boleh kosong';
    }

    if (product.idprodukpromo == 0) return null;

    // Validasi panjang
    if (tujuan.length < product.mintujuan ||
        tujuan.length > product.maxtujuan) {
      return 'Panjang tujuan harus antara ${product.mintujuan} hingga ${product.maxtujuan} karakter';
    }

    // Validasi tipe input
    final tipeInput = TipeInput.fromValue(product.tipeinput.toString());
    if (!tipeInput.isValid(tujuan)) {
      return tipeInput.errorMessage;
    }

    return null;
  }
}

MemberPromoProvider getMemberPromoProvider(BuildContext context) =>
    context.read<MemberPromoProvider>();
