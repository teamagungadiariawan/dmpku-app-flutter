import 'package:dmpku/model/product_response.dart';

class ProductCuanModel {
  final String detailpaket;
  final int hargapaket;
  final String kodepaket;
  final String namapaket;
  final String hashpaket;

  const ProductCuanModel({
    required this.detailpaket,
    required this.hargapaket,
    required this.kodepaket,
    required this.namapaket,
    required this.hashpaket,
  });

  factory ProductCuanModel.fromJson(Map<String, dynamic> json) =>
      ProductCuanModel(
        detailpaket: json['detailpaket'] ?? '',
        hargapaket: json['hargapaket'] ?? 0,
        kodepaket: json['kodepaket'] ?? '',
        namapaket: json['namapaket'] ?? '',
        hashpaket: json['hashpaket'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'detailpaket': detailpaket,
    'hargapaket': hargapaket,
    'kodepaket': kodepaket,
    'namapaket': namapaket,
    'hashpaket': hashpaket,
  };

  ProductCuanModel copyWith({
    String? detailpaket,
    int? hargapaket,
    String? kodepaket,
    String? namapaket,
    String? hashpaket,
  }) {
    return ProductCuanModel(
      detailpaket: detailpaket ?? this.detailpaket,
      hargapaket: hargapaket ?? this.hargapaket,
      kodepaket: kodepaket ?? this.kodepaket,
      namapaket: namapaket ?? this.namapaket,
      hashpaket: hashpaket ?? this.hashpaket,
    );
  }

  @override
  String toString() {
    return 'ProductCuanModel(detailpaket: $detailpaket, hargapaket: $hargapaket, kodepaket: $kodepaket, namapaket: $namapaket, hashpaket: $hashpaket)';
  }
}

class ListProductCuanResponse {
  final List<ProductCuanModel> products;

  const ListProductCuanResponse({required this.products});

  factory ListProductCuanResponse.fromJson(List<dynamic>? json) {
    final List<ProductCuanModel> products = [];
    if (json is List && json.isNotEmpty) {
      for (var item in json) {
        products.add(ProductCuanModel.fromJson(item));
      }
    }
    return ListProductCuanResponse(products: products);
  }

  Map<String, dynamic> toJson() {
    return {'products': products.map((e) => e.toJson()).toList()};
  }
}

const ProductCuanModel DEFAULT_PRODUCT_CUAN = ProductCuanModel(
  detailpaket: '',
  hargapaket: 0,
  kodepaket: '',
  namapaket: '',
  hashpaket: '',
);

List<ProductCuanModel> sortProductCuan(
  List<ProductCuanModel> products,
  SortProductBy sortBy,
) {
  List<ProductCuanModel> sortedProducts = List.from(products);

  switch (sortBy) {
    case SortProductBy.hargaTerendah:
      sortedProducts.sort((a, b) => a.hargapaket.compareTo(b.hargapaket));
      break;
    case SortProductBy.hargaTertinggi:
      sortedProducts.sort((a, b) => b.hargapaket.compareTo(a.hargapaket));
      break;
    case SortProductBy.namaAtoZ:
      sortedProducts.sort((a, b) => a.namapaket.compareTo(b.namapaket));
      break;
    case SortProductBy.namaZtoA:
      sortedProducts.sort((a, b) => b.namapaket.compareTo(a.namapaket));
      break;
  }

  return sortedProducts;
}
