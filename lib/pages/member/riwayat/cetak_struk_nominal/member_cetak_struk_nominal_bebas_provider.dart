import 'package:dmpku/core/helpers/printer_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberCetakStrukNominalBebasState extends Equatable {
  final List<KeyValue> dataTrx;
  final List<KeyValue> dataTrxTemp;
  final List<KeyValue> dataBiaya;
  final List<KeyValue> dataBiayaTemp;
  final String totalBayar;

  final int harga;
  final int hargaTemp;
  final String hargaFormat;
  final TextEditingController? hargaController;

  final int admin;
  final int adminTemp;
  final String adminFormat;
  final TextEditingController? adminController;

  final String namaKios;
  final String alamatKios;
  final String footerKios;

  final String titleSn;
  final String sn;

  final DetailTransaksiModel detailTransaksi;

  const MemberCetakStrukNominalBebasState({
    this.dataTrx = const [],
    this.dataBiaya = const [],
    this.dataTrxTemp = const [],
    this.dataBiayaTemp = const [],
    this.totalBayar = '',
    this.harga = 0,
    this.hargaTemp = 0,
    this.hargaFormat = '',
    this.hargaController,
    this.admin = 0,
    this.adminTemp = 0,
    this.adminFormat = '',
    this.adminController,
    this.namaKios = '',
    this.alamatKios = '',
    this.footerKios = '',
    this.titleSn = '',
    this.sn = '',
    this.detailTransaksi = DEFAULT_DETAIL_TRANSAKSI_MODEL,
  });

  MemberCetakStrukNominalBebasState copyWith({
    List<KeyValue>? dataTrx,
    List<KeyValue>? dataBiaya,
    List<KeyValue>? dataTrxTemp,
    List<KeyValue>? dataBiayaTemp,
    String? totalBayar,
    int? harga,
    int? hargaTemp,
    String? hargaFormat,
    TextEditingController? hargaController,
    int? admin,
    int? adminTemp,
    String? adminFormat,
    TextEditingController? adminController,
    String? namaKios,
    String? alamatKios,
    String? footerKios,
    String? titleSn,
    String? sn,
    DetailTransaksiModel? detailTransaksi,
  }) {
    return MemberCetakStrukNominalBebasState(
      dataTrx: dataTrx ?? this.dataTrx,
      dataBiaya: dataBiaya ?? this.dataBiaya,
      dataTrxTemp: dataTrxTemp ?? this.dataTrxTemp,
      dataBiayaTemp: dataBiayaTemp ?? this.dataBiayaTemp,
      totalBayar: totalBayar ?? this.totalBayar,
      harga: harga ?? this.harga,
      hargaTemp: hargaTemp ?? this.hargaTemp,
      hargaFormat: hargaFormat ?? this.hargaFormat,
      hargaController: hargaController ?? this.hargaController,
      admin: admin ?? this.admin,
      adminTemp: adminTemp ?? this.adminTemp,
      adminFormat: adminFormat ?? this.adminFormat,
      adminController: adminController ?? this.adminController,
      namaKios: namaKios ?? this.namaKios,
      alamatKios: alamatKios ?? this.alamatKios,
      footerKios: footerKios ?? this.footerKios,
      titleSn: titleSn ?? this.titleSn,
      sn: sn ?? this.sn,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi
    );
  }

  @override
  List<Object?> get props => [
    dataTrx,
    dataBiaya,
    dataTrxTemp,
    dataBiayaTemp,
    totalBayar,
    harga,
    hargaTemp,
    hargaFormat,
    hargaController,
    admin,
    adminTemp,
    adminFormat,
    adminController,
    namaKios,
    alamatKios,
    footerKios,
    titleSn,
    sn,
    detailTransaksi,
  ];
}

