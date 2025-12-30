class ProdukPromoModel {
  final int idprodukpromo;
  final int kategoripromo;
  final String namakategoripromo;
  final String waktuberakhir;
  final int idprovider;
  final String namaprovider;
  final int tipeinput;
  final int mintujuan;
  final int maxtujuan;
  final int idproduk;
  final int tipeproduk;
  final String kodeproduk;
  final String namaproduk;
  final String deskripsiproduk;
  final int nominalproduk;
  final int hargaproduk;
  final String imgproduk;
  final int urutanproduk;
  final int statusproduk;
  final String kodeprodukcek;

  ProdukPromoModel({
    required this.idprodukpromo,
    required this.kategoripromo,
    required this.namakategoripromo,
    required this.waktuberakhir,
    required this.idprovider,
    required this.namaprovider,
    required this.tipeinput,
    required this.mintujuan,
    required this.maxtujuan,
    required this.idproduk,
    required this.tipeproduk,
    required this.kodeproduk,
    required this.namaproduk,
    required this.deskripsiproduk,
    required this.nominalproduk,
    required this.hargaproduk,
    required this.imgproduk,
    required this.urutanproduk,
    required this.statusproduk,
    required this.kodeprodukcek,
  });

  factory ProdukPromoModel.fromJson(Map<String, dynamic> json) {
    return ProdukPromoModel(
      idprodukpromo: json['idprodukpromo'] ?? 0,
      kategoripromo: json['kategoripromo'] ?? 0,
      namakategoripromo: json['namakategoripromo'] ?? '',
      waktuberakhir: json['waktuberakhir'] ?? '',
      idprovider: json['idprovider'] ?? 0,
      namaprovider: json['namaprovider'] ?? '',
      tipeinput: json['tipeinput'] ?? 0,
      mintujuan: json['mintujuan'] ?? 0,
      maxtujuan: json['maxtujuan'] ?? 0,
      idproduk: json['idproduk'] ?? 0,
      tipeproduk: json['tipeproduk'] ?? 0,
      kodeproduk: json['kodeproduk'] ?? '',
      namaproduk: json['namaproduk'] ?? '',
      deskripsiproduk: json['deskripsiproduk'] ?? '',
      nominalproduk: json['nominalproduk'] ?? 0,
      hargaproduk: json['hargaproduk'] ?? 0,
      imgproduk: json['imgproduk'] ?? '',
      urutanproduk: json['urutanproduk'] ?? 0,
      statusproduk: json['statusproduk'] ?? 0,
      kodeprodukcek: json['kodeprodukcek'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idprodukpromo': idprodukpromo,
      'kategoripromo': kategoripromo,
      'namakategoripromo': namakategoripromo,
      'waktuberakhir': waktuberakhir,
      'idprovider': idprovider,
      'namaprovider': namaprovider,
      'tipeinput': tipeinput,
      'mintujuan': mintujuan,
      'maxtujuan': maxtujuan,
      'idproduk': idproduk,
      'tipeproduk': tipeproduk,
      'kodeproduk': kodeproduk,
      'namaproduk': namaproduk,
      'deskripsiproduk': deskripsiproduk,
      'nominalproduk': nominalproduk,
      'hargaproduk': hargaproduk,
      'imgproduk': imgproduk,
      'urutanproduk': urutanproduk,
      'statusproduk': statusproduk,
      'kodeprodukcek': kodeprodukcek,
    };
  }
}

class ProviderPromoModel {
  final int idprovider;
  final String namaprovider;
  final List<ProdukPromoModel> data;

  ProviderPromoModel({
    required this.idprovider,
    required this.namaprovider,
    required this.data,
  });

  factory ProviderPromoModel.fromJson(Map<String, dynamic> json) {
    return ProviderPromoModel(
      idprovider: json['idprovider'] ?? 0,
      namaprovider: json['namaprovider'] ?? '',
      data:
          (json['data'] as List?)
              ?.map((e) => ProdukPromoModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idprovider': idprovider,
      'namaprovider': namaprovider,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class PromoProdukModel {
  final List<ProviderPromoModel> data;
  final int kategoripromo;
  final String namakategoripromo;

  PromoProdukModel({
    required this.data,
    required this.kategoripromo,
    required this.namakategoripromo,
  });

  factory PromoProdukModel.fromJson(Map<String, dynamic> json) {
    return PromoProdukModel(
      data:
          (json['data'] as List?)
              ?.map((e) => ProviderPromoModel.fromJson(e))
              .toList() ??
          [],
      kategoripromo: json['kategoripromo'] ?? 0,
      namakategoripromo: json['namakategoripromo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'kategoripromo': kategoripromo,
      'namakategoripromo': namakategoripromo,
    };
  }
}

class ListPromoProdukResponse {
  final List<PromoProdukModel> data;

  ListPromoProdukResponse({required this.data});

  factory ListPromoProdukResponse.fromJson(dynamic json) {
    if (json is List) {
      return ListPromoProdukResponse(
        data: json.map((e) => PromoProdukModel.fromJson(e)).toList(),
      );
    }
    return ListPromoProdukResponse(data: []);
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((e) => e.toJson()).toList()};
  }
}
