import 'package:flutter/cupertino.dart';

extension DateTimeExtension on DateTime {
  int get unixTimestamp => toUtc().millisecondsSinceEpoch ~/ 1000;

  /// Format ke ISO 8601 dengan timezone Z (UTC)
  /// Contoh: "2025-11-27T02:30:38.235Z"
  String toIso8601StringZ() => toUtc().toIso8601String();
}

class DateHelper {
  static int currentUnixTimestamp() => DateTime.now().unixTimestamp;

  static int toUnixTimestamp(DateTime dt) => dt.unixTimestamp;

  static DateTime? tryParse(String dateString) {
    try {
      return DateTime.parse(dateString).toLocal();
    } catch (_) {
      return null;
    }
  }

  /// Format DateTime ke ISO 8601 dengan timezone Z (UTC)
  /// Contoh: "2025-11-27T02:30:38.235Z"
  static String toIso8601StringZ(DateTime dt) => dt.toIso8601StringZ();

  /// Format DateTime saat ini ke ISO 8601 dengan timezone Z (UTC)
  /// Contoh: "2025-11-27T02:30:38.235Z"
  static String currentIso8601StringZ() => DateTime.now().toIso8601StringZ();
}
