// dart
import 'package:flutter/material.dart' show Icons, IconData;
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

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

  bool get isGangguan => statusproduk == 0;

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

enum SortProductBy { hargaTerendah, hargaTertinggi, namaAtoZ, namaZtoA }

List<ProductModel> sortProducts(
  List<ProductModel> products,
  SortProductBy sortBy,
) {
  List<ProductModel> sortedProducts = List.from(products);

  switch (sortBy) {
    case SortProductBy.hargaTerendah:
      sortedProducts.sort((a, b) => a.hargaproduk.compareTo(b.hargaproduk));
      break;
    case SortProductBy.hargaTertinggi:
      sortedProducts.sort((a, b) => b.hargaproduk.compareTo(a.hargaproduk));
      break;
    case SortProductBy.namaAtoZ:
      sortedProducts.sort(
        (a, b) => _naturalCompare(a.namaproduk, b.namaproduk),
      );
      break;
    case SortProductBy.namaZtoA:
      sortedProducts.sort(
        (a, b) => _naturalCompare(b.namaproduk, a.namaproduk),
      );
      break;
  }

  return sortedProducts;
}

extension SortProductByExtension on SortProductBy {
  String get displayName {
    switch (this) {
      case SortProductBy.hargaTerendah:
        return 'Harga Terendah';
      case SortProductBy.hargaTertinggi:
        return 'Harga Tertinggi';
      case SortProductBy.namaAtoZ:
        return 'Nama A-Z';
      case SortProductBy.namaZtoA:
        return 'Nama Z-A';
    }
  }

  IconData get iconData {
    switch (this) {
      case SortProductBy.hargaTerendah:
        return MdiIcons.sortNumericDescending;
      case SortProductBy.hargaTertinggi:
        return MdiIcons.sortNumericAscending;
      case SortProductBy.namaAtoZ:
        return MdiIcons.sortAlphabeticalDescending;
      case SortProductBy.namaZtoA:
        return MdiIcons.sortAlphabeticalAscending;
    }
  }
}

int _naturalCompare(String a, String b) {
  final RegExp regex = RegExp(r'(\d+)|(\D+)');
  final List<String> aParts = regex
      .allMatches(a)
      .map((m) => m.group(0)!)
      .toList();
  final List<String> bParts = regex
      .allMatches(b)
      .map((m) => m.group(0)!)
      .toList();

  for (int i = 0; i < aParts.length && i < bParts.length; i++) {
    final String aPart = aParts[i];
    final String bPart = bParts[i];

    // Jika keduanya angka, compare sebagai number
    final int? aNum = int.tryParse(aPart);
    final int? bNum = int.tryParse(bPart);

    if (aNum != null && bNum != null) {
      final int result = aNum.compareTo(bNum);
      if (result != 0) return result;
    } else {
      // Compare sebagai string
      final int result = aPart.compareTo(bPart);
      if (result != 0) return result;
    }
  }

  // Jika semua part sama, yang lebih pendek di depan
  return aParts.length.compareTo(bParts.length);
}
