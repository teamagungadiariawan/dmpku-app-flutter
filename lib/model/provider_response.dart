import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:flutter/widgets.dart';

class ProviderModel {
  final int idprovider;
  final String kodeprovider;
  final String namaprovider;
  final String deskripsiprovider;
  final String prefix; // can be String or List<String>
  final int mintujuan;
  final int maxtujuan;
  final int urutanprovider;
  final int tipepajak;
  final String imgprovider;
  final String tipeinput;
  final int statusprovider;
  final ImageProvider? imglocal;

  const ProviderModel({
    required this.idprovider,
    required this.kodeprovider,
    required this.namaprovider,
    required this.deskripsiprovider,
    required this.prefix,
    required this.mintujuan,
    required this.maxtujuan,
    required this.urutanprovider,
    required this.tipepajak,
    required this.imgprovider,
    required this.tipeinput,
    required this.statusprovider,
    this.imglocal,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      idprovider: json['idprovider'] ?? 0,
      kodeprovider: json['kodeprovider'] ?? '',
      namaprovider: json['namaprovider'] ?? '',
      deskripsiprovider: json['deskripsiprovider'] ?? '',
      prefix: json['prefix'] ?? '',
      mintujuan: json['mintujuan'] ?? 0,
      maxtujuan: json['maxtujuan'] ?? 0,
      urutanprovider: json['urutanprovider'] ?? 0,
      tipepajak: json['tipepajak'] ?? 0,
      imgprovider: json['imgprovider'] ?? '',
      tipeinput: json['tipeinput'] ?? '',
      statusprovider: json['statusprovider'] ?? 0,
      imglocal: null,
    );
  }

  List<String> get prefixList {
    return prefix.split(',').map((e) => e.trim()).toList();
  }

  TipeInput get inputTipe => TipeInput.fromValue(tipeinput);

  Map<String, dynamic> toJson() {
    return {
      'idprovider': idprovider,
      'kodeprovider': kodeprovider,
      'namaprovider': namaprovider,
      'deskripsiprovider': deskripsiprovider,
      'prefix': prefix,
      'mintujuan': mintujuan,
      'maxtujuan': maxtujuan,
      'urutanprovider': urutanprovider,
      'tipepajak': tipepajak,
      'imgprovider': imgprovider,
      'tipeinput': tipeinput,
      'statusprovider': statusprovider,
      // imglocal intentionally omitted (not JSON serializable)
    };
  }

  ProviderModel copyWith({
    int? idprovider,
    String? kodeprovider,
    String? namaprovider,
    String? deskripsiprovider,
    String? prefix,
    int? mintujuan,
    int? maxtujuan,
    int? urutanprovider,
    int? tipepajak,
    String? imgprovider,
    String? tipeinput,
    int? statusprovider,
    ImageProvider? imglocal,
  }) {
    return ProviderModel(
      idprovider: idprovider ?? this.idprovider,
      kodeprovider: kodeprovider ?? this.kodeprovider,
      namaprovider: namaprovider ?? this.namaprovider,
      deskripsiprovider: deskripsiprovider ?? this.deskripsiprovider,
      prefix: prefix ?? this.prefix,
      mintujuan: mintujuan ?? this.mintujuan,
      maxtujuan: maxtujuan ?? this.maxtujuan,
      urutanprovider: urutanprovider ?? this.urutanprovider,
      tipepajak: tipepajak ?? this.tipepajak,
      imgprovider: imgprovider ?? this.imgprovider,
      tipeinput: tipeinput ?? this.tipeinput,
      statusprovider: statusprovider ?? this.statusprovider,
      imglocal: imglocal ?? this.imglocal,
    );
  }

  @override
  String toString() {
    return 'ProviderModel(idprovider: $idprovider, kodeprovider: $kodeprovider, namaprovider: $namaprovider)';
  }
}

class ListProviderResponse {
  final List<ProviderModel> providerList;

  ListProviderResponse({required this.providerList});

  factory ListProviderResponse.fromJson(List<dynamic>? json) {
    final List<ProviderModel> dataList = [];

    if (json is List && json.isNotEmpty) {
      for (final el in json) {
        dataList.add(ProviderModel.fromJson(el));
      }
    }

    return ListProviderResponse(providerList: dataList);
  }

  Map<String, dynamic> toJson() {
    return {"data": providerList.map((e) => e.toJson()).toList()};
  }
}

class TopupGameProviderResponse {
  final List<ProviderModel> topupgame;
  final List<ProviderModel> vouchergame;

  TopupGameProviderResponse({
    required this.topupgame,
    required this.vouchergame,
  });

