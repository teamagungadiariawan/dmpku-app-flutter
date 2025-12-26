import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:flutter/widgets.dart';

class ProfileDetailModel {
  final String kodemember;
  final String namamember;
  final String email;
  final int saldo;
  final int verifikasi;
  final int userstatus;
  final String pemilik;
  final String noktp;
  final String nohp;
  final String alamat;

  const ProfileDetailModel({
    required this.kodemember,
    required this.namamember,
    required this.email,
    required this.saldo,
    required this.verifikasi,
    required this.userstatus,
    required this.pemilik,
    required this.noktp,
    required this.nohp,
    required this.alamat,
  });

  factory ProfileDetailModel.fromJson(Map<String, dynamic>? json) {
    return ProfileDetailModel(
      kodemember: json?['kodemember'] ?? '',
      namamember: json?['namamember'] ?? '',
      email: json?['email'] ?? '',
      saldo: json?['saldo'] ?? 0,
      verifikasi: json?['verifikasi'] ?? 0,
      userstatus: json?['userstatus'] ?? 0,
      pemilik: json?['pemilik'] ?? '',
      noktp: json?['noktp'] ?? '',
      nohp: json?['nohp'] ?? '',
      alamat: json?['alamat'] ?? '',
    );
  }

  ProfileDetailModel copyWith({
    String? kodemember,
    String? namamember,
    String? email,
    int? saldo,
    int? verifikasi,
    int? userstatus,
    String? pemilik,
    String? noktp,
    String? nohp,
    String? alamat,
  }) {
    return ProfileDetailModel(
      kodemember: kodemember ?? this.kodemember,
      namamember: namamember ?? this.namamember,
      email: email ?? this.email,
      saldo: saldo ?? this.saldo,
      verifikasi: verifikasi ?? this.verifikasi,
      userstatus: userstatus ?? this.userstatus,
      pemilik: pemilik ?? this.pemilik,
      noktp: noktp ?? this.noktp,
      nohp: nohp ?? this.nohp,
      alamat: alamat ?? this.alamat,
    );
  }

  String get formatSaldo => ToRupiah(saldo.toString());

  bool get isVerified => verifikasi == 1;

  bool get isAgen => userstatus == 1;

  @override
  String toString() {
    return 'ProfileDetailResponse(kodemember: $kodemember, namamember: $namamember, email: $email, saldo: $saldo, verifikasi: $verifikasi, userstatus: $userstatus, pemilik: $pemilik, noktp: $noktp, nohp: $nohp, alamat: $alamat)';
  }
}

const ProfileDetailModel DEFAULT_PROFILE_DETAIL_MODEL = ProfileDetailModel(
  kodemember: '',
  namamember: '',
  email: '',
  saldo: 0,
  verifikasi: 0,
  userstatus: 0,
  pemilik: '',
  noktp: '',
  nohp: '',
  alamat: '',
);

class ProfileDetailResponse {
  final String? nohp;
  final String? email;
  final ProfileDetailModel? data;

  const ProfileDetailResponse({
    required this.nohp,
    required this.email,
    required this.data,
  });

  factory ProfileDetailResponse.fromJson(Map<String, dynamic>? json) {
    var data = json?['data'] as Map<String, dynamic>?;
    debugPrint('ProfileDetailResponse json: ${data?['nohp']}');

    var datauser = json?['datauser'] as Map<String, dynamic>? ?? {};

    debugPrint('ProfileDetailResponse datauser: $datauser');


    return ProfileDetailResponse(
      nohp: json?['nohp'] ?? '',
      email: json?['email'] ?? '',
      data: ProfileDetailModel.fromJson(datauser),
    );
  }
}
