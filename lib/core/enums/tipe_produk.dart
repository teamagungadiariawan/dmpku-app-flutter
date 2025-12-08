enum TipeProduk {
  all(1),
  bpjs(2),
  bpjsKerja(3),
  dompetDigital(4),
  ecommerce(5),
  hpPasca(6),
  internetTv(7),
  masaAktif(8),
  paketData(9),
  paketSms(10),
  pbb(11),
  pdam(12),
  pkb(13),
  plnTagihan(14),
  pulsa(15),
  tagihanGas(16),
  tokenPertagas(17),
  tokenPgn(18),
  tokenPln(19),
  topupGame(20),
  paketTv(21),
  uangElektronik(22),
  voucherData(23),
  voucherDigital(24),
  wifiId(25),
  paketStreaming(26);

  final int idFavorit;

  const TipeProduk(this.idFavorit);
}
