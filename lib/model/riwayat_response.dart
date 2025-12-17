import 'package:dmpku/core/enums/status_trx.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';

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


