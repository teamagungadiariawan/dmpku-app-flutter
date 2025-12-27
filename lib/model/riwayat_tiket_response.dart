import 'package:dmpku/core/enums/status_tiket.dart';

// 1. Model buat satu item tiket (Detail per transaksi)
class RiwayatTiketBankModel {
  final int biayaadmin;
  final String deskripsi;
  final String expireddata;
  final String icon;
  final int jumlahnominalantriantiket;
  final String namaakun;
  final String namarekening;
  final int noantriantiket;
  final int nominalreqantriantiket;
  final String norekening;
  final int status; // 0: Menunggu, 1: Sukses, 2: Gagal/Expired
  final int statusbank;
  final String waktureq;

  const RiwayatTiketBankModel({
    required this.biayaadmin,
    required this.deskripsi,
    required this.expireddata,
    required this.icon,
    required this.jumlahnominalantriantiket,
    required this.namaakun,
    required this.namarekening,
    required this.noantriantiket,
    required this.nominalreqantriantiket,
    required this.norekening,
    required this.status,
    required this.statusbank,
    required this.waktureq,
  });

  factory RiwayatTiketBankModel.fromJson(Map<String, dynamic>? json) {
    return RiwayatTiketBankModel(
      biayaadmin: json?['biayaadmin'] ?? 0,
      deskripsi: json?['deskripsi'] ?? '',
      expireddata: json?['expireddata'] ?? '',
      icon: json?['icon'] ?? '',
      jumlahnominalantriantiket: json?['jumlahnominalantriantiket'] ?? 0,
      namaakun: json?['namaakun'] ?? '',
      namarekening: json?['namarekening'] ?? '',
      noantriantiket: json?['noantriantiket'] ?? 0,
      nominalreqantriantiket: json?['nominalreqantriantiket'] ?? 0,
      norekening: json?['norekening'] ?? '',
      status: json?['status'] ?? 0,
      statusbank: json?['statusbank'] ?? 0,
      waktureq: json?['waktureq'] ?? '',
    );
  }

  RiwayatTiketBankModel copyWith({
    int? biayaadmin,
    String? deskripsi,
    String? expireddata,
    String? icon,
    int? jumlahnominalantriantiket,
    String? namaakun,
    String? namarekening,
    int? noantriantiket,
    int? nominalreqantriantiket,
    String? norekening,
    int? status,
    int? statusbank,
    String? waktureq,
  }) {
    return RiwayatTiketBankModel(
      biayaadmin: biayaadmin ?? this.biayaadmin,
      deskripsi: deskripsi ?? this.deskripsi,
      expireddata: expireddata ?? this.expireddata,
      icon: icon ?? this.icon,
      jumlahnominalantriantiket:
          jumlahnominalantriantiket ?? this.jumlahnominalantriantiket,
      namaakun: namaakun ?? this.namaakun,
      namarekening: namarekening ?? this.namarekening,
      noantriantiket: noantriantiket ?? this.noantriantiket,
      nominalreqantriantiket:
          nominalreqantriantiket ?? this.nominalreqantriantiket,
      norekening: norekening ?? this.norekening,
      status: status ?? this.status,
      statusbank: statusbank ?? this.statusbank,
      waktureq: waktureq ?? this.waktureq,
    );
  }

  StatusTiket get tiketStatus => StatusTiket.fromId(status);

  @override
  String toString() {
    return 'RiwayatTiketBankModel(noantriantiket: $noantriantiket, nominal: $jumlahnominalantriantiket, status: $status)';
  }
}

// Default value kalau data null
const RiwayatTiketBankModel DEFAULT_RIWAYAT_TIKET_BANK_MODEL =
    RiwayatTiketBankModel(
      biayaadmin: 0,
      deskripsi: '',
      expireddata: '',
      icon: '',
      jumlahnominalantriantiket: 0,
      namaakun: '',
      namarekening: '',
      noantriantiket: 0,
      nominalreqantriantiket: 0,
      norekening: '',
      status: 0,
      statusbank: 0,
      waktureq: '',
    );

