class CatatanModel {
  final int idcatatan;
  final String kodemember;
  final String judul;
  final String isicatatan;
  final int prioritas;

  const CatatanModel({
    required this.idcatatan,
    required this.kodemember,
    required this.judul,
    required this.isicatatan,
    required this.prioritas,
  });

  factory CatatanModel.fromJson(Map<String, dynamic> json) {
    return CatatanModel(
      idcatatan: json['idcatatan'] ?? 0,
      kodemember: json['kodemember'] ?? '',
      judul: (json['judul'] ?? '').replaceAll('@&#', '\n'),
      isicatatan: (json['isicatatan'] ?? '').replaceAll('@&#', '\n'),
      prioritas: json['prioritas'] is String
          ? int.tryParse(json['prioritas']) ?? 0
          : json['prioritas'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idcatatan': idcatatan,
      'kodemember': kodemember,
      'judul': judul.replaceAll('\n', '@&#'),
      'isicatatan': isicatatan.replaceAll('\n', '@&#'),
      'prioritas': prioritas,
    };
  }
}

class ListCatatanResponse {
  final List<CatatanModel> catatan;

  ListCatatanResponse({required this.catatan});

  factory ListCatatanResponse.fromJson(List<dynamic>? json) {
    if (json == null) {
      return ListCatatanResponse(catatan: []);
    }
    return ListCatatanResponse(
      catatan: json.map((x) => CatatanModel.fromJson(x)).toList(),
    );
  }
}

class TambahCatatanPayload {
  final String kodemember;
  final String judul;
  final String isicatatan;
  final int perioritas;

  TambahCatatanPayload({
    required this.kodemember,
    required this.judul,
    required this.isicatatan,
    required this.perioritas,
  });

  Map<String, dynamic> toJson() {
    return {
      'kodemember': kodemember,
      'judul': judul.trim().replaceAll('\n', '@&#'),
      'isicatatan': isicatatan.trim().replaceAll('\n', '@&#'),
      'perioritas': perioritas,
    };
  }
}

class UbahCatatanPayload {
  final int idcatatan;
  final String kodemember;
  final String judul;
  final String isicatatan;
  final int perioritas;

  UbahCatatanPayload({
    required this.idcatatan,
    required this.kodemember,
    required this.judul,
    required this.isicatatan,
    required this.perioritas,
  });

  Map<String, dynamic> toJson() {
    return {
      'idcatatan': idcatatan,
      'kodemember': kodemember,
      'judul': judul.trim().replaceAll('\n', '@&#'),
      'isicatatan': isicatatan.trim().replaceAll('\n', '@&#'),
      'perioritas': perioritas,
    };
  }
}

class HapusCatatanPayload {
  final int idcatatan;
  final String kodemember;

  HapusCatatanPayload({required this.idcatatan, required this.kodemember});

  Map<String, dynamic> toJson() {
    return {'idcatatan': idcatatan, 'kodemember': kodemember};
  }
}
