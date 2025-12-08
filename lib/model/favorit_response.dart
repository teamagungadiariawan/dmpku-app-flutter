class FavoritModel {
  final int idfavorit;
  final String kodemember;
  final String nama;
  final String nomor;
  final int idkategori;
  final String namakategori;

  const FavoritModel({
    required this.idfavorit,
    required this.kodemember,
    required this.nama,
    required this.nomor,
    required this.idkategori,
    required this.namakategori,
  });

  factory FavoritModel.fromJson(Map<String, dynamic> json) {
    return FavoritModel(
      idfavorit: json['idfavorit'] ?? 0,
      kodemember: json['kodemember'] ?? '',
      nama: json['nama'] ?? '',
      nomor: json['nomor'] ?? '',
      idkategori: json['idkategori'] ?? 0,
      namakategori: json['namakategori'] ?? '',
    );
  }

  FavoritModel copyWith({
    int? idfavorit,
    String? kodemember,
    String? nama,
    String? nomor,
    int? idkategori,
    String? namakategori,
  }) {
    return FavoritModel(
      idfavorit: idfavorit ?? this.idfavorit,
      kodemember: kodemember ?? this.kodemember,
      nama: nama ?? this.nama,
      nomor: nomor ?? this.nomor,
      idkategori: idkategori ?? this.idkategori,
      namakategori: namakategori ?? this.namakategori,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idfavorit': idfavorit,
      'kodemember': kodemember,
      'nama': nama,
      'nomor': nomor,
      'idkategori': idkategori,
      'namakategori': namakategori,
    };
  }
}

class ListFavoritResponse {
  List<FavoritModel> favorit;

  ListFavoritResponse({required this.favorit});

  factory ListFavoritResponse.fromJson(List<dynamic>? json) {
    if (json == null) {
      return ListFavoritResponse(favorit: []);
    }
    List<FavoritModel> favoritList = json
        .map((item) => FavoritModel.fromJson(item))
        .toList();
    return ListFavoritResponse(favorit: favoritList);
  }

  Map<String, dynamic> toJson() {
    return {'favorit': favorit.map((item) => item.toJson()).toList()};
  }
}

const DEFAULT_FAVORIT = FavoritModel(
  idfavorit: 0,
  kodemember: '',
  nama: '',
  nomor: '',
  idkategori: 0,
  namakategori: '',
);