// 2. Response Utama (Wrapper List)
class RiwayatTiketBankResponse {
  final List<RiwayatTiketBankModel>? data;
  final String message;
  final bool status;

  const RiwayatTiketBankResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RiwayatTiketBankResponse.fromJson(Map<String, dynamic>? json) {
    // Parsing List Data dengan aman
    var listData = json?['data'] as List<dynamic>?;
    List<RiwayatTiketBankModel> parsedData =
        listData
            ?.map(
              (e) => RiwayatTiketBankModel.fromJson(e as Map<String, dynamic>?),
            )
            .toList() ??
        [];

    return RiwayatTiketBankResponse(
      data: parsedData,
      message: json?['message'] ?? '',
      status: json?['status'] ?? false,
    );
  }

  RiwayatTiketBankResponse copyWith({
    List<RiwayatTiketBankModel>? data,
    String? message,
    bool? status,
  }) {
    return RiwayatTiketBankResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketBankResponse(status: $status, message: $message, totalData: ${data?.length})';
  }
}

class RiwayatTiketAlfamartModel {
  final int admin;
  final String deskripsi;
  final String expireddata;
  final String icon;
  final String invoice;
  final String kodebayar;
  final String nama;
  final String namaakun;
  final int nominal;
  final int saldomasuk;
  final int status;
  final int statusbank;
  final int totalbayar;
  final String waktu;

  const RiwayatTiketAlfamartModel({
    required this.admin,
    required this.deskripsi,
    required this.expireddata,
    required this.icon,
    required this.invoice,
    required this.kodebayar,
    required this.nama,
    required this.namaakun,
    required this.nominal,
    required this.saldomasuk,
    required this.status,
    required this.statusbank,
    required this.totalbayar,
    required this.waktu,
  });

