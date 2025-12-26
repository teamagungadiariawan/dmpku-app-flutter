extension DateTimeExtension on DateTime {
  int get unixTimestamp => toUtc().millisecondsSinceEpoch ~/ 1000;

  String toIso8601StringZ() => toUtc().toIso8601String();

  Duration get durationFromNow => DateTime.now().difference(this);

  Duration get durationUntilNow => difference(DateTime.now());

  String formatReg() {
    return '${day.toString().padLeft(2, '0')}-'
        '${month.toString().padLeft(2, '0')}-'
        '${year} '
        '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}:'
        '${second.toString().padLeft(2, '0')}';
  }
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

  // Format DateTime ke string "dd-MM-yyyy HH:mm:ss"
  static String formatDateTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  // Format DateTime ke string "yyyy-MM-dd"
  static String formatDate(DateTime dt) {
    return '${dt.year}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')}';
  }

  // --- Tambahan untuk Gabung Tanggal ---

  // Daftar nama bulan pendek (Sesuaikan kalau mau Inggris: Jan, Feb, Mar...)
  static const List<String> _shortMonths = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agt',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static const List<String> _fullMonths = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const List<String> _fullDays = [
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  static String _getShortMonth(int month) {
    if (month < 1 || month > 12) return '';
    return _shortMonths[month];
  }

  static String _getFullMonth(int month) {
    if (month < 1 || month > 12) return '';
    return _fullMonths[month];
  }

  static String formatSimpleDate(DateTime dt) {
    // jika hari ini return "Hari ini"
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'Hari ini';
    }

    return '${dt.day} ${_getShortMonth(dt.month)} ${dt.year}';
  }

  static String formatFullDate(DateTime dt) {
    return '${dt.day} ${_getFullMonth(dt.month)} ${dt.year}';
  }

  static String formatFullDateWithDay(DateTime dt) {
    return '${_fullDays[dt.weekday % 7]}, ${dt.day} ${_getFullMonth(dt.month)} ${dt.year}';
  }

  static String formatFullDateWithDayShort(DateTime dt) {
    return '${_fullDays[dt.weekday % 7]}, ${dt.day} ${_getShortMonth(dt.month)} ${dt.year}';
  }

  /// Menggabungkan dua tanggal menjadi range string
  /// Logic:
  /// - Sama Tahun & Bulan: "10 - 12 Jan 2025"
  /// - Sama Tahun, Beda Bulan: "10 Jan - 12 Feb 2025"
  /// - Beda Tahun: "10 Des 2024 - 10 Jan 2025"
  static String joinDateRange(DateTime date1, DateTime date2) {
    if (date1.year == date2.year) {
      if (date1.month == date2.month) {
        // Case: Bulan & Tahun sama
        return '${date1.day} - ${date2.day} ${_getShortMonth(date1.month)} ${date1.year}';
      }
      // Case: Tahun sama, Bulan beda
      return '${date1.day} ${_getShortMonth(date1.month)} - ${date2.day} ${_getShortMonth(date2.month)} ${date1.year}';
    }

    // Case: Beda Tahun
    return '${date1.day} ${_getShortMonth(date1.month)} ${date1.year} - ${date2.day} ${_getShortMonth(date2.month)} ${date2.year}';
  }

  // Format hanya waktu "HH:mm"
  static String formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}