class MemberCetakStrukNominalBebasProvider
    extends Cubit<MemberCetakStrukNominalBebasState> {
  MemberCetakStrukNominalBebasProvider()
    : super(
        MemberCetakStrukNominalBebasState(
          hargaController: TextEditingController(),
          adminController: TextEditingController(),
        ),
      );

  @override
  Future<void> close() {
    state.hargaController?.dispose();
    state.adminController?.dispose();
    return super.close();
  }

  void setDataTrx(List<KeyValue> dataTrx, {bool ubahTemp = false}) {
    List<KeyValue> dtTrx = [];

    for (var item in dataTrx) {
      var keyLower = item.key.toString().toLowerCase();
      keyLower = keyLower.replaceAll(' ', '');
      keyLower = removeNonAlphanumeric(keyLower);

      if (keyLower == keyTkn) {
        emit(state.copyWith(titleSn: "**TOKEN**", sn: item.value.toString()));
      } else if (keyLower == keyVoucher) {
        emit(state.copyWith(titleSn: "**VOUCHER**", sn: item.value.toString()));
      } else if (keyLower == keyRef) {
        emit(state.copyWith(titleSn: "**REF**", sn: item.value.toString()));
      }

      if (keyDtlTransaksiExcluded.contains(keyLower)) {
        continue;
      }

      dtTrx.add(item);
    }

    emit(state.copyWith(dataTrx: dtTrx));

    if (ubahTemp) {
      emit(state.copyWith(dataTrxTemp: dtTrx));
    }
  }

  void setDataBiaya(List<KeyValue> dataBiaya, {bool ubahTemp = false}) {
    List<KeyValue> dtTrx = [];

    for (var item in dataBiaya) {
      var keyLower = item.key.toString().toLowerCase();
      keyLower = keyLower.replaceAll(' ', '');
      keyLower = removeNonAlphanumeric(keyLower);

      if (keyLower == "nominal") {
        var hargaFmt = FromCurrency(item.value.toString());
        emit(state.copyWith(harga: hargaFmt, hargaTemp: hargaFmt));
      }

      if (keyLower == "admin") {
        var adminFmt = FromCurrency(item.value.toString());
        emit(state.copyWith(admin: adminFmt, adminTemp: adminFmt));
      }

      if (keyDtlPembayaranExcluded.contains(keyLower)) {
        continue;
      }

      item = item.copyWith(value: ToCurrency(item.value.toString()));
      dtTrx.add(item);
    }

    emit(state.copyWith(dataBiaya: dtTrx));

    if (ubahTemp) {
      emit(state.copyWith(dataTrxTemp: dtTrx));
    }
  }

  void setTotalBayar(String totalBayar) {
    emit(
      state.copyWith(
        totalBayar: totalBayar,
        harga: FromCurrency(totalBayar),
        hargaTemp: FromCurrency(totalBayar),
        adminTemp: 0,
      ),
    );
  }

  void setHarga(String harga) {
    int hargaInt = FromCurrency(harga);
    String hargaFmt = ToCurrency(harga);

    _updateController(state.hargaController, hargaFmt);

    emit(state.copyWith(harga: hargaInt, hargaFormat: hargaFmt));

    var adminInt = state.admin;
    var totalBayarInt = hargaInt + adminInt;
    var totalBayarFmt = ToCurrency(totalBayarInt.toString());

    emit(state.copyWith(totalBayar: totalBayarFmt));
  }

  void setAdmin(String admin) {
    int adminInt = FromCurrency(admin);
    String adminFmt = ToCurrency(admin);

    _updateController(state.adminController, adminFmt);

    emit(state.copyWith(admin: adminInt, adminFormat: adminFmt));

    var hargaInt = state.harga;
    var totalBayarInt = hargaInt + adminInt;
    var totalBayarFmt = ToCurrency(totalBayarInt.toString());

    emit(state.copyWith(totalBayar: totalBayarFmt));
  }

  void setDetailTransaksi(DetailTransaksiModel detailTransaksi) {
    emit(state.copyWith(detailTransaksi: detailTransaksi));
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  void reloadKiosInfo() async {
    var namaKi = await SecureStorageHelper.instance.getNamaKios() ?? '';
    var alamatKi = await SecureStorageHelper.instance.getAlamatKios() ?? '';
    var footerKi = await SecureStorageHelper.instance.getFooterKios() ?? '';

    emit(
      state.copyWith(
        namaKios: namaKi,
        alamatKios: alamatKi,
        footerKios: footerKi,
      ),
    );
  }

  void saveKiosInfo({
    required String namaKios,
    required String alamatKios,
    required String footerKios,
  }) async {
    await SecureStorageHelper.instance.saveNamaKios(namaKios);
    await SecureStorageHelper.instance.saveAlamatKios(alamatKios);
    await SecureStorageHelper.instance.saveFooterKios(footerKios);

    emit(
      state.copyWith(
        namaKios: namaKios,
        alamatKios: alamatKios,
        footerKios: footerKios,
      ),
    );
  }

  void resetState() {
    emit(
      MemberCetakStrukNominalBebasState(
        hargaController: TextEditingController(),
        adminController: TextEditingController(),
      ),
    );
  }
}

MemberCetakStrukNominalBebasProvider getMemberCetakStrukNominalBebasProvider(
  BuildContext context,
) => context.read<MemberCetakStrukNominalBebasProvider>();
