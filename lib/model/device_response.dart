import 'package:dmpku/core/helpers/date_helper.dart';

class DeviceModel {
  final String perangkat;
  final int jenisperangkat;
  final String keterangan;
  final String waktuditambah;
  final String alamat;

  const DeviceModel({
    required this.perangkat,
    required this.jenisperangkat,
    required this.keterangan,
    required this.waktuditambah,
    this.alamat = 'Sedang memuat...',
  });

  factory DeviceModel.fromJson(Map<String, dynamic>? json) {
    return DeviceModel(
      perangkat: json?['perangkat'] ?? '',
      jenisperangkat: json?['jenisperangkat'] ?? 0,
      keterangan: json?['keterangan'] ?? '',
      waktuditambah: json?['waktuditambah'] ?? '',
      alamat: json?['alamat'] ?? 'Sedang memuat...',
    );
  }

  DeviceModel copyWith({
    String? perangkat,
    int? jenisperangkat,
    String? keterangan,
    String? waktuditambah,
    String? alamat,
  }) {
    return DeviceModel(
      perangkat: perangkat ?? this.perangkat,
      jenisperangkat: jenisperangkat ?? this.jenisperangkat,
      keterangan: keterangan ?? this.keterangan,
      waktuditambah: waktuditambah ?? this.waktuditambah,
      alamat: alamat ?? this.alamat
    );
  }

  bool get isNumber => jenisperangkat == 1;

  List<String> get _parts => keterangan.split(' - ');

  String? get device => _parts.elementAtOrNull(0);
  String? get version => _parts.elementAtOrNull(1);
  String? get app => _parts.elementAtOrNull(2);
  String? get loc => _parts.elementAtOrNull(3);

  String get formatWaktuDitambah {
    try {
      final datetime = DateTime.parse(waktuditambah);
      return DateHelper.formatSimpleDate(datetime) + ' ' + DateHelper.formatTime(datetime);
    } catch (e) {
      return waktuditambah;
    }
  }

  bool get isMitrakonter => app?.toLowerCase() == 'mitrakonter';

  bool get isDmpku => app?.toLowerCase() == 'dmpku';

  String? get lat {
    if (loc == null) return null;
    final parts = loc!.split(',');
    return parts.elementAtOrNull(0);
  }

  String? get long {
    if (loc == null) return null;
    final parts = loc!.split(',');
    return parts.elementAtOrNull(1);
  }

  @override
  String toString() {
    return 'DeviceModel(perangkat: $perangkat, jenisperangkat: $jenisperangkat, keterangan: $keterangan, waktuditambah: $waktuditambah, alamat: $alamat)';
  }
}

const DEFAULT_DEVICE_MODEL = DeviceModel(
  perangkat: '',
  jenisperangkat: 0,
  keterangan: '',
  waktuditambah: '',
  alamat: 'Sedang memuat...',
);

class ListDeviceResponse {
  final List<DeviceModel> devices;

  const ListDeviceResponse({required this.devices});

  factory ListDeviceResponse.fromJson(List<dynamic>? json) {
    final List<DeviceModel> dataList = [];

    if (json is List && json.isNotEmpty) {
      for (final el in json) {
        dataList.add(DeviceModel.fromJson(el));
      }
    }

    return ListDeviceResponse(devices: dataList);
  }

  @override
  String toString() {
    return 'ListDeviceResponse(devices: $devices)';
  }
}
