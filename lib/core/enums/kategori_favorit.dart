import 'package:flutter/material.dart';
import 'package:dmpku/gen/assets.gen.dart';

// 1. Kita bikin modelnya dulu biar rapi
class KategoriItem {
  final String code;
  final int id;
  final String label;
  final String path;
  final ImageProvider? icon;

  const KategoriItem({
    required this.code,
    required this.id,
    required this.label,
    required this.path,
    this.icon,
  });
}

// 2. Ini function-nya
List<KategoriItem> getKategoriFavorit() {
  return [
    const KategoriItem(
      code: 'all',
      id: 1,
      label: 'Semua Kategori',
      path: '',
      icon: null,
    ),
    KategoriItem(
      code: 'BPJS_KESEHATAN',
      id: 2,
      label: 'BPJS Kesehatan',
      path: '/bpjs-kesehatan',
      icon: Assets.img.menuPpob.iconBpjsKesehatan.provider(),
    ),
    KategoriItem(
      code: 'BPJS_TKN',
      id: 3,
      label: 'BPJS TKN',
      path: '/bpjs-ketenagakerjaan',
      icon: Assets.img.menuPpob.iconBpjsTkn.provider(),
    ),
    KategoriItem(
      code: 'DOMPET_DIGITAL',
      id: 4,
      label: 'Dompet Digital',
      path: '/dompet-digital',
      icon: Assets.img.menuPpob.iconDompetDigital.provider(),
    ),
    KategoriItem(
      code: 'E_COMMERCE',
      id: 5,
      label: 'E-Commerce',
      path: '/ecommers',
      icon: Assets.img.menuPpob.iconEcommerce.provider(),
    ),
    KategoriItem(
      code: 'HP_PASCA',
      id: 6,
      label: 'HP Pasca',
      path: '/hp-pasca',
      icon: Assets.img.menuPpob.iconHpPasca.provider(),
    ),
    KategoriItem(
      code: 'INTERNET_TV',
      id: 7,
      label: 'Internet & TV',
      path: '/internet-tv',
      icon: Assets.img.menuPpob.iconInternetTv.provider(),
    ),
    KategoriItem(
      code: 'MASA_AKTIF',
      id: 8,
      label: 'Masa Aktif',
      path: '/masa-aktif',
      icon: Assets.img.menuIsiUlang.iconMasaAktif.provider(),
    ),
    KategoriItem(
      code: 'PAKET_DATA',
      id: 9,
      label: 'Paket Data',
      path: '/paket-data',
      icon: Assets.img.menuIsiUlang.iconPaketData.provider(),
    ),
    KategoriItem(
      code: 'PAKET_SMS_TELPON',
      id: 10,
      label: 'Paket sms & Telpon',
      path: '/paket-sms',
      icon: Assets.img.menuIsiUlang.iconPaketSmsTelepon.provider(),
    ),
    KategoriItem(
      code: 'PBB',
      id: 11,
      label: 'PBB',
      path: '/pbb',
      icon: Assets.img.menuPpob.iconPbb.provider(),
    ),
    KategoriItem(
      code: 'PDAM',
      id: 12,
      label: 'PDAM',
      path: '/pdam',
      icon: Assets.img.menuPpob.iconPdam.provider(),
    ),
    KategoriItem(
      code: 'PKB',
      id: 13,
      label: 'PKB',
      path: '/pkb',
      icon: Assets.img.menuPpob.iconEsamsat.provider(),
    ),
    KategoriItem(
      code: 'PLN_TAGIHAN',
      id: 14,
      label: 'PLN Tagihan',
      path: '/pln-tagihan',
      icon: Assets.img.menuPpob.iconPlnTagihan.provider(),
    ),
    KategoriItem(
      code: 'PULSA',
      id: 15,
      label: 'Pulsa',
      path: '/pulsa',
      icon: Assets.img.menuIsiUlang.iconPulsa.provider(),
    ),
    KategoriItem(
      code: 'TAGIHAN_GAS',
      id: 16,
      label: 'Tagihan Gas',
      path: '/tagihan-gas',
      icon: Assets.img.menuPpob.iconTagihanGas.provider(),
    ),
    KategoriItem(
      code: 'TOKEN_PERTAGAS',
      id: 17,
      label: 'Token Pertagas',
      path: '/token-pertagas',
      icon: Assets.img.menuPpob.iconTokenPertagas.provider(),
    ),
    KategoriItem(
      code: 'TOKEN_PGN',
      id: 18,
      label: 'Token PGN',
      path: '/token-pgn',
      icon: Assets.img.menuPpob.iconTokenPgn.provider(),
    ),
    KategoriItem(
      code: 'TOKEN_PLN',
      id: 19,
      label: 'Token PLN',
      path: '/token-pln',
      icon: Assets.img.menuIsiUlang.iconTokenPln.provider(),
    ),
    KategoriItem(
      code: 'TOPUP_GAME',
      id: 20,
      label: 'Topup Game',
      path: '/topup-game',
      icon: Assets.img.menuIsiUlang.iconTopupGame.provider(),
    ),
    KategoriItem(
      code: 'PAKET_TV',
      id: 21,
      label: 'Paket TV',
      path: '/paket-tv',
      icon: Assets.img.menuIsiUlang.iconPaketTv.provider(),
    ),
    KategoriItem(
      code: 'UANG_ELEKTRONIK',
      id: 22,
      label: 'Uang Elektronik',
      path: '/uang-elektronik',
      icon: Assets.img.menuPpob.iconUangElektronik.provider(),
    ),
    KategoriItem(
      code: 'VOUCHER_DATA',
      id: 23,
      label: 'Voucher Data',
      path: '/voucher-data',
      icon: Assets.img.menuIsiUlang.iconVoucherData.provider(),
    ),
    KategoriItem(
      code: 'VOUCHER_DIGITAL',
      id: 24,
      label: 'Voucher Digital',
      path: '/voucher-digital',
      icon: Assets.img.menuIsiUlang.iconVoucherDigital.provider(),
    ),
    KategoriItem(
      code: 'WIFI_ID',
      id: 25,
      label: 'Wifi Id',
      path: '/wifi-id',
      icon: Assets.img.menuIsiUlang.iconWifiId.provider(),
    ),
    KategoriItem(
      code: 'PAKET_STREAMING',
      id: 26,
      label: 'Paket Streaming',
      path: '/paket-streaming',
      icon: Assets.img.menuIsiUlang.iconPaketStreaming.provider(),
    ),
  ];
}

