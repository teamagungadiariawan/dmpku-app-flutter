import 'package:dmpku/core/enums/status_trx.dart';
import 'package:dmpku/core/enums/tipe_trx.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/model/cek_tagihan_response.dart';

class RiwayatModel {
  final int idtransaksiprod;
  final String waktutrx;
  final String kodeproduk;
  final String namaproduk;
  final String imgproduk;
  final int status;
  final String tujuan;
  final int jenistrx;
  final int totalharga;

  const RiwayatModel({
    required this.idtransaksiprod,
    required this.waktutrx,
    required this.kodeproduk,
    required this.namaproduk,
    required this.imgproduk,
    required this.status,
    required this.tujuan,
    required this.jenistrx,
    required this.totalharga,
  });

  factory RiwayatModel.fromJson(Map<String, dynamic>? json) {
    return RiwayatModel(
      idtransaksiprod: json?['idtransaksiprod'] ?? 0,
      waktutrx: json?['waktutrx'] ?? '',
      kodeproduk: json?['kodeproduk'] ?? '',
      namaproduk: json?['namaproduk'] ?? '',
      imgproduk: json?['imgproduk'] ?? '',
      status: json?['status'] ?? 0,
      tujuan: json?['tujuan'] ?? '',
      jenistrx: json?['jenistrx'] ?? 0,
      totalharga: json?['totalharga'] ?? 0,
    );
  }

  RiwayatModel copyWith({
    int? idtransaksiprod,
    String? waktutrx,
    String? kodeproduk,
    String? namaproduk,
    String? imgproduk,
    int? status,
    String? tujuan,
    int? jenistrx,
    int? totalharga,
  }) {
    return RiwayatModel(
      idtransaksiprod: idtransaksiprod ?? this.idtransaksiprod,
      waktutrx: waktutrx ?? this.waktutrx,
      kodeproduk: kodeproduk ?? this.kodeproduk,
      namaproduk: namaproduk ?? this.namaproduk,
      imgproduk: imgproduk ?? this.imgproduk,
      status: status ?? this.status,
      tujuan: tujuan ?? this.tujuan,
      jenistrx: jenistrx ?? this.jenistrx,
      totalharga: totalharga ?? this.totalharga,
    );
  }

  String get totalHargaFormatted => ToCurrency(totalharga.toString());

  TrxStatus get statusTrx => TrxStatus.fromId(status);

  @override
  String toString() {
    return 'RiwayatModel(idtransaksiprod: $idtransaksiprod, waktutrx: $waktutrx, kodeproduk: $kodeproduk, namaproduk: $namaproduk, imgproduk: $imgproduk, status: $status, tujuan: $tujuan, jenistrx: $jenistrx, totalharga: $totalharga)';
  }
}

class ListRiwayatResponse {
  final List<RiwayatModel> riwayatList;

  const ListRiwayatResponse({required this.riwayatList});

  factory ListRiwayatResponse.fromJson(List<dynamic>? json) {
    return ListRiwayatResponse(
      riwayatList: json != null
          ? json.map((e) => RiwayatModel.fromJson(e)).toList()
          : [],
    );
  }

  @override
  String toString() {
    return 'ListRiwayatResponse(riwayatList: $riwayatList)';
  }
}

const RiwayatModel DEFAULT_RIWAYAT_MODEL = RiwayatModel(
  idtransaksiprod: 0,
  waktutrx: '',
  kodeproduk: '',
  namaproduk: '',
  imgproduk: '',
  status: 0,
  tujuan: '',
  jenistrx: 0,
  totalharga: 0,
);

class GroupedRiwayatModel {
  final String tanggal;
  final List<RiwayatModel> riwayatList;

  const GroupedRiwayatModel({required this.tanggal, required this.riwayatList});

  @override
  String toString() {
    return 'GroupedRiwayatModel(tanggal: $tanggal, riwayatList: $riwayatList)';
  }
}

class ListGroupedRiwayatResponse {
  final List<GroupedRiwayatModel> groupedRiwayatList;

  const ListGroupedRiwayatResponse({required this.groupedRiwayatList});

