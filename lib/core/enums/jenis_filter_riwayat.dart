import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum JenisFilterRiwayat { tujuan(), kodeProduk, namaProduk }

extension JenisFilterX on JenisFilterRiwayat {
  bool get isTujuan => this == JenisFilterRiwayat.tujuan;

  bool get isKodeProduk => this == JenisFilterRiwayat.kodeProduk;

  bool get isNamaProduk => this == JenisFilterRiwayat.namaProduk;

  String get label {
    switch (this) {
      case JenisFilterRiwayat.tujuan:
        return 'Tujuan';
      case JenisFilterRiwayat.kodeProduk:
        return 'Kode Produk';
      case JenisFilterRiwayat.namaProduk:
        return 'Nama Produk';
    }
  }

  IconData get icon {
    switch (this) {
      case JenisFilterRiwayat.tujuan:
        return MdiIcons.cardAccountDetails;
      case JenisFilterRiwayat.kodeProduk:
        return LucideIcons.qrCode;
      case JenisFilterRiwayat.namaProduk:
        return LucideIcons.packageSearch;
    }
  }
}