enum Kategori {
  all('all', 1, 'Semua Kategori', ''),
  bpjsKesehatan('BPJS_KESEHATAN', 2, 'BPJS Kesehatan', '/bpjs-kesehatan'),
  bpjsTkn('BPJS_TKN', 3, 'BPJS TKN', '/bpjs-ketenagakerjaan'),
  dompetDigital('DOMPET_DIGITAL', 4, 'Dompet Digital', '/dompet-digital'),
  eCommerce('E_COMMERCE', 5, 'E-Commerce', '/ecommers'),
  hpPasca('HP_PASCA', 6, 'HP Pasca', '/hp-pasca'),
  internetTv('INTERNET_TV', 7, 'Internet & TV', '/internet-tv'),
  masaAktif('MASA_AKTIF', 8, 'Masa Aktif', '/masa-aktif'),
  paketData('PAKET_DATA', 9, 'Paket Data', '/paket-data'),
  paketSmsTelpon('PAKET_SMS_TELPON', 10, 'Paket sms & Telpon', '/paket-sms'),
  pbb('PBB', 11, 'PBB', '/pbb'),
  pdam('PDAM', 12, 'PDAM', '/pdam'),
  pkb('PKB', 13, 'PKB', '/pkb'),
  plnTagihan('PLN_TAGIHAN', 14, 'PLN Tagihan', '/pln-tagihan'),
  pulsa('PULSA', 15, 'Pulsa', '/pulsa'),
  tagihanGas('TAGIHAN_GAS', 16, 'Tagihan Gas', '/tagihan-gas'),
  tokenPertagas('TOKEN_PERTAGAS', 17, 'Token Pertagas', '/token-pertagas'),
  tokenPgn('TOKEN_PGN', 18, 'Token PGN', '/token-pgn'),
  tokenPln('TOKEN_PLN', 19, 'Token PLN', '/token-pln'),
  topupGame('TOPUP_GAME', 20, 'Topup Game', '/topup-game'),
  paketTv('PAKET_TV', 21, 'Paket TV', '/paket-tv'),
  uangElektronik('UANG_ELEKTRONIK', 22, 'Uang Elektronik', '/uang-elektronik'),
  voucherData('VOUCHER_DATA', 23, 'Voucher Data', '/voucher-data'),
  voucherDigital('VOUCHER_DIGITAL', 24, 'Voucher Digital', '/voucher-digital'),
  wifiId('WIFI_ID', 25, 'Wifi Id', '/wifi-id'),
  paketStreaming('PAKET_STREAMING', 26, 'Paket Streaming', '/paket-streaming');

  final String code;
  final int id;
  final String label;
  final String path;

  const Kategori(this.code, this.id, this.label, this.path);

  // Helper function buat nyari Enum berdasarkan code string (misal dari API)
  static Kategori? fromCode(String code) {
    try {
      return Kategori.values.firstWhere((e) => e.code == code);
    } catch (_) {
      return null;
    }
  }

  static Kategori? fromId(int id) {
    try {
      return Kategori.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  KategoriItem? get toKategoriItem {
    final allItems = getKategoriFavorit();
    return allItems.firstWhere(
      (item) => item.code == code,
      orElse: () => KategoriItem(
        code: code,
        id: id,
        label: label,
        path: path,
        icon: null,
      ),
    );
  }
}