  factory RiwayatTiketAlfamartModel.fromJson(Map<String, dynamic>? json) {
    return RiwayatTiketAlfamartModel(
      admin: json?['admin'] ?? 0,
      deskripsi: json?['deskripsi'] ?? '',
      expireddata: json?['expireddata'] ?? '',
      icon: json?['icon'] ?? '',
      invoice: json?['invoice'] ?? '',
      kodebayar: json?['kodebayar'].trim() ?? '',
      nama: json?['nama'] ?? '',
      namaakun: json?['namaakun'] ?? '',
      nominal: json?['nominal'] ?? 0,
      saldomasuk: json?['saldomasuk'] ?? 0,
      status: json?['status'] ?? 0,
      statusbank: json?['statusbank'] ?? 0,
      totalbayar: json?['totalbayar'] ?? 0,
      waktu: json?['waktu'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketAlfamart(invoice: $invoice, nominal: $nominal, status: $status)';
  }

  StatusTiket get tiketStatus => StatusTiket.fromId(status);
}

class RiwayatTiketAlfamartResponse {
  final List<RiwayatTiketAlfamartModel>? data;
  final String message;
  final bool status;

  const RiwayatTiketAlfamartResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RiwayatTiketAlfamartResponse.fromJson(Map<String, dynamic>? json) {
    var listData = json?['data'] as List<dynamic>?;
    List<RiwayatTiketAlfamartModel> parsedData =
        listData
            ?.map(
              (e) => RiwayatTiketAlfamartModel.fromJson(
                e as Map<String, dynamic>?,
              ),
            )
            .toList() ??
        [];

    return RiwayatTiketAlfamartResponse(
      data: parsedData,
      message: json?['message'] ?? '',
      status: json?['status'] ?? false,
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketAlfamartResponse(status: $status, message: $message, totalData: ${data?.length})';
  }
}

const RiwayatTiketAlfamartModel DEFAULT_RIWAYAT_TIKET_ALFAMART =
    RiwayatTiketAlfamartModel(
      admin: 0,
      deskripsi: '',
      expireddata: '',
      icon: '',
      invoice: '',
      kodebayar: '',
      nama: '',
      namaakun: '',
      nominal: 0,
      saldomasuk: 0,
      status: 0,
      statusbank: 0,
      totalbayar: 0,
      waktu: '',
    );

class RiwayatTiketIndomaretModel {
  final int admin;
  final String deskripsi;
  final String expireddata;
  final String icon;
  final String invoice;
  final String kodebayar;
  final String nama;
  final String namaakun;
  final int nominal;
  final int saldomasuk;
  final int status;
  final int statusbank;
  final int totalbayar;
  final String waktu;

  const RiwayatTiketIndomaretModel({
    required this.admin,
    required this.deskripsi,
    required this.expireddata,
    required this.icon,
    required this.invoice,
    required this.kodebayar,
    required this.nama,
    required this.namaakun,
    required this.nominal,
    required this.saldomasuk,
    required this.status,
    required this.statusbank,
    required this.totalbayar,
    required this.waktu,
  });

  factory RiwayatTiketIndomaretModel.fromJson(Map<String, dynamic>? json) {
    return RiwayatTiketIndomaretModel(
      admin: json?['admin'] ?? 0,
      deskripsi: json?['deskripsi'] ?? '',
      expireddata: json?['expireddata'] ?? '',
      icon: json?['icon'] ?? '',
      invoice: json?['invoice'] ?? '',
      kodebayar: json?['kodebayar'].trim() ?? '',
      nama: json?['nama'] ?? '',
      namaakun: json?['namaakun'] ?? '',
      nominal: json?['nominal'] ?? 0,
      saldomasuk: json?['saldomasuk'] ?? 0,
      status: json?['status'] ?? 0,
      statusbank: json?['statusbank'] ?? 0,
      totalbayar: json?['totalbayar'] ?? 0,
      waktu: json?['waktu'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketIndomaret(invoice: $invoice, nominal: $nominal, status: $status)';
  }

  StatusTiket get tiketStatus => StatusTiket.fromId(status);

  RiwayatTiketIndomaretModel copyWith({
    int? admin,
    String? deskripsi,
    String? expireddata,
    String? icon,
    String? invoice,
    String? kodebayar,
    String? nama,
    String? namaakun,
    int? nominal,
    int? saldomasuk,
    int? status,
    int? statusbank,
    int? totalbayar,
    String? waktu,
  }) {
    return RiwayatTiketIndomaretModel(
      admin: admin ?? this.admin,
      deskripsi: deskripsi ?? this.deskripsi,
      expireddata: expireddata ?? this.expireddata,
      icon: icon ?? this.icon,
      invoice: invoice ?? this.invoice,
      kodebayar: kodebayar ?? this.kodebayar,
      nama: nama ?? this.nama,
      namaakun: namaakun ?? this.namaakun,
      nominal: nominal ?? this.nominal,
      saldomasuk: saldomasuk ?? this.saldomasuk,
      status: status ?? this.status,
      statusbank: statusbank ?? this.statusbank,
      totalbayar: totalbayar ?? this.totalbayar,
      waktu: waktu ?? this.waktu,
    );
  }
}

class RiwayatTiketIndomaretResponse {
  final List<RiwayatTiketIndomaretModel>? data;
  final String message;
  final bool status;

  const RiwayatTiketIndomaretResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RiwayatTiketIndomaretResponse.fromJson(Map<String, dynamic>? json) {
    var listData = json?['data'] as List<dynamic>?;
    List<RiwayatTiketIndomaretModel> parsedData =
        listData
            ?.map(
              (e) => RiwayatTiketIndomaretModel.fromJson(
                e as Map<String, dynamic>?,
              ),
            )
            .toList() ??
        [];

    return RiwayatTiketIndomaretResponse(
      data: parsedData,
      message: json?['message'] ?? '',
      status: json?['status'] ?? false,
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketIndomaretResponse(status: $status, message: $message, totalData: ${data?.length})';
  }
}

const RiwayatTiketIndomaretModel DEFAULT_RIWAYAT_TIKET_INDOMARET =
    RiwayatTiketIndomaretModel(
      admin: 0,
      deskripsi: '',
      expireddata: '',
      icon: '',
      invoice: '',
      kodebayar: '',
      nama: '',
      namaakun: '',
      nominal: 0,
      saldomasuk: 0,
      status: 0,
      statusbank: 0,
      totalbayar: 0,
      waktu: '',
    );

class RiwayatTiketQRISModel {
  final int admin;
  final String deskripsi;
  final String expired;
  final String icon;
  final String namaakun;
  final int nominal;
  final String qrurl;
  final int saldomasuk;
  final int status;
  final int statusbank;
  final int totalbayar;
  final String waktu;

  const RiwayatTiketQRISModel({
    required this.admin,
    required this.deskripsi,
    required this.expired,
    required this.icon,
    required this.namaakun,
    required this.nominal,
    required this.qrurl,
    required this.saldomasuk,
    required this.status,
    required this.statusbank,
    required this.totalbayar,
    required this.waktu,
  });

  factory RiwayatTiketQRISModel.fromJson(Map<String, dynamic>? json) {
    return RiwayatTiketQRISModel(
      admin: json?['admin'] ?? 0,
      deskripsi: json?['deskripsi'] ?? '',
      expired: json?['expired'] ?? '',
      icon: json?['icon'] ?? '',
      namaakun: json?['namaakun'] ?? '',
      nominal: json?['nominal'] ?? 0,
      qrurl: json?['qrurl'] ?? '',
      saldomasuk: json?['saldomasuk'] ?? 0,
      status: json?['status'] ?? 0,
      statusbank: json?['statusbank'] ?? 0,
      totalbayar: json?['totalbayar'] ?? 0,
      waktu: json?['waktu'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketQRIS(nominal: $nominal, status: $status)';
  }

  StatusTiket get tiketStatus => StatusTiket.fromId(status);

  RiwayatTiketQRISModel copyWith({
    int? admin,
    String? deskripsi,
    String? expired,
    String? icon,
    String? namaakun,
    int? nominal,
    String? qrurl,
    int? saldomasuk,
    int? status,
    int? statusbank,
    int? totalbayar,
    String? waktu,
  }) {
    return RiwayatTiketQRISModel(
      admin: admin ?? this.admin,
      deskripsi: deskripsi ?? this.deskripsi,
      expired: expired ?? this.expired,
      icon: icon ?? this.icon,
      namaakun: namaakun ?? this.namaakun,
      nominal: nominal ?? this.nominal,
      qrurl: qrurl ?? this.qrurl,
      saldomasuk: saldomasuk ?? this.saldomasuk,
      status: status ?? this.status,
      statusbank: statusbank ?? this.statusbank,
      totalbayar: totalbayar ?? this.totalbayar,
      waktu: waktu ?? this.waktu,
    );
  }
}

class RiwayatTiketQRISResponse {
  final List<RiwayatTiketQRISModel>? data;
  final String message;
  final bool status;

  const RiwayatTiketQRISResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RiwayatTiketQRISResponse.fromJson(Map<String, dynamic>? json) {
    var listData = json?['data'] as List<dynamic>?;
    List<RiwayatTiketQRISModel> parsedData =
        listData
            ?.map(
              (e) => RiwayatTiketQRISModel.fromJson(e as Map<String, dynamic>?),
            )
            .toList() ??
        [];

    return RiwayatTiketQRISResponse(
      data: parsedData,
      message: json?['message'] ?? '',
      status: json?['status'] ?? false,
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketQRISResponse(status: $status, message: $message, totalData: ${data?.length})';
  }
}

const RiwayatTiketQRISModel DEFAULT_RIWAYAT_TIKET_QRIS = RiwayatTiketQRISModel(
  admin: 0,
  deskripsi: '',
  expired: '',
  icon: '',
  namaakun: '',
  nominal: 0,
  qrurl: '',
  saldomasuk: 0,
  status: 0,
  statusbank: 0,
  totalbayar: 0,
  waktu: '',
);

class RiwayatTiketVAModel {
  final int admin;
  final String deskripsi;
  final String expired;
  final String icon;
  final String invoice;
  final String nama;
  final String namaakun;
  final int nominal;
  final String nova;
  final int saldomasuk;
  final int status;
  final int statusbank;
  final int totalbayar;
  final String waktu;
  final String expireddata;

  const RiwayatTiketVAModel({
    required this.admin,
    required this.deskripsi,
    required this.expired,
    required this.icon,
    required this.invoice,
    required this.nama,
    required this.namaakun,
    required this.nominal,
    required this.nova,
    required this.saldomasuk,
    required this.status,
    required this.statusbank,
    required this.totalbayar,
    required this.waktu,
    required this.expireddata,
  });

  factory RiwayatTiketVAModel.fromJson(Map<String, dynamic>? json) {
    return RiwayatTiketVAModel(
      admin: json?['admin'] ?? 0,
      deskripsi: json?['deskripsi'] ?? '',
      expired: json?['expired'] ?? json?['expireddata'] ?? '',
      icon: json?['icon'] ?? '',
      invoice: json?['invoice'] ?? '',
      nama: json?['nama'] ?? '',
      namaakun: json?['namaakun'].trim() ?? '',
      nominal: json?['nominal'] ?? 0,
      nova: json?['nova'].trim() ?? '',
      saldomasuk: json?['saldomasuk'] ?? 0,
      status: json?['status'] ?? 0,
      statusbank: json?['statusbank'] ?? 0,
      totalbayar: json?['totalbayar'] ?? 0,
      waktu: json?['waktu'] ?? '',
      expireddata: json?['expireddata'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketVA(invoice: $invoice, nominal: $nominal, status: $status)';
  }

  StatusTiket get tiketStatus => StatusTiket.fromId(status);

  RiwayatTiketVAModel copyWith({
    int? admin,
    String? deskripsi,
    String? expired,
    String? icon,
    String? invoice,
    String? nama,
    String? namaakun,
    int? nominal,
    String? nova,
    int? saldomasuk,
    int? status,
    int? statusbank,
    int? totalbayar,
    String? waktu,
    String? expireddata,
  }) {
    return RiwayatTiketVAModel(
      admin: admin ?? this.admin,
      deskripsi: deskripsi ?? this.deskripsi,
      expired: expired ?? this.expired,
      icon: icon ?? this.icon,
      invoice: invoice ?? this.invoice,
      nama: nama ?? this.nama,
      namaakun: namaakun ?? this.namaakun,
      nominal: nominal ?? this.nominal,
      nova: nova ?? this.nova,
      saldomasuk: saldomasuk ?? this.saldomasuk,
      status: status ?? this.status,
      statusbank: statusbank ?? this.statusbank,
      totalbayar: totalbayar ?? this.totalbayar,
      waktu: waktu ?? this.waktu,
      expireddata: expireddata ?? this.expireddata,
    );
  }
}

class RiwayatTiketResponse {
  final List<RiwayatTiketVAModel>? data;
  final String message;
  final bool status;

  const RiwayatTiketResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RiwayatTiketResponse.fromJson(Map<String, dynamic>? json) {
    var listData = json?['data'] as List<dynamic>?;
    List<RiwayatTiketVAModel> parsedData =
        listData
            ?.map(
              (e) => RiwayatTiketVAModel.fromJson(e as Map<String, dynamic>?),
            )
            .toList() ??
        [];

    return RiwayatTiketResponse(
      data: parsedData,
      message: json?['message'] ?? '',
      status: json?['status'] ?? false,
    );
  }

  @override
  String toString() {
    return 'RiwayatTiketResponse(status: $status, message: $message, totalData: ${data?.length})';
  }
}

const RiwayatTiketVAModel DEFAULT_RIWAYAT_TIKET_VA = RiwayatTiketVAModel(
  admin: 0,
  deskripsi: '',
  expired: '',
  icon: '',
  invoice: '',
  nama: '',
  namaakun: '',
  nominal: 0,
  nova: '',
  saldomasuk: 0,
  status: 0,
  statusbank: 0,
  totalbayar: 0,
  waktu: '',
  expireddata: '',
);
