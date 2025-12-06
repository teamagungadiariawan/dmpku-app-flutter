import 'package:dmpku/core/helpers/strings_helper.dart';

class ProfileModel {
  final String kodemember;
  final String namamember;
  final String email;
  final int saldo;
  final int verifikasi;
  final int userstatus;
  final int status;
  final int isppob;

  const ProfileModel({
    required this.kodemember,
    required this.namamember,
    required this.email,
    required this.saldo,
    required this.verifikasi,
    required this.userstatus,
    required this.status,
    required this.isppob,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    kodemember: json['kodemember'] ?? '',
    namamember: json['namamember'] ?? '',
    email: json['email'] ?? '',
    saldo: json['saldo'] ?? 0,
    verifikasi: json['verifikasi'] ?? 0,
    userstatus: json['userstatus'] ?? 0,
    status: json['status'] ?? 0,
    isppob: json['isppob'] ?? 0,
  );

  String get formatSaldo => ToRupiah(saldo.toString());

  @override
  String toString() {
    return 'ProfileModel(kodemember: $kodemember, namamember: $namamember, email: $email, saldo: $saldo, verifikasi: $verifikasi, userstatus: $userstatus, status: $status, isppob: $isppob)';
  }
}

const DEFAULT_PROFILE = ProfileModel(
  kodemember: '',
  namamember: '',
  email: '',
  saldo: 0,
  verifikasi: 0,
  userstatus: 0,
  status: 0,
  isppob: 0,
);
