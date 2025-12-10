String ToRupiah(String amount) {
  try {
    final number = int.parse(amount.replaceAll(RegExp(r'[^0-9]'), ''));
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  } catch (e) {
    return amount;
  }
}

String ToCurrency(String amount) {
  try {
    final number = int.parse(amount.replaceAll(RegExp(r'[^0-9]'), ''));
    return '${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  } catch (e) {
    return amount;
  }
}

String obfuscatePhone(
  String phone, {
  int visibleStart = 3,
  int visibleEnd = 3,
}) {
  // Hapus karakter non-digit
  final digits = phone.replaceAll(RegExp(r'\D'), '');

  if (digits.length <= visibleStart + visibleEnd) {
    return phone;
  }

  final start = digits.substring(0, visibleStart);
  final end = digits.substring(digits.length - visibleEnd);
  final hiddenLength = digits.length - visibleStart - visibleEnd;

  return '$start${'*' * hiddenLength}$end';
}
