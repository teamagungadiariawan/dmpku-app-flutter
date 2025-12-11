class BayarResponse {
  final String kodeproduk;
  final String namaproduk;
  final String sn;
  final String status;
  final int totalharga;
  final int trxke;
  final String tujuan;
  final String tujuantambahan;
  final String waktutrx;

  const BayarResponse({
    required this.kodeproduk,
    required this.namaproduk,
    required this.sn,
    required this.status,
    required this.totalharga,
    required this.trxke,
    required this.tujuan,
    required this.tujuantambahan,
    required this.waktutrx,
  });

  factory BayarResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BayarResponse(
        kodeproduk: '',
        namaproduk: '',
        sn: '',
        status: '',
        totalharga: 0,
        trxke: 0,
        tujuan: '',
        tujuantambahan: '',
        waktutrx: '',
      );
    }
    return BayarResponse(
      kodeproduk: json['kodeproduk'] ?? '',
      namaproduk: json['namaproduk'] ?? '',
      sn: json['sn'] ?? '',
      status: json['status'] ?? '',
      totalharga: json['totalharga'] ?? 0,
      trxke: json['trxke'] ?? 0,
      tujuan: json['tujuan'] ?? '',
      tujuantambahan: json['tujuantambahan'] ?? '',
      waktutrx: json['waktutrx'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'kodeproduk': kodeproduk,
    'namaproduk': namaproduk,
    'sn': sn,
    'status': status,
    'totalharga': totalharga,
    'trxke': trxke,
    'tujuan': tujuan,
    'tujuantambahan': tujuantambahan,
    'waktutrx': waktutrx,
  };

  BayarResponse copyWith({
    String? kodeproduk,
    String? namaproduk,
    String? sn,
    String? status,
    int? totalharga,
    int? trxke,
    String? tujuan,
    String? tujuantambahan,
    String? waktutrx,
  }) {
    return BayarResponse(
      kodeproduk: kodeproduk ?? this.kodeproduk,
      namaproduk: namaproduk ?? this.namaproduk,
      sn: sn ?? this.sn,
      status: status ?? this.status,
      totalharga: totalharga ?? this.totalharga,
      trxke: trxke ?? this.trxke,
      tujuan: tujuan ?? this.tujuan,
      tujuantambahan: tujuantambahan ?? this.tujuantambahan,
      waktutrx: waktutrx ?? this.waktutrx,
    );
  }

  @override
  String toString() {
    return 'BayarResponse(kodeproduk: $kodeproduk, namaproduk: $namaproduk, sn: $sn, status: $status, totalharga: $totalharga, trxke: $trxke, tujuan: $tujuan, tujuantambahan: $tujuantambahan, waktutrx: $waktutrx)';
  }
}