  factory TopupGameProviderResponse.fromJson(Map<String, dynamic>? json) {
    final List<ProviderModel> topupgameList = [];
    final List<ProviderModel> vouchergameList = [];

    if (json != null) {
      if (json["topupgame"] is List) {
        for (final el in json["topupgame"]) {
          topupgameList.add(ProviderModel.fromJson(el));
        }
      }

      if (json["vouchergame"] is List) {
        for (final el in json["vouchergame"]) {
          vouchergameList.add(ProviderModel.fromJson(el));
        }
      }
    }

    return TopupGameProviderResponse(
      topupgame: topupgameList,
      vouchergame: vouchergameList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "topupgame": topupgame.map((e) => e.toJson()).toList(),
        "vouchergame": vouchergame.map((e) => e.toJson()).toList(),
      },
    };
  }
}

class DompetDigitalResponse {
  final List<ProviderModel> nominalpilihan;
  final List<ProductModel> nominalbebas;

  DompetDigitalResponse({
    required this.nominalpilihan,
    required this.nominalbebas,
  });

  factory DompetDigitalResponse.fromJson(Map<String, dynamic>? json) {
    final List<ProviderModel> nominalpilihanList = [];
    final List<ProductModel> nominalbebasList = [];

    if (json != null) {
      if (json["nominalpilihan"] is List) {
        for (final el in json["nominalpilihan"]) {
          nominalpilihanList.add(ProviderModel.fromJson(el));
        }
      }

      if (json["nominalbebas"] is List) {
        for (final el in json["nominalbebas"]) {
          nominalbebasList.add(ProductModel.fromJson(el));
        }
      }
    }

    return DompetDigitalResponse(
      nominalpilihan: nominalpilihanList,
      nominalbebas: nominalbebasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "nominalpilihan": nominalpilihan.map((e) => e.toJson()).toList(),
        "nominalbebas": nominalbebas.map((e) => e.toJson()).toList(),
      },
    };
  }
}

class PlnTagihanResponse {
  final ProductModel plnnontaglist;
  final ProductModel plnpasca;

  const PlnTagihanResponse({
    required this.plnnontaglist,
    required this.plnpasca,
  });

  factory PlnTagihanResponse.fromJson(Map<String, dynamic>? json) {
    return PlnTagihanResponse(
      plnnontaglist: ProductModel.fromJson(json?['plnnontaglist'] ?? {}),
      plnpasca: ProductModel.fromJson(json?['plnpasca'] ?? {}),
    );
  }

  PlnTagihanResponse copyWith({
    ProductModel? plnnontaglist,
    ProductModel? plnpasca,
  }) {
    return PlnTagihanResponse(
      plnnontaglist: plnnontaglist ?? this.plnnontaglist,
      plnpasca: plnpasca ?? this.plnpasca,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "plnnontaglist": plnnontaglist.toJson(),
      "plnpasca": plnpasca.toJson(),
    };
  }

  String toString() {
    return 'PlnTagihanResponse(plnnontaglist: $plnnontaglist, plnpasca: $plnpasca)';
  }
}

class TagihanGasResponse {
  final ProductModel pertagaspasca;
  final ProductModel pgnpasca;

  const TagihanGasResponse({
    required this.pertagaspasca,
    required this.pgnpasca,
  });

  factory TagihanGasResponse.fromJson(Map<String, dynamic>? json) {
    return TagihanGasResponse(
      pertagaspasca: ProductModel.fromJson(json?['pertagaspasca'] ?? {}),
      pgnpasca: ProductModel.fromJson(json?['pgnpasca'] ?? {}),
    );
  }

  TagihanGasResponse copyWith({
    ProductModel? pertagaspasca,
    ProductModel? pgnpasca,
  }) {
    return TagihanGasResponse(
      pertagaspasca: pertagaspasca ?? this.pertagaspasca,
      pgnpasca: pgnpasca ?? this.pgnpasca,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "plnnontaglist": pertagaspasca.toJson(),
      "plnpasca": pgnpasca.toJson(),
    };
  }

  String toString() {
    return 'TagihanGasResponse(plnnontaglist: $pertagaspasca, plnpasca: $pgnpasca)';
  }
}

const ProviderModel DEFAULT_PROVIDER = ProviderModel(
  idprovider: 0,
  kodeprovider: '',
  namaprovider: '',
  deskripsiprovider: '',
  prefix: '',
  mintujuan: 0,
  maxtujuan: 0,
  urutanprovider: 0,
  tipepajak: 0,
  imgprovider: '',
  tipeinput: '',
  statusprovider: 0,
  imglocal: null,
);
