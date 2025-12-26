import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:flutter/foundation.dart'; // Buat debugPrint kalau butuh

// 1. Model buat object "data" (Tiket)
class TiketDataModel {
  final int antriantiket;
  final int biayaadmin;
  final String expireddata;
  final int nominal;
  final int totaltiket;
  final String waktu;

  const TiketDataModel({
    required this.antriantiket,
    required this.biayaadmin,
    required this.expireddata,
    required this.nominal,
    required this.totaltiket,
    required this.waktu,
  });

  factory TiketDataModel.fromJson(Map<String, dynamic>? json) {
    return TiketDataModel(
      antriantiket: json?['antriantiket'] ?? 0,
      biayaadmin: json?['biayaadmin'] ?? 0,
      expireddata: json?['expireddata'] ?? '',
      nominal: json?['nominal'] ?? 0,
      totaltiket: json?['totaltiket'] ?? 0,
      waktu: json?['waktu'] ?? '',
    );
  }

  TiketDataModel copyWith({
    int? antriantiket,
    int? biayaadmin,
    String? expireddata,
    int? nominal,
    int? totaltiket,
    String? waktu,
  }) {
    return TiketDataModel(
      antriantiket: antriantiket ?? this.antriantiket,
      biayaadmin: biayaadmin ?? this.biayaadmin,
      expireddata: expireddata ?? this.expireddata,
      nominal: nominal ?? this.nominal,
      totaltiket: totaltiket ?? this.totaltiket,
      waktu: waktu ?? this.waktu,
    );
  }

  @override
  String toString() {
    return 'TiketDataModel(antriantiket: $antriantiket, nominal: $nominal, totaltiket: $totaltiket)';
  }
}

// Default value buat TiketDataModel
const TiketDataModel DEFAULT_TIKET_DATA_MODEL = TiketDataModel(
  antriantiket: 0,
  biayaadmin: 0,
  expireddata: '',
  nominal: 0,
  totaltiket: 0,
  waktu: '',
);

// 2. Model buat object "rekening"
class RekeningModel {
  final String bank;
  final String deskripsi;
  final String icon;
  final String namarekening;
  final String rekening;
  final bool status;

  const RekeningModel({
    required this.bank,
    required this.deskripsi,
    required this.icon,
    required this.namarekening,
    required this.rekening,
    required this.status,
  });

  factory RekeningModel.fromJson(Map<String, dynamic>? json) {
    return RekeningModel(
      bank: json?['bank'] ?? '',
      deskripsi: json?['deskripsi'] ?? '',
      icon: json?['icon'] ?? '',
      namarekening: json?['namarekening'] ?? '',
      rekening: json?['rekening'] ?? '',
      status: json?['status'] ?? false,
    );
  }

  RekeningModel copyWith({
    String? bank,
    String? deskripsi,
    String? icon,
    String? namarekening,
    String? rekening,
    bool? status,
  }) {
    return RekeningModel(
      bank: bank ?? this.bank,
      deskripsi: deskripsi ?? this.deskripsi,
      icon: icon ?? this.icon,
      namarekening: namarekening ?? this.namarekening,
      rekening: rekening ?? this.rekening,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'RekeningModel(bank: $bank, rekening: $rekening, namarekening: $namarekening)';
  }
}

// Default value buat RekeningModel
const RekeningModel DEFAULT_REKENING_MODEL = RekeningModel(
  bank: '',
  deskripsi: '',
  icon: '',
  namarekening: '',
  rekening: '',
  status: false,
);

// 3. Response Utama
class BuatTiketBankResponse {
  final TiketDataModel? data;
  final String expireddata;
  final String message;
  final RekeningModel? rekening;
  final bool status;

  const BuatTiketBankResponse({
    required this.data,
    required this.expireddata,
    required this.message,
    required this.rekening,
    required this.status,
  });

