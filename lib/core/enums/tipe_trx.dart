enum TipeTrx {
  elektrik(1, 'Elektrik'),
  nominalBebas(2, 'Nominal Bebas'),
  cekTagihan(3, 'Cek Tagihan'),
  bayarTagihan(4, 'Bayar Tagihan'),
  cekAkun(5, 'Cek Akun');

  final int value;
  final String text;

  const TipeTrx(this.value, this.text);

  /// Get enum from int value
  static TipeTrx? fromValue(int value) {
    return TipeTrx.values.where((e) => e.value == value).firstOrNull;
  }
}