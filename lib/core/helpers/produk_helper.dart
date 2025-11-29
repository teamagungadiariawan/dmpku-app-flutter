import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

enum TypeInfoProduk { waktu, info, lead, zona }

extension TypeInfoProdukExtension on TypeInfoProduk {
  String get name {
    switch (this) {
      case TypeInfoProduk.waktu:
        return 'waktu';
      case TypeInfoProduk.info:
        return 'info';
      case TypeInfoProduk.lead:
        return 'lead';
      case TypeInfoProduk.zona:
        return 'zona';
    }
  }

  IconData get icon {
    switch (this) {
      case TypeInfoProduk.waktu:
        return MdiIcons.calendarClock;
      case TypeInfoProduk.info:
        return MdiIcons.informationOutline;
      case TypeInfoProduk.lead:
        return MdiIcons.web;
      case TypeInfoProduk.zona:
        return MdiIcons.earth;
    }
  }
}

class KeyValuePair {
  final TypeInfoProduk type;
  final String value;

  KeyValuePair({required this.type, required this.value});

  Map<String, dynamic> toJson() => {'type': type.name, 'value': value};
}

class ReformattedDesc {
  final bool format;
  final String info;
  final List<KeyValuePair> keyValuePairs;

  ReformattedDesc({
    required this.format,
    required this.info,
    required this.keyValuePairs,
  });

  Map<String, dynamic> toJson() => {
    'format': format,
    'info': info,
    'keyValuePairs': keyValuePairs.map((e) => e.toJson()).toList(),
  };
}

String _removeSpaceAndNewline(String text) {
  return text.replaceAll(RegExp(r'\s+'), ' ').trim();
}

ReformattedDesc getInfoProduk(String desc) {
  final isFormat = desc.contains('#');

  if (!isFormat) {
    return ReformattedDesc(format: false, info: desc, keyValuePairs: []);
  }

  final lines = desc.split('#');
  final List<KeyValuePair> keyValuePairs = [];

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    if (line.length <= 2) {
      continue;
    }

    // Determine type
    TypeInfoProduk type;

    if (i == 0) {
      type = TypeInfoProduk.lead;
    } else if (i == lines.length - 1) {
      type = TypeInfoProduk.waktu;
    } else {
      type = TypeInfoProduk.info;
    }

    // Check content untuk override type
    final ln = _removeSpaceAndNewline(line).toLowerCase();

    if (ln.contains('aktif')) {
      type = TypeInfoProduk.waktu;
    } else if (ln.contains('zona') || ln.contains('wilayah')) {
      type = TypeInfoProduk.zona;
    }

    // Debug log (gunakan debugPrint di Flutter)
    debugPrint('type: ${type.name}, line: $ln');

    keyValuePairs.add(KeyValuePair(type: type, value: line));
  }

  return ReformattedDesc(
    format: true,
    info: desc,
    keyValuePairs: keyValuePairs,
  );
}
