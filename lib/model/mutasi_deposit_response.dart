import 'package:dmpku/core/helpers/date_helper.dart';

class MutasiDepositModel {
  final String waktu_mutasi;
  final String keterangan;
  final int mutasi;
  final int saldo;

  const MutasiDepositModel({
    required this.waktu_mutasi,
    required this.keterangan,
    required this.mutasi,
    required this.saldo,
  });

  factory MutasiDepositModel.fromJson(Map<String, dynamic>? json) {
    return MutasiDepositModel(
      waktu_mutasi: json?['waktu_mutasi'] ?? '',
      keterangan: json?['keterangan'] ?? '',
      mutasi: json?['mutasi'] ?? 0,
      saldo: json?['saldo'] ?? 0,
    );
  }

  MutasiDepositModel copyWith({
    String? waktu_mutasi,
    String? keterangan,
    int? mutasi,
    int? saldo,
  }) {
    return MutasiDepositModel(
      waktu_mutasi: waktu_mutasi ?? this.waktu_mutasi,
      keterangan: keterangan ?? this.keterangan,
      mutasi: mutasi ?? this.mutasi,
      saldo: saldo ?? this.saldo,
    );
  }

  @override
  String toString() {
    return 'MutasiDepositModel(waktu_mutasi: $waktu_mutasi, keterangan: $keterangan, mutasi: $mutasi, saldo: $saldo)';
  }
}

const DEFAULT_MUTASI_DEPOSIT_MODEL = MutasiDepositModel(
  waktu_mutasi: '',
  keterangan: '',
  mutasi: 0,
  saldo: 0,
);

class MutasiDepositResponse {
  final List<MutasiDepositModel> data;
  final String message;
  final bool status;

  const MutasiDepositResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory MutasiDepositResponse.fromJson(Map<String, dynamic>? json) {
    final List<MutasiDepositModel> dataList = [];

    final data = json?['data'];

    final message = json?["message"] ?? "";
    final status = json?["status"] ?? false;

    if (data is List && data.isNotEmpty) {
      for (final el in data) {
        dataList.add(MutasiDepositModel.fromJson(el));
      }
    }

    return MutasiDepositResponse(
      data: dataList,
      message: message,
      status: status,
    );
  }

  @override
  String toString() {
    return 'MutasiDepositResponse(data: $data, message: $message, status: $status)';
  }
}

class GroupedMutasiDepositModel {
  final String tanggal;
  final List<MutasiDepositModel> mutasiList;

  const GroupedMutasiDepositModel({
    required this.tanggal,
    required this.mutasiList,
  });

  @override
  String toString() {
    return 'GroupedMutasiDepositModel(tanggal: $tanggal, mutasiList: $mutasiList)';
  }
}

class ListGroupedMutasiDepositResponse {
  final List<GroupedMutasiDepositModel> groupedMutasiList;

  const ListGroupedMutasiDepositResponse({required this.groupedMutasiList});

  factory ListGroupedMutasiDepositResponse.fromListMutasiResponse(
    List<MutasiDepositModel> listMutasi,
  ) {
    final Map<String, List<MutasiDepositModel>> groupedMap = {};

    // Sort list by date descending first (optional but good practice)
    // Assuming listMutasi is already sorted or we sort it here.
    // listMutasi.sort((a, b) => b.waktu_mutasi.compareTo(a.waktu_mutasi));

    for (var mutasi in listMutasi) {
      // Use tryParse to handle potential invalid dates safely, though model guarantees string
      DateTime? dtime;
      try {
        dtime = DateTime.parse(mutasi.waktu_mutasi);
      } catch (e) {
        // Fallback or skip
        continue;
      }

      final tanggal = DateHelper.formatSimpleDate(dtime);

      if (!groupedMap.containsKey(tanggal)) {
        groupedMap[tanggal] = [];
      }
      groupedMap[tanggal]!.add(mutasi);
    }

    final List<GroupedMutasiDepositModel> groupedList = groupedMap.entries
        .map(
          (entry) => GroupedMutasiDepositModel(
            tanggal: entry.key,
            mutasiList: entry.value,
          ),
        )
        .toList();

    return ListGroupedMutasiDepositResponse(groupedMutasiList: groupedList);
  }

  @override
  String toString() {
    return 'ListGroupedMutasiDepositResponse(groupedMutasiList: $groupedMutasiList)';
  }
}

const ListGroupedMutasiDepositResponse
DEFAULT_LIST_GROUPED_MUTASI_DEPOSIT_RESPONSE = ListGroupedMutasiDepositResponse(
  groupedMutasiList: [],
);