  factory BuatTiketBankResponse.fromJson(Map<String, dynamic>? json) {
    return BuatTiketBankResponse(
      data: json?['data'] != null
          ? TiketDataModel.fromJson(json!['data'])
          : DEFAULT_TIKET_DATA_MODEL,
      expireddata: json?['expireddata'] ?? '',
      message: json?['message'] ?? '',
      rekening: json?['rekening'] != null
          ? RekeningModel.fromJson(json!['rekening'])
          : DEFAULT_REKENING_MODEL,
      status: json?['status'] ?? false,
    );
  }

  BuatTiketBankResponse copyWith({
    TiketDataModel? data,
    String? expireddata,
    String? message,
    RekeningModel? rekening,
    bool? status,
  }) {
    return BuatTiketBankResponse(
      data: data ?? this.data,
      expireddata: expireddata ?? this.expireddata,
      message: message ?? this.message,
      rekening: rekening ?? this.rekening,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'BuatTiketBankResponse(message: $message, status: $status, data: $data)';
  }
}

// export interface BuatTiketAlfamartResponse {
// status: boolean
// message: string
// data: RiwayatTiketAlfamart
// }

class BuatTiketAlfamartResponse {
  final bool status;
  final String message;
  final RiwayatTiketAlfamartModel? data; // Belum dibuat modelnya

  const BuatTiketAlfamartResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BuatTiketAlfamartResponse.fromJson(Map<String, dynamic>? json) {
    return BuatTiketAlfamartResponse(
      status: json?['status'] ?? false,
      message: json?['message'] ?? '',
      data: RiwayatTiketAlfamartModel.fromJson(json!['data']),
    );
  }

  BuatTiketAlfamartResponse copyWith({
    bool? status,
    String? message,
    // RiwayatTiketAlfamart? data,
  }) {
    return BuatTiketAlfamartResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'BuatTiketAlfamartResponse(message: $message, status: $status)';
  }
}

class BuatTiketIndomaretResponse {
  final bool status;
  final String message;
  final RiwayatTiketIndomaretModel? data; // Belum dibuat modelnya

  const BuatTiketIndomaretResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BuatTiketIndomaretResponse.fromJson(Map<String, dynamic>? json) {
    return BuatTiketIndomaretResponse(
      status: json?['status'] ?? false,
      message: json?['message'] ?? '',
      data: RiwayatTiketIndomaretModel.fromJson(json!['data']),
    );
  }

  BuatTiketIndomaretResponse copyWith({
    bool? status,
    String? message,
    // RiwayatTiketIndomaret? data,
  }) {
    return BuatTiketIndomaretResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'BuatTiketIndomaretResponse(message: $message, status: $status)';
  }
}

class BuatTiketQrisResponse {
  final bool status;
  final String message;
  final RiwayatTiketQRISModel? data; // Belum dibuat modelnya

  const BuatTiketQrisResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BuatTiketQrisResponse.fromJson(Map<String, dynamic>? json) {
    return BuatTiketQrisResponse(
      status: json?['status'] ?? false,
      message: json?['message'] ?? '',
      data: RiwayatTiketQRISModel.fromJson(json!['data']),
    );
  }

  BuatTiketQrisResponse copyWith({
    bool? status,
    String? message,
    // RiwayatTiketQris? data,
  }) {
    return BuatTiketQrisResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'BuatTiketQrisResponse(message: $message, status: $status)';
  }
}

class BuatTiketVaResponse {
  final bool status;
  final String message;
  final RiwayatTiketVAModel? data; // Belum dibuat modelnya

  const BuatTiketVaResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BuatTiketVaResponse.fromJson(Map<String, dynamic>? json) {
    return BuatTiketVaResponse(
      status: json?['status'] ?? false,
      message: json?['message'] ?? '',
      data: RiwayatTiketVAModel.fromJson(json!['data']),
    );
  }

  BuatTiketVaResponse copyWith({
    bool? status,
    String? message,
    // RiwayatTiketVa? data,
  }) {
    return BuatTiketVaResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'BuatTiketVaResponse(message: $message, status: $status)';
  }
}