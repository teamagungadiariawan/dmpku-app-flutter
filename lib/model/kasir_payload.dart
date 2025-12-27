class PenjualanPayload {
  final int idproduk;
  final int jumlah;

  PenjualanPayload({required this.idproduk, required this.jumlah});

  Map<String, dynamic> toJson() {
    return {'idproduk': idproduk, 'jumlah': jumlah};
  }
}
