import 'package:flutter/cupertino.dart';

extension DateTimeExtension on DateTime {
  int get unixTimestamp => toUtc().millisecondsSinceEpoch ~/ 1000;

  String toIso8601StringZ() => toUtc().toIso8601String();

  Duration get durationFromNow => DateTime.now().difference(this);

  Duration get durationUntilNow => difference(DateTime.now());
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

  static String toIso8601StringZ(DateTime dt) => dt.toIso8601StringZ();

  static String currentIso8601StringZ() => DateTime.now().toIso8601StringZ();

  static Duration? durationFromString(String dateString) {
    final dt = tryParse(dateString);
    if (dt == null) return null;
    return DateTime.now().difference(dt);
  }

  /// Hitung durasi countdown dari string ISO 8601
  /// Return Duration positif jika waktu belum tercapai, negatif jika sudah lewat
  static Duration? countdownFromString(String dateString) {
    final dt = tryParse(dateString);
    if (dt == null) return null;
    return dt.difference(DateTime.now());
  }

  /// Format countdown ke "HH:mm:ss"
  /// Contoh: "02:30:15"
  static String formatCountdown(Duration d) {
    if (d.isNegative) return '00:00:00';

    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  /// Format countdown dengan hari "Xd HH:mm:ss"
  /// Contoh: "3d 02:30:15" atau "02:30:15"
  static String formatCountdownWithDays(Duration d) {
    if (d.isNegative) return '00:00:00';

    final days = d.inDays;
    final hours = d.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (days > 0) {
      return '${days}d $hours:$minutes:$seconds';
    }
    return '$hours:$minutes:$seconds';
  }

  /// Format countdown ke text readable
  /// Contoh: "2 hari 3 jam 30 menit 15 detik"
  static String formatCountdownText(Duration d) {
    if (d.isNegative) return 'Waktu habis';

    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    final parts = <String>[];
    if (days > 0) parts.add('$days hari');
    if (hours > 0) parts.add('$hours jam');
    if (minutes > 0) parts.add('$minutes menit');
    if (seconds > 0 || parts.isEmpty) parts.add('$seconds detik');

    return parts.join(' ');
  }

  /// Format countdown compact
  /// Contoh: "2h 3j 30m 15d"
  static String formatCountdownCompact(Duration d) {
    if (d.isNegative) return '0d';

    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    final parts = <String>[];
    if (days > 0) parts.add('${days}h');
    if (hours > 0) parts.add('${hours}j');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 || parts.isEmpty) parts.add('${seconds}d');

    return parts.join(' ');
  }
}