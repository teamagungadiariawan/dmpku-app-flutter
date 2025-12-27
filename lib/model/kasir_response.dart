class KategoriModel {
  final String idKategori;
  final int id;
  final String namaKategori;
  final String path;

  KategoriModel({
    required this.idKategori,
    required this.id,
    required this.namaKategori,
    required this.path,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      idKategori: json['id_kategori'] ?? '',
      id: json['id'] ?? 0,
      namaKategori: json['nama_kategori'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class PenjualanModel {
  final int idpenjualan;
  final String kodemember;
  final int jumlahproduk;
  final int jumlahmodal;
  final int jumlahbayar;
  final int idpelanggan;
  final String namapelanggan;
  final String nohppelanggan;
  final String alamatpelanggan;
  final String namaproduk;
  final int uangpelanggan;
  final int kembalian;
  final int status;
  final String waktutrx;

  PenjualanModel({
    required this.idpenjualan,
    required this.kodemember,
    required this.jumlahproduk,
    required this.jumlahmodal,
    required this.jumlahbayar,
    required this.idpelanggan,
    required this.namapelanggan,
    required this.nohppelanggan,
    required this.alamatpelanggan,
    required this.namaproduk,
    required this.uangpelanggan,
    required this.kembalian,
    required this.status,
    required this.waktutrx,
  });

  factory PenjualanModel.fromJson(Map<String, dynamic> json) {
    return PenjualanModel(
      idpenjualan: json['idpenjualan'] ?? 0,
      kodemember: json['kodemember'] ?? '',
      jumlahproduk: json['jumlahproduk'] ?? 0,
      jumlahmodal: json['jumlahmodal'] ?? 0,
      jumlahbayar: json['jumlahbayar'] ?? 0,
      idpelanggan: json['idpelanggan'] ?? 0,
      namapelanggan: json['namapelanggan'] ?? '',
      nohppelanggan: json['nohppelanggan'] ?? '',
      alamatpelanggan: json['alamatpelanggan'] ?? '',
      namaproduk: json['namaproduk'] ?? '',
      uangpelanggan: json['uangpelanggan'] ?? 0,
      kembalian: json['kembalian'] ?? 0,
      status: json['status'] ?? 0,
      waktutrx: json['waktutrx'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idpenjualan': idpenjualan,
      'kodemember': kodemember,
      'jumlahproduk': jumlahproduk,
      'jumlahmodal': jumlahmodal,
      'jumlahbayar': jumlahbayar,
      'idpelanggan': idpelanggan,
      'namapelanggan': namapelanggan,
      'nohppelanggan': nohppelanggan,
      'alamatpelanggan': alamatpelanggan,
      'namaproduk': namaproduk,
      'uangpelanggan': uangpelanggan,
      'kembalian': kembalian,
      'status': status,
      'waktutrx': waktutrx,
    };
  }
}

class ProdukModel {
  final int idproduk;
  final String kodemember;
  final String namaproduk;
  final int hargamodal;
  final int hargajual;
  final String satuan;
  final int jumlah;

  ProdukModel({
    required this.idproduk,
    required this.kodemember,
    required this.namaproduk,
    required this.hargamodal,
    required this.hargajual,
    required this.satuan,
    required this.jumlah,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      idproduk: json['idproduk'] ?? 0,
      kodemember: json['kodemember'] ?? '',
      namaproduk: json['namaproduk'] ?? '',
      hargamodal: json['hargamodal'] ?? 0,
      hargajual: json['hargajual'] ?? 0,
      satuan: json['satuan'] ?? '',
      jumlah: json['jumlah'] ?? 0,
    );
  }
}

class PelangganModel {
  final int idpelanggan;
  final String namapelanggan;
  final String alamatpelanggan;
  final String nohppelanggan;
  final String kodemember;

  PelangganModel({
    required this.idpelanggan,
    required this.namapelanggan,
    required this.alamatpelanggan,
    required this.nohppelanggan,
    required this.kodemember,
  });

  factory PelangganModel.fromJson(Map<String, dynamic> json) {
    return PelangganModel(
      idpelanggan: json['idpelanggan'] ?? 0,
      namapelanggan: json['namapelanggan'] ?? '',
      alamatpelanggan: json['alamatpelanggan'] ?? '',
      nohppelanggan: json['nohppelanggan'] ?? '',
      kodemember: json['kodemember'] ?? '',
    );
  }
}

class ListPenjualanDetailModel {
  final int idpenjualandetail;
  final int idpenjualan;
  final int idproduk;
  final String namaproduk;
  final String satuan;
  final int hargamodal;
  final int hargajual;
  final int jumlah;
  final int subtotalhargamodal;
  final int subtotalhargajual;
  final String waktu;
  final String kodemember;

  ListPenjualanDetailModel({
    required this.idpenjualandetail,
    required this.idpenjualan,
    required this.idproduk,
    required this.namaproduk,
    required this.satuan,
    required this.hargamodal,
    required this.hargajual,
    required this.jumlah,
    required this.subtotalhargamodal,
    required this.subtotalhargajual,
    required this.waktu,
    required this.kodemember,
  });

  factory ListPenjualanDetailModel.fromJson(Map<String, dynamic> json) {
    return ListPenjualanDetailModel(
      idpenjualandetail: json['idpenjualandetail'] ?? 0,
      idpenjualan: json['idpenjualan'] ?? 0,
      idproduk: json['idproduk'] ?? 0,
      namaproduk: json['namaproduk'] ?? '',
      satuan: json['satuan'] ?? '',
      hargamodal: json['hargamodal'] ?? 0,
      hargajual: json['hargajual'] ?? 0,
      jumlah: json['jumlah'] ?? 0,
      subtotalhargamodal: json['subtotalhargamodal'] ?? 0,
      subtotalhargajual: json['subtotalhargajual'] ?? 0,
      waktu: json['waktu'] ?? '',
      kodemember: json['kodemember'] ?? '',
    );
  }
}

class LaporanKasirModel {
  final int idpenjualan;
  final int jumlahproduk;
  final int jumlahmodal;
  final int jumlahbayar;
  final String namapelanggan;
  final String waktutrx;
  final int laba;

  LaporanKasirModel({
    required this.idpenjualan,
    required this.jumlahproduk,
    required this.jumlahmodal,
    required this.jumlahbayar,
    required this.namapelanggan,
    required this.waktutrx,
    required this.laba,
  });

  factory LaporanKasirModel.fromJson(Map<String, dynamic> json) {
    return LaporanKasirModel(
      idpenjualan: json['idpenjualan'] ?? 0,
      jumlahproduk: json['jumlahproduk'] ?? 0,
      jumlahmodal: json['jumlahmodal'] ?? 0,
      jumlahbayar: json['jumlahbayar'] ?? 0,
      namapelanggan: json['namapelanggan'] ?? '',
      waktutrx: json['waktutrx'] ?? '',
      laba: json['laba'] ?? 0,
    );
  }
}

class TotalLaporanKasirModel {
  final int jumlahmodal;
  final int jumlahbayar;
  final int laba;

  TotalLaporanKasirModel({
    required this.jumlahmodal,
    required this.jumlahbayar,
    required this.laba,
  });

  factory TotalLaporanKasirModel.fromJson(Map<String, dynamic> json) {
    return TotalLaporanKasirModel(
      jumlahmodal: json['jumlahmodal'] ?? 0,
      jumlahbayar: json['jumlahbayar'] ?? 0,
      laba: json['laba'] ?? 0,
    );
  }
}

class ListPenjualanResponse {
  final List<PenjualanModel> list;

  const ListPenjualanResponse({required this.list});

  factory ListPenjualanResponse.fromJson(List<dynamic>? json) {
    List<PenjualanModel> list = [];
    if (json != null) {
      list = json.map((e) => PenjualanModel.fromJson(e)).toList();
    }
    return ListPenjualanResponse(list: list);
  }

  Map<String, dynamic> toJson() {
    return {'data': list.map((e) => e.toJson()).toList()};
  }
}
