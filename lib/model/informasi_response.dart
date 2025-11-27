class Info {
  final String desc;
  final String icon;
  final String key;
  final String value;

  Info({
    required this.desc,
    required this.icon,
    required this.key,
    required this.value,
  });

  factory Info.fromJson(Map json) {
    return Info(
      desc: json['desc'] ?? '',
      icon: json['icon'] ?? '',
      key: json['key'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'desc': desc, 'icon': icon, 'key': key, 'value': value};
  }
}

class InformasiResponse {
  final List<Info> chanel;
  final List<Info> cs;
  final List<Info> panduan;
  final List<Info> playstore;
  final List<Info> sosmed;
  final List<Info> syaratketentuan;
  final List<Info> website;
  final bool status;

  InformasiResponse({
    required this.chanel,
    required this.cs,
    required this.panduan,
    required this.playstore,
    required this.sosmed,
    required this.syaratketentuan,
    required this.website,
    required this.status,
  });

  factory InformasiResponse.fromJson(Map? json) {
    var infoResponse = InformasiResponse(
      chanel: [],
      cs: [],
      panduan: [],
      playstore: [],
      sosmed: [],
      syaratketentuan: [],
      website: [],
      status: json?['status'] ?? false,
    );

    List<Info> parseInfoList(dynamic data) {
      if (data is List) {
        return data.map((e) => Info.fromJson(e)).toList();
      }
      return [];
    }

    if (json != null) {
      if (json["chanel"] is List) {
        infoResponse.chanel.addAll(parseInfoList(json['chanel']));
      }

      if (json["cs"] is List) {
        infoResponse.cs.addAll(parseInfoList(json['cs']));
      }

      if (json["panduan"] is List) {
        infoResponse.panduan.addAll(parseInfoList(json['panduan']));
      }

      if (json["playstore"] is List) {
        infoResponse.playstore.addAll(parseInfoList(json['playstore']));
      }

      if (json["sosmed"] is List) {
        infoResponse.sosmed.addAll(parseInfoList(json['sosmed']));
      }

      if (json["syaratketentuan"] is List) {
        infoResponse.syaratketentuan.addAll(
          parseInfoList(json['syaratketentuan']),
        );
      }

      if (json["website"] is List) {
        infoResponse.website.addAll(parseInfoList(json['website']));
      }
    }

    return infoResponse;

  }
}
