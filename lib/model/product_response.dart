// dart
class ProductModel {
  final int idproduk;
  final int idprovider;
  final int tipeproduk;
  final String kodeproduk;
  final String namaproduk;
  final String deskripsiproduk;
  final int nominalproduk;
  final int hargaproduk;
  final int maxproduk;
  final String imgproduk;
  final int urutanproduk;
  final int statusproduk;
  final String kodeprodukcek;
  final int minnominalbebas;
  final int maxnominalbebas;
  final int tipeinput;
  final int mintujuan;
  final int maxtujuan;

  const ProductModel({
    required this.idproduk,
    required this.idprovider,
    required this.tipeproduk,
    required this.kodeproduk,
    required this.namaproduk,
    required this.deskripsiproduk,
    required this.nominalproduk,
    required this.hargaproduk,
    required this.maxproduk,
    required this.imgproduk,
    required this.urutanproduk,
    required this.statusproduk,
    required this.kodeprodukcek,
    required this.minnominalbebas,
    required this.maxnominalbebas,
    required this.tipeinput,
    required this.mintujuan,
    required this.maxtujuan,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    idproduk: json['idproduk'] ?? 0,
    idprovider: json['idprovider'] ?? 0,
    tipeproduk: json['tipeproduk'] ?? 0,
    kodeproduk: json['kodeproduk'] ?? '',
    namaproduk: json['namaproduk'] ?? '',
    deskripsiproduk: json['deskripsiproduk'] ?? '',
    nominalproduk: json['nominalproduk'] ?? 0,
    hargaproduk: json['hargaproduk'] ?? 0,
    maxproduk: json['maxproduk'] ?? 0,
    imgproduk: json['imgproduk'] ?? '',
    urutanproduk: json['urutanproduk'] ?? 0,
    statusproduk: json['statusproduk'] ?? 0,
    kodeprodukcek: json['kodeprodukcek'] ?? '',
    minnominalbebas: json['minnominalbebas'] ?? 0,
    maxnominalbebas: json['maxnominalbebas'] ?? 0,
    tipeinput: json['tipeinput'] ?? 0,
    mintujuan: json['mintujuan'] ?? 0,
    maxtujuan: json['maxtujuan'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'idproduk': idproduk,
    'idprovider': idprovider,
    'tipeproduk': tipeproduk,
    'kodeproduk': kodeproduk,
    'namaproduk': namaproduk,
    'deskripsiproduk': deskripsiproduk,
    'nominalproduk': nominalproduk,
    'hargaproduk': hargaproduk,
    'maxproduk': maxproduk,
    'imgproduk': imgproduk,
    'urutanproduk': urutanproduk,
    'statusproduk': statusproduk,
    'kodeprodukcek': kodeprodukcek,
    'minnominalbebas': minnominalbebas,
    'maxnominalbebas': maxnominalbebas,
    'tipeinput': tipeinput,
    'mintujuan': mintujuan,
    'maxtujuan': maxtujuan,
  };

  ProductModel copyWith({
    int? idproduk,
    int? idprovider,
    int? tipeproduk,
    String? kodeproduk,
    String? namaproduk,
    String? deskripsiproduk,
    int? nominalproduk,
    int? hargaproduk,
    int? maxproduk,
    String? imgproduk,
    int? urutanproduk,
    int? statusproduk,
    String? kodeprodukcek,
    int? minnominalbebas,
    int? maxnominalbebas,
    int? tipeinput,
    int? mintujuan,
    int? maxtujuan,
  }) {
    return ProductModel(
      idproduk: idproduk ?? this.idproduk,
      idprovider: idprovider ?? this.idprovider,
      tipeproduk: tipeproduk ?? this.tipeproduk,
      kodeproduk: kodeproduk ?? this.kodeproduk,
      namaproduk: namaproduk ?? this.namaproduk,
      deskripsiproduk: deskripsiproduk ?? this.deskripsiproduk,
      nominalproduk: nominalproduk ?? this.nominalproduk,
      hargaproduk: hargaproduk ?? this.hargaproduk,
      maxproduk: maxproduk ?? this.maxproduk,
      imgproduk: imgproduk ?? this.imgproduk,
      urutanproduk: urutanproduk ?? this.urutanproduk,
      statusproduk: statusproduk ?? this.statusproduk,
      kodeprodukcek: kodeprodukcek ?? this.kodeprodukcek,
      minnominalbebas: minnominalbebas ?? this.minnominalbebas,
      maxnominalbebas: maxnominalbebas ?? this.maxnominalbebas,
      tipeinput: tipeinput ?? this.tipeinput,
      mintujuan: mintujuan ?? this.mintujuan,
      maxtujuan: maxtujuan ?? this.maxtujuan,
    );
  }

  @override
  String toString() {
    return 'ProductModel(idproduk: $idproduk, idprovider: $idprovider, namaproduk: $namaproduk)';
  }
}

class ListProductResponse {
  final List<ProductModel> productList;

  ListProductResponse({required this.productList});

  factory ListProductResponse.fromJson(List<dynamic>? json) {
    final List<ProductModel> dataList = [];

    if (json is List && json.isNotEmpty) {
      for (final el in json) {
        dataList.add(ProductModel.fromJson(el));
      }
    }

    return ListProductResponse(productList: dataList);
  }

  Map<String, dynamic> toJson() {
    return {"data": productList.map((e) => e.toJson()).toList()};
  }
}

const ProductModel DEFAULT_PRODUCT = ProductModel(
  idproduk: 0,
  idprovider: 0,
  tipeproduk: 0,
  kodeproduk: '',
  namaproduk: '',
  deskripsiproduk: '',
  nominalproduk: 0,
  hargaproduk: 0,
  maxproduk: 0,
  imgproduk: '',
  urutanproduk: 0,
  statusproduk: 0,
  kodeprodukcek: '',
  minnominalbebas: 0,
  maxnominalbebas: 0,
  tipeinput: 0,
  mintujuan: 0,
  maxtujuan: 0,
);
