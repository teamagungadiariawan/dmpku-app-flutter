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
      idprovider: (json['idprovider'] ?? 0) as int,
      kodeprovider: (json['kodeprovider'] ?? '') as String,
      namaprovider: (json['namaprovider'] ?? '') as String,
      deskripsiprovider: (json['deskripsiprovider'] ?? '') as String,
      prefix: (json['prefix'] ?? '') as String,
      mintujuan: (json['mintujuan'] ?? 0) as int,
      maxtujuan: (json['maxtujuan'] ?? 0) as int,
      urutanprovider: (json['urutanprovider'] ?? 0) as int,
      tipepajak: (json['tipepajak'] ?? 0) as int,
      imgprovider: (json['imgprovider'] ?? '') as String,
      tipeinput: (json['tipeinput'] ?? '') as String,
      statusprovider: (json['statusprovider'] ?? 0) as int,
      imglocal: null, // not deserialized from JSON
    );
  }

  List<String> get prefixList {
    return prefix.split(',').map((e) => e.trim()).toList();
  }

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
