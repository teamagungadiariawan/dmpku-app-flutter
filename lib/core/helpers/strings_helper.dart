String ToRupiah(String amount)  {
  try {
    final number = int.parse(amount.replaceAll(RegExp(r'[^0-9]'), ''));
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  } catch (e) {
    return amount;
  }
}
