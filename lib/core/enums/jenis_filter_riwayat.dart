enum JenisFilterRiwayat {
  tujuan(),
  kodeProduk,
  namaProduk,
}

extension JenisFilterX on JenisFilterRiwayat {
  bool get isTujuan => this == JenisFilterRiwayat.tujuan;

  bool get isKodeProduk => this == JenisFilterRiwayat.kodeProduk;

  bool get isNamaProduk => this == JenisFilterRiwayat.namaProduk;
}