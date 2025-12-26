class BankTransferModel {
  // deskripsi: string
  // icon: string
  // idbank: number
  // key: string
  // status: number
  // value: string

  final String deskripsi;
  final String icon;
  final int idbank;
  final String key;
  final int status;
  final String value;

  const BankTransferModel({
    required this.deskripsi,
    required this.icon,
    required this.idbank,
    required this.key,
    required this.status,
    required this.value,
  });

  factory BankTransferModel.fromJson(Map<String, dynamic>? json) {
    return BankTransferModel(
      deskripsi: json?['deskripsi'] ?? '',
      icon: json?['icon'] ?? '',
      idbank: json?['idbank'] ?? 0,
      key: json?['key'] ?? '',
      status: json?['status'] ?? 0,
      value: json?['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsi': deskripsi,
      'icon': icon,
      'idbank': idbank,
      'key': key,
      'status': status,
      'value': value,
    };
  }

  BankTransferModel copyWith({
    String? deskripsi,
    String? icon,
    int? idbank,
    String? key,
    int? status,
    String? value,
  }) {
    return BankTransferModel(
      deskripsi: deskripsi ?? this.deskripsi,
      icon: icon ?? this.icon,
      idbank: idbank ?? this.idbank,
      key: key ?? this.key,
      status: status ?? this.status,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'BankTransferModel(deskripsi: $deskripsi, icon: $icon, idbank: $idbank, key: $key, status: $status, value: $value)';
  }
}

const DEFAULT_BANK_TRANSFER_MODEL = BankTransferModel(
  deskripsi: '',
  icon: '',
  idbank: 0,
  key: '',
  status: 0,
  value: '',
);

class BankTransferResponse {
  final List<BankTransferModel> banks;

  const BankTransferResponse({required this.banks});

  factory BankTransferResponse.fromJson(List<dynamic>? json) {
    List<BankTransferModel> banks = [];
    if (json != null) {
      banks = json
          .map((bankJson) => BankTransferModel.fromJson(bankJson))
          .toList();
    }
    return BankTransferResponse(banks: banks);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': banks.map((bank) => bank.toJson()).toList(),
    };
  }
}

class VaBankModel {
  final int admin;
  final String deskripsi;
  final String icon;
  final int idbank;
  final String key;
  final int status;
  final String value;

  const VaBankModel({
    required this.admin,
    required this.deskripsi,
    required this.icon,
    required this.idbank,
    required this.key,
    required this.status,
    required this.value,
  });

  factory VaBankModel.fromJson(Map<String, dynamic>? json) {
    return VaBankModel(
      admin: json?['admin'] ?? 0,
      deskripsi: json?['deskripsi'] ?? '',
      icon: json?['icon'] ?? '',
      idbank: json?['idbank'] ?? 0,
      key: json?['key'] ?? '',
      status: json?['status'] ?? 0,
      value: json?['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admin': admin,
      'deskripsi': deskripsi,
      'icon': icon,
      'idbank': idbank,
      'key': key,
      'status': status,
      'value': value,
    };
  }

  VaBankModel copyWith({
    int? admin,
    String? deskripsi,
    String? icon,
    int? idbank,
    String? key,
    int? status,
    String? value,
  }) {
    return VaBankModel(
      admin: admin ?? this.admin,
      deskripsi: deskripsi ?? this.deskripsi,
      icon: icon ?? this.icon,
      idbank: idbank ?? this.idbank,
      key: key ?? this.key,
      status: status ?? this.status,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'VaBankModel(admin: $admin, deskripsi: $deskripsi, icon: $icon, idbank: $idbank, key: $key, status: $status, value: $value)';
  }
}

class VaBankResponse {
  final List<VaBankModel> banks;

  const VaBankResponse({required this.banks});

  factory VaBankResponse.fromJson(List<dynamic>? json) {
    List<VaBankModel> banks = [];
    if (json != null) {
      banks = json
          .map((bankJson) => VaBankModel.fromJson(bankJson))
          .toList();
    }
    return VaBankResponse(banks: banks);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': banks.map((bank) => bank.toJson()).toList(),
    };
  }
}