  factory ListGroupedRiwayatResponse.fromListRiwayatResponse(
    ListRiwayatResponse listRiwayatResponse,
  ) {
    final Map<String, List<RiwayatModel>> groupedMap = {};

    for (var riwayat in listRiwayatResponse.riwayatList) {
      final dtime = DateTime.parse(riwayat.waktutrx);
      final tanggal = DateHelper.formatSimpleDate(dtime);

      if (!groupedMap.containsKey(tanggal)) {
        groupedMap[tanggal] = [];
      }
      groupedMap[tanggal]!.add(riwayat);
    }

    final List<GroupedRiwayatModel> groupedList = groupedMap.entries
        .map(
          (entry) =>
              GroupedRiwayatModel(tanggal: entry.key, riwayatList: entry.value),
        )
        .toList();

    return ListGroupedRiwayatResponse(groupedRiwayatList: groupedList);
  }

  @override
  String toString() {
    return 'ListGroupedRiwayatResponse(groupedRiwayatList: $groupedRiwayatList)';
  }
}

const ListGroupedRiwayatResponse DEFAULT_LIST_GROUPED_RIWAYAT_RESPONSE =
    ListGroupedRiwayatResponse(groupedRiwayatList: []);

class MutasiSaldoModel {
  final String waktu_mutasi;
  final String keterangan;
  final int mutasi;
  final int saldo;

  const MutasiSaldoModel({
    required this.waktu_mutasi,
    required this.keterangan,
    required this.mutasi,
    required this.saldo,
  });

  factory MutasiSaldoModel.fromJson(Map<String, dynamic>? json) {
    return MutasiSaldoModel(
      waktu_mutasi: json?['waktu_mutasi'] ?? '',
      keterangan: json?['keterangan'] ?? '',
      mutasi: json?['mutasi'] ?? 0,
      saldo: json?['saldo'] ?? 0,
    );
  }

  MutasiSaldoModel copyWith({
    String? waktu_mutasi,
    String? keterangan,
    int? mutasi,
    int? saldo,
  }) {
    return MutasiSaldoModel(
      waktu_mutasi: waktu_mutasi ?? this.waktu_mutasi,
      keterangan: keterangan ?? this.keterangan,
      mutasi: mutasi ?? this.mutasi,
      saldo: saldo ?? this.saldo,
    );
  }

  String get mutasiFormatted => ToCurrency(mutasi.toString());

  String get saldoFormatted => ToCurrency(saldo.toString());

  DateTime get waktuMutasi => DateTime.parse(waktu_mutasi);

  @override
  String toString() {
    return 'MutasiSaldoModel(waktu_mutasi: $waktu_mutasi, keterangan: $keterangan, mutasi: $mutasi, saldo: $saldo)';
  }
}

class ListMutasiSaldoResponse {
  final List<MutasiSaldoModel> mutasiSaldoList;

  const ListMutasiSaldoResponse({required this.mutasiSaldoList});

  factory ListMutasiSaldoResponse.fromJson(List<dynamic>? json) {
    return ListMutasiSaldoResponse(
      mutasiSaldoList: json != null
          ? json.map((e) => MutasiSaldoModel.fromJson(e)).toList()
          : [],
    );
  }

  @override
  String toString() {
    return 'ListMutasiSaldoResponse(mutasiSaldoList: $mutasiSaldoList)';
  }
}

const MutasiSaldoModel DEFAULT_MUTASI_SALDO_MODEL = MutasiSaldoModel(
  waktu_mutasi: '',
  keterangan: '',
  mutasi: 0,
  saldo: 0,
);

class RekapTransaksiModel {
  final String kodeproduk;
  final String namaproduk;
  final int jumlahtrx;
  final int totaldebet;

  const RekapTransaksiModel({
    required this.kodeproduk,
    required this.namaproduk,
    required this.jumlahtrx,
    required this.totaldebet,
  });

  factory RekapTransaksiModel.fromJson(Map<String, dynamic>? json) {
    return RekapTransaksiModel(
      kodeproduk: json?['kodeproduk'] ?? '',
      namaproduk: json?['namaproduk'] ?? '',
      jumlahtrx: json?['jumlahtrx'] ?? 0,
      totaldebet: json?['totaldebet'] ?? 0,
    );
  }

