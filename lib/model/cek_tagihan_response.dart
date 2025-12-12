import 'package:flutter/cupertino.dart';

import 'key_value_response.dart';

class DataSplit {
  final List<KeyValue>? dataTransaksi;
  final List<KeyValue>? dataBiaya;

  const DataSplit({required this.dataTransaksi, required this.dataBiaya});

  factory DataSplit.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const DataSplit(dataTransaksi: [], dataBiaya: []);
    }
    return DataSplit(
      dataTransaksi:
          (json['data_transaksi'] as List<dynamic>?)
              ?.map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      dataBiaya:
          (json['data_biaya'] as List<dynamic>?)
              ?.map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'data_transaksi': dataTransaksi?.map((e) => e.toJson()).toList(),
    'data_biaya': dataBiaya?.map((e) => e.toJson()).toList(),
  };

  DataSplit copyWith({
    List<KeyValue>? dataTransaksi,
    List<KeyValue>? dataBiaya,
  }) {
    return DataSplit(
      dataTransaksi: dataTransaksi ?? this.dataTransaksi,
      dataBiaya: dataBiaya ?? this.dataBiaya,
    );
  }
}

class TransaksiData {
  final int idpesandikirim;
  final String waktu;
  final String tujuanpesan;
  final String isipesan;
  final int statuspesan;
  final int idtransaksiprod;
  final String kodemember;
  final String namamember;
  final String idtrxmitra;
  final String kodeproduk;
  final String namaproduk;
  final String keteranganproduk;
  final int idprovider;
  final String tujuantrx;
  final String tujuantambahantrx;
  final int totalharga;
  final int jumlahtagihan;
  final int potongsaldotagihan;
  final int statustrx;
  final String sn;
  final int feeppob;
  final int totaltagihan;
  final String kodebayar;
  final int jenistrx;
  final String datatrx;
  final int saldoawal;
  final int saldoakhir;
  final String terminal;
  final int trxke;
  final int tipesender;

  const TransaksiData({
    required this.idpesandikirim,
    required this.waktu,
    required this.tujuanpesan,
    required this.isipesan,
    required this.statuspesan,
    required this.idtransaksiprod,
    required this.kodemember,
    required this.namamember,
    required this.idtrxmitra,
    required this.kodeproduk,
    required this.namaproduk,
    required this.keteranganproduk,
    required this.idprovider,
    required this.tujuantrx,
    required this.tujuantambahantrx,
    required this.totalharga,
    required this.jumlahtagihan,
    required this.potongsaldotagihan,
    required this.statustrx,
    required this.sn,
    required this.feeppob,
    required this.totaltagihan,
    required this.kodebayar,
    required this.jenistrx,
    required this.datatrx,
    required this.saldoawal,
    required this.saldoakhir,
    required this.terminal,
    required this.trxke,
    required this.tipesender,
  });

  factory TransaksiData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DEFAULT_TRANSAKSI_DATA_RESPONSE;
    return TransaksiData(
      idpesandikirim: json['idpesandikirim'] ?? 0,
      waktu: json['waktu'] ?? '',
      tujuanpesan: json['tujuanpesan'] ?? '',
      isipesan: json['isipesan'] ?? '',
      statuspesan: json['statuspesan'] ?? 0,
      idtransaksiprod: json['idtransaksiprod'] ?? 0,
      kodemember: json['kodemember'] ?? '',
      namamember: json['namamember'] ?? '',
      idtrxmitra: json['idtrxmitra'] ?? '',
      kodeproduk: json['kodeproduk'] ?? '',
      namaproduk: json['namaproduk'] ?? '',
      keteranganproduk: json['keteranganproduk'] ?? '',
      idprovider: json['idprovider'] ?? 0,
      tujuantrx: json['tujuantrx'] ?? '',
      tujuantambahantrx: json['tujuantambahantrx'] ?? '',
      totalharga: json['totalharga'] ?? 0,
      jumlahtagihan: json['jumlahtagihan'] ?? 0,
      potongsaldotagihan: json['potongsaldotagihan'] ?? 0,
      statustrx: json['statustrx'] ?? 0,
      sn: json['sn'] ?? '',
      feeppob: json['feeppob'] ?? 0,
      totaltagihan: json['totaltagihan'] ?? 0,
      kodebayar: json['kodebayar'] ?? '',
      jenistrx: json['jenistrx'] ?? 0,
      datatrx: json['datatrx'] ?? '',
      saldoawal: json['saldoawal'] ?? 0,
      saldoakhir: json['saldoakhir'] ?? 0,
      terminal: json['terminal'] ?? '',
      trxke: json['trxke'] ?? 0,
      tipesender: json['tipesender'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'idpesandikirim': idpesandikirim,
    'waktu': waktu,
    'tujuanpesan': tujuanpesan,
    'isipesan': isipesan,
    'statuspesan': statuspesan,
    'idtransaksiprod': idtransaksiprod,
    'kodemember': kodemember,
    'namamember': namamember,
    'idtrxmitra': idtrxmitra,
    'kodeproduk': kodeproduk,
    'namaproduk': namaproduk,
    'keteranganproduk': keteranganproduk,
    'idprovider': idprovider,
    'tujuantrx': tujuantrx,
    'tujuantambahantrx': tujuantambahantrx,
    'totalharga': totalharga,
    'jumlahtagihan': jumlahtagihan,
    'potongsaldotagihan': potongsaldotagihan,
    'statustrx': statustrx,
    'sn': sn,
    'feeppob': feeppob,
    'totaltagihan': totaltagihan,
    'kodebayar': kodebayar,
    'jenistrx': jenistrx,
    'datatrx': datatrx,
    'saldoawal': saldoawal,
    'saldoakhir': saldoakhir,
    'terminal': terminal,
    'trxke': trxke,
    'tipesender': tipesender,
  };

  TransaksiData copyWith({
    int? idpesandikirim,
    String? waktu,
    String? tujuanpesan,
    String? isipesan,
    int? statuspesan,
    int? idtransaksiprod,
    String? kodemember,
    String? namamember,
    String? idtrxmitra,
    String? kodeproduk,
    String? namaproduk,
    String? keteranganproduk,
    int? idprovider,
    String? tujuantrx,
    String? tujuantambahantrx,
    int? totalharga,
    int? jumlahtagihan,
    int? potongsaldotagihan,
    int? statustrx,
    String? sn,
    int? feeppob,
    int? totaltagihan,
    String? kodebayar,
    int? jenistrx,
    String? datatrx,
    int? saldoawal,
    int? saldoakhir,
    String? terminal,
    int? trxke,
    int? tipesender,
  }) {
    return TransaksiData(
      idpesandikirim: idpesandikirim ?? this.idpesandikirim,
      waktu: waktu ?? this.waktu,
      tujuanpesan: tujuanpesan ?? this.tujuanpesan,
      isipesan: isipesan ?? this.isipesan,
      statuspesan: statuspesan ?? this.statuspesan,
      idtransaksiprod: idtransaksiprod ?? this.idtransaksiprod,
      kodemember: kodemember ?? this.kodemember,
      namamember: namamember ?? this.namamember,
      idtrxmitra: idtrxmitra ?? this.idtrxmitra,
      kodeproduk: kodeproduk ?? this.kodeproduk,
      namaproduk: namaproduk ?? this.namaproduk,
      keteranganproduk: keteranganproduk ?? this.keteranganproduk,
      idprovider: idprovider ?? this.idprovider,
      tujuantrx: tujuantrx ?? this.tujuantrx,
      tujuantambahantrx: tujuantambahantrx ?? this.tujuantambahantrx,
      totalharga: totalharga ?? this.totalharga,
      jumlahtagihan: jumlahtagihan ?? this.jumlahtagihan,
      potongsaldotagihan: potongsaldotagihan ?? this.potongsaldotagihan,
      statustrx: statustrx ?? this.statustrx,
      sn: sn ?? this.sn,
      feeppob: feeppob ?? this.feeppob,
      totaltagihan: totaltagihan ?? this.totaltagihan,
      kodebayar: kodebayar ?? this.kodebayar,
      jenistrx: jenistrx ?? this.jenistrx,
      datatrx: datatrx ?? this.datatrx,
      saldoawal: saldoawal ?? this.saldoawal,
      saldoakhir: saldoakhir ?? this.saldoakhir,
      terminal: terminal ?? this.terminal,
      trxke: trxke ?? this.trxke,
      tipesender: tipesender ?? this.tipesender,
    );
  }

  @override
  String toString() {
    return 'TransaksiData(idpesandikirim: $idpesandikirim, kodeproduk: $kodeproduk, namaproduk: $namaproduk, totalharga: $totalharga, statustrx: $statustrx)';
  }
}

class CekTagihanResponse {
  final TransaksiData? data;
  final DataSplit? dataSplit;
  final String message;
  final bool status;

  const CekTagihanResponse({
    required this.data,
    required this.dataSplit,
    required this.message,
    required this.status,
  });

  factory CekTagihanResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DEFAULT_CEK_TAGIHAN_RESPONSE;


    return CekTagihanResponse(
      data: TransaksiData.fromJson(json['data'] as Map<String, dynamic>?),
      dataSplit: DataSplit.fromJson(json['dataSplit'] as Map<String, dynamic>?),
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'dataSplit': dataSplit?.toJson(),
    'message': message,
    'status': status,
  };

  CekTagihanResponse copyWith({
    TransaksiData? data,
    DataSplit? dataSplit,
    String? message,
    bool? status,
  }) {
    return CekTagihanResponse(
      data: data ?? this.data,
      dataSplit: dataSplit ?? this.dataSplit,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'CekTagihanResponse(status: $status, message: $message, data: $data)';
  }
}

// Default constants
const DEFAULT_TRANSAKSI_DATA_RESPONSE = TransaksiData(
  idpesandikirim: 0,
  waktu: '',
  tujuanpesan: '',
  isipesan: '',
  statuspesan: 0,
  idtransaksiprod: 0,
  kodemember: '',
  namamember: '',
  idtrxmitra: '',
  kodeproduk: '',
  namaproduk: '',
  keteranganproduk: '',
  idprovider: 0,
  tujuantrx: '',
  tujuantambahantrx: '',
  totalharga: 0,
  jumlahtagihan: 0,
  potongsaldotagihan: 0,
  statustrx: 0,
  sn: '',
  feeppob: 0,
  totaltagihan: 0,
  kodebayar: '',
  jenistrx: 0,
  datatrx: '',
  saldoawal: 0,
  saldoakhir: 0,
  terminal: '',
  trxke: 0,
  tipesender: 0,
);

const DEFAULT_DATA_SPLIT_RESPONSE = DataSplit(dataTransaksi: [], dataBiaya: []);

const DEFAULT_CEK_TAGIHAN_RESPONSE = CekTagihanResponse(
  data: DEFAULT_TRANSAKSI_DATA_RESPONSE,
  dataSplit: DEFAULT_DATA_SPLIT_RESPONSE,
  message: '',
  status: false,
);
