import 'package:dmpku/core/helpers/printer_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberCetakStrukPpob2State extends Equatable {
  final List<KeyValue> dataTrx;
  final List<KeyValue> dataTrxTemp;
  final List<KeyValue> dataBiaya;
  final List<KeyValue> dataBiayaTemp;

  final int tagihanAwal;
  final int denda;
  final int totalTagihan;
  final int totalBayar;
  final int fee;

  final int admin;
  final int adminTemp;

  final String namaKios;
  final String alamatKios;
  final String footerKios;

  final String titleSn;
  final String sn;

  final int totalPotongStok;

  final DetailTransaksiModel detailTransaksi;

  const MemberCetakStrukPpob2State({
    this.dataTrx = const [],
    this.dataBiaya = const [],
    this.dataTrxTemp = const [],
    this.dataBiayaTemp = const [],
    this.tagihanAwal = 0,
    this.denda = 0,
    this.totalTagihan = 0,
    this.totalBayar = 0,
    this.fee = 0,
    this.admin = 0,
    this.adminTemp = 0,
    this.namaKios = '',
    this.alamatKios = '',
    this.footerKios = '',
    this.titleSn = '',
    this.sn = '',
    this.totalPotongStok = 0,
    this.detailTransaksi = DEFAULT_DETAIL_TRANSAKSI_MODEL,
  });

  MemberCetakStrukPpob2State copyWith({
    List<KeyValue>? dataTrx,
    List<KeyValue>? dataBiaya,
    List<KeyValue>? dataTrxTemp,
    List<KeyValue>? dataBiayaTemp,
    int? tagihanAwal,
    int? denda,
    int? totalTagihan,
    int? totalBayar,
    int? fee,
    int? admin,
    int? adminTemp,
    String? namaKios,
    String? alamatKios,
    String? footerKios,
    String? titleSn,
    String? sn,
    int? totalPotongStok,
    DetailTransaksiModel? detailTransaksi,
  }) {
    return MemberCetakStrukPpob2State(
      dataTrx: dataTrx ?? this.dataTrx,
      dataBiaya: dataBiaya ?? this.dataBiaya,
      dataTrxTemp: dataTrxTemp ?? this.dataTrxTemp,
      dataBiayaTemp: dataBiayaTemp ?? this.dataBiayaTemp,
      tagihanAwal: tagihanAwal ?? this.tagihanAwal,
      denda: denda ?? this.denda,
      totalTagihan: totalTagihan ?? this.totalTagihan,
      totalBayar: totalBayar ?? this.totalBayar,
      fee: fee ?? this.fee,
      admin: admin ?? this.admin,
      adminTemp: adminTemp ?? this.adminTemp,
      namaKios: namaKios ?? this.namaKios,
      alamatKios: alamatKios ?? this.alamatKios,
      footerKios: footerKios ?? this.footerKios,
      titleSn: titleSn ?? this.titleSn,
      sn: sn ?? this.sn,
      totalPotongStok: totalPotongStok ?? this.totalPotongStok,
      detailTransaksi: detailTransaksi ?? this.detailTransaksi,
    );
  }

  @override
  List<Object?> get props => [
    dataTrx,
    dataBiaya,
    dataTrxTemp,
    dataBiayaTemp,
    tagihanAwal,
    denda,
    totalTagihan,
    totalBayar,
    fee,
    admin,
    adminTemp,
    namaKios,
    alamatKios,
    footerKios,
    titleSn,
    sn,
    totalPotongStok,
    detailTransaksi,
  ];
}

class MemberCetakStrukPpob2Provider extends Cubit<MemberCetakStrukPpob2State> {
  MemberCetakStrukPpob2Provider() : super(const MemberCetakStrukPpob2State());

  void resetState() {
    emit(const MemberCetakStrukPpob2State());
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

      if (ubahTemp) {
        switch (keyLower) {
          case "tagihanawal":
            emit(
              state.copyWith(
                tagihanAwal: int.tryParse(item.value.toString()) ?? 0,
              ),
            );
            break;
          case "admin":
            emit(
              state.copyWith(
                admin: int.tryParse(item.value.toString()) ?? 0,
                adminTemp: int.tryParse(item.value.toString()) ?? 0,
              ),
            );
            break;
          case "denda":
            emit(
              state.copyWith(denda: int.tryParse(item.value.toString()) ?? 0),
            );
            break;
          case "totaltagihan":
            emit(
              state.copyWith(
                totalTagihan: int.tryParse(item.value.toString()) ?? 0,
              ),
            );
            break;
          case "fee":
            emit(state.copyWith(fee: int.tryParse(item.value.toString()) ?? 0));
            break;
        }
      }

      if (keyDtlPembayaranExcluded.contains(keyLower)) {
        continue;
      }

      item = item.copyWith(value: ToCurrency(item.value.toString()));
      dtTrx.add(item);
    }

    debugPrint("setDataBiaya: totalBayar=${state.totalBayar}");
    debugPrint("setDataBiaya: tagihanAwal=${state.tagihanAwal}");
    debugPrint("setDataBiaya: admin=${state.admin}");
    debugPrint("setDataBiaya: denda=${state.denda}");
    int totalBayar = state.tagihanAwal + state.admin + state.denda;
    emit(state.copyWith(totalBayar: totalBayar));
    debugPrint("setDataBiaya: totalBayar updated=${state.totalBayar}");

    emit(state.copyWith(dataBiaya: dtTrx));

    if (ubahTemp) {
      emit(state.copyWith(dataTrxTemp: dtTrx));
    }
  }

  void setAdmin(int admin) {
    emit(state.copyWith(admin: admin, adminTemp: admin));
  }

  void setTotalPotongStok(int totalPotongStok) {
    emit(state.copyWith(totalPotongStok: totalPotongStok));
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

  void setDetailTransaksi(DetailTransaksiModel detailTransaksi) {
    emit(state.copyWith(detailTransaksi: detailTransaksi));
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
}

MemberCetakStrukPpob2Provider getMemberCetakStrukPpob2Provider(
  BuildContext context,
) {
  return context.read<MemberCetakStrukPpob2Provider>();
}