  RekapTransaksiModel copyWith({
    String? kodeproduk,
    String? namaproduk,
    int? jumlahtrx,
    int? totaldebet,
  }) {
    return RekapTransaksiModel(
      kodeproduk: kodeproduk ?? this.kodeproduk,
      namaproduk: namaproduk ?? this.namaproduk,
      jumlahtrx: jumlahtrx ?? this.jumlahtrx,
      totaldebet: totaldebet ?? this.totaldebet,
    );
  }

  String get totalDebetFormatted => ToCurrency(totaldebet.toString());

  String get jumlahTrxFormatted => ToCurrency(jumlahtrx.toString());

  @override
  String toString() {
    return 'RekapTransaksiModel(kodeproduk: $kodeproduk, namaproduk: $namaproduk, jumlahtrx: $jumlahtrx, totaldebet: $totaldebet)';
  }
}

class ListRekapTransaksiResponse {
  final List<RekapTransaksiModel> rekapTransaksiList;

  const ListRekapTransaksiResponse({required this.rekapTransaksiList});

  factory ListRekapTransaksiResponse.fromJson(List<dynamic>? json) {
    return ListRekapTransaksiResponse(
      rekapTransaksiList: json != null
          ? json.map((e) => RekapTransaksiModel.fromJson(e)).toList()
          : [],
    );
  }

  @override
  String toString() {
    return 'ListRekapTransaksiResponse(rekapTransaksiList: $rekapTransaksiList)';
  }
}

const RekapTransaksiModel DEFAULT_REKAP_TRANSAKSI_MODEL = RekapTransaksiModel(
  kodeproduk: '',
  namaproduk: '',
  jumlahtrx: 0,
  totaldebet: 0,
);

class DetailTransaksiModel {
  final int idtransaksiprod;
  final String waktutrx;
  final String kodeproduk;
  final String namaproduk;
  final String keteranganproduk;
  final String imgproduk;
  final int status;
  final String tujuan;
  final String tujuantambahan;
  final int jenistrx;
  final int nominaltrx;
  final int totaltagihan;
  final int feeppob;
  final int potongansaldotagihan;
  final int totalharga;
  final String sn;
  final String datatrx;

  const DetailTransaksiModel({
    required this.idtransaksiprod,
    required this.waktutrx,
    required this.kodeproduk,
    required this.namaproduk,
    required this.keteranganproduk,
    required this.imgproduk,
    required this.status,
    required this.tujuan,
    required this.tujuantambahan,
    required this.jenistrx,
    required this.nominaltrx,
    required this.totaltagihan,
    required this.feeppob,
    required this.potongansaldotagihan,
    required this.totalharga,
    required this.sn,
    required this.datatrx,
  });

  factory DetailTransaksiModel.fromJson(Map<String, dynamic>? json) {
    return DetailTransaksiModel(
      idtransaksiprod: json?['idtransaksiprod'] ?? 0,
      waktutrx: json?['waktutrx'] ?? '',
      kodeproduk: json?['kodeproduk'] ?? '',
      namaproduk: json?['namaproduk'] ?? '',
      keteranganproduk: json?['keteranganproduk'] ?? '',
      imgproduk: json?['imgproduk'] ?? '',
      status: json?['status'] ?? 0,
      tujuan: json?['tujuan'] ?? '',
      tujuantambahan: json?['tujuantambahan'] ?? '',
      jenistrx: json?['jenistrx'] ?? 0,
      nominaltrx: json?['nominaltrx'] ?? 0,
      totaltagihan: json?['totaltagihan'] ?? 0,
      feeppob: json?['feeppob'] ?? 0,
      potongansaldotagihan: json?['potongansaldotagihan'] ?? 0,
      totalharga: json?['totalharga'] ?? 0,
      sn: json?['sn'] ?? '',
      datatrx: json?['datatrx'] ?? '',
    );
  }

  DetailTransaksiModel copyWith({
    int? idtransaksiprod,
    String? waktutrx,
    String? kodeproduk,
    String? namaproduk,
    String? keteranganproduk,
    String? imgproduk,
    int? status,
    String? tujuan,
    String? tujuantambahan,
    int? jenistrx,
    int? nominaltrx,
    int? totaltagihan,
    int? feeppob,
    int? potongansaldotagihan,
    int? totalharga,
    String? sn,
    String? datatrx,
  }) {
    return DetailTransaksiModel(
      idtransaksiprod: idtransaksiprod ?? this.idtransaksiprod,
      waktutrx: waktutrx ?? this.waktutrx,
      kodeproduk: kodeproduk ?? this.kodeproduk,
      namaproduk: namaproduk ?? this.namaproduk,
      keteranganproduk: keteranganproduk ?? this.keteranganproduk,
      imgproduk: imgproduk ?? this.imgproduk,
      status: status ?? this.status,
      tujuan: tujuan ?? this.tujuan,
      tujuantambahan: tujuantambahan ?? this.tujuantambahan,
      jenistrx: jenistrx ?? this.jenistrx,
      nominaltrx: nominaltrx ?? this.nominaltrx,
      totaltagihan: totaltagihan ?? this.totaltagihan,
      feeppob: feeppob ?? this.feeppob,
      potongansaldotagihan: potongansaldotagihan ?? this.potongansaldotagihan,
      totalharga: totalharga ?? this.totalharga,
      sn: sn ?? this.sn,
      datatrx: datatrx ?? this.datatrx,
    );
  }

  TipeTrx get tipeTrx => TipeTrx.fromValue(jenistrx) ?? TipeTrx.elektrik;

  TrxStatus get statusTrx => TrxStatus.fromId(status);

  String get nominalTrxFormatted => ToCurrency(nominaltrx.toString());

  String get totalHargaFormatted => ToCurrency(totalharga.toString());

  String get totalTagihanFormatted => ToCurrency(totaltagihan.toString());

  String get feePpobFormatted => ToCurrency(feeppob.toString());

  String get potonganSaldoTagihanFormatted =>
      ToCurrency(potongansaldotagihan.toString());

  DateTime get waktuTrx => DateTime.parse(waktutrx);

  @override
  String toString() {
    return 'DetailTransaksiModel(idtransaksiprod: $idtransaksiprod, waktutrx: $waktutrx, kodeproduk: $kodeproduk, namaproduk: $namaproduk, keteranganproduk: $keteranganproduk, imgproduk: $imgproduk, status: $status, tujuan: $tujuan, tujuantambahan: $tujuantambahan, jenistrx: $jenistrx, nominaltrx: $nominaltrx, totaltagihan: $totaltagihan, feeppob: $feeppob, potongansaldotagihan: $potongansaldotagihan, totalharga: $totalharga, sn: $sn, datatrx: $datatrx)';
  }
}

const DetailTransaksiModel DEFAULT_DETAIL_TRANSAKSI_MODEL =
    DetailTransaksiModel(
      idtransaksiprod: 0,
      waktutrx: '',
      kodeproduk: '',
      namaproduk: '',
      keteranganproduk: '',
      imgproduk: '',
      status: 0,
      tujuan: '',
      tujuantambahan: '',
      jenistrx: 0,
      nominaltrx: 0,
      totaltagihan: 0,
      feeppob: 0,
      potongansaldotagihan: 0,
      totalharga: 0,
      sn: '',
      datatrx: '',
    );

class DetailTransaksiResponse {
  final String message;
  final bool status;
  final DataSplit? dataSplit;
  final DetailTransaksiModel? data;

  const DetailTransaksiResponse({
    required this.message,
    required this.status,
    required this.dataSplit,
    required this.data,
  });

  factory DetailTransaksiResponse.fromJson(Map<String, dynamic>? json) {
    return DetailTransaksiResponse(
      message: json?['message'] ?? '',
      status: json?['status'] ?? false,
      dataSplit: DataSplit.fromJson(json?['dataSplit']),
      data: DetailTransaksiModel.fromJson(json?['data']),
    );
  }

  @override
  String toString() {
    return 'DetailTransaksiResponse(message: $message, status: $status, dataSplit: $dataSplit, data: $data)';
  }
}
