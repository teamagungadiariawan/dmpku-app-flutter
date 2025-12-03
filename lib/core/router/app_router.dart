import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_perdana/guest_aktivasi_perdana_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_perdana/guest_aktivasi_perdana_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_akitvasi_voucher_berurutan_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_akitvasi_voucher_satuan_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_aktivasi_voucher_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_aktivasi_voucher_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/guest_cek_status_voucher_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/guest_cek_status_voucher_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/info_kartu/guest_info_kartu_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/info_kartu/guest_info_kartu_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/guest_masa_aktif_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/guest_masa_aktif_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/guest_paket_data_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/guest_paket_data_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/guest_paket_nelpon_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/guest_paket_nelpon_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_streaming/guest_paket_streaming_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_streaming/guest_paket_streaming_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_tv/guest_paket_tv_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_tv/guest_paket_tv_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/token_pln/guest_token_pln_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/guest_topup_game_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/guest_topup_game_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_data/guest_voucher_data_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_data/guest_voucher_data_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_digital/guest_voucher_digital_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_digital/guest_voucher_digital_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/wifi_id/guest_wifi_id_produk_page.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/guest_paket_cuan_produk_page.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/guest_paket_cuan_provider_page.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/guest_paket_cuan_subprovider_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return _customTransitionBottomToTop(child: const MainPage());

      /// ------  PULSA ------ ///
      case GuestPulsaProviderPage.routeName:
        return _customTransition(child: const GuestPulsaProviderPage());
      case GuestPulsaProdukPage.routeName:
        return _customTransition(child: const GuestPulsaProdukPage());

      /// ------  PULSA ------ ///

      /// ------  PAKETDATA ------ ///
      case GuestPaketDataProviderPage.routeName:
        return _customTransition(child: const GuestPaketDataProviderPage());
      case GuestPaketDataProdukPage.routeName:
        return _customTransition(child: const GuestPaketDataProdukPage());

      /// ------  PAKETDATA ------ ///

      /// ------  MASA AKTIF ------ ///
      case GuestMasaAktifProviderPage.routeName:
        return _customTransition(child: const GuestMasaAktifProviderPage());
      case GuestMasaAktifProdukPage.routeName:
        return _customTransition(child: const GuestMasaAktifProdukPage());

      /// ------  MASA AKTIF ------ ///

      /// ------  PAKET NELPON ------ ///
      case GuestPaketNelponProviderPage.routeName:
        return _customTransition(child: const GuestPaketNelponProviderPage());
      case GuestPaketNelponProdukPage.routeName:
        return _customTransition(child: const GuestPaketNelponProdukPage());

      /// ------  PAKET NELPON ------ ///

      /// ------  TOPUP GAME ------ ///
      case GuestTopupGameProviderPage.routeName:
        return _customTransition(child: const GuestTopupGameProviderPage());
      case GuestTopupGameProdukPage.routeName:
        return _customTransition(child: const GuestTopupGameProdukPage());

      /// ------  TOPUP GAME ------ ///

      /// ------  TOKEN PLN ------ ///
      case GuestTokenPlnProdukPage.routeName:
        return _customTransition(child: const GuestTokenPlnProdukPage());

      /// ------  TOKEN PLN ------ ///

      /// ------  AKTIVASI VOUCHER ------ ///
      case GuestAktivasiVoucherProviderPage.routeName:
        return _customTransition(
          child: const GuestAktivasiVoucherProviderPage(),
        );
      case GuestAktivasiVoucherProdukPage.routeName:
        return _customTransition(child: const GuestAktivasiVoucherProdukPage());
      case GuestAkitvasiVoucherBerurutanPage.routeName:
        return _customTransition(
          child: const GuestAkitvasiVoucherBerurutanPage(),
        );
      case GuestAkitvasiVoucherSatuanPage.routeName:
        return _customTransition(child: const GuestAkitvasiVoucherSatuanPage());

      /// ------  AKTIVASI VOUCHER ------ ///

      /// ------  VOUCHER DATA ------ ///
      case GuestVoucherDataProviderPage.routeName:
        return _customTransition(child: const GuestVoucherDataProviderPage());
      case GuestVoucherDataProdukPage.routeName:
        return _customTransition(child: const GuestVoucherDataProdukPage());

      /// ------  VOUCHER DATA ------ ///

      /// ------ WIFI ID ------ ///
      case GuestWifiIdProdukPage.routeName:
        return _customTransition(child: const GuestWifiIdProdukPage());

      /// ------ WIFI ID ------ ///

      /// ------ PAKET TV ------ ///
      case GuestPaketTvProviderPage.routeName:
        return _customTransition(child: const GuestPaketTvProviderPage());
      case GuestPaketTvProdukPage.routeName:
        return _customTransition(child: const GuestPaketTvProdukPage());

      /// ------ PAKET TV ------ ///

      /// ------ INFO KARTU ------ ///
      case GuestInfoKartuProviderPage.routeName:
        return _customTransition(child: const GuestInfoKartuProviderPage());
      case GuestInfoKartuProdukPage.routeName:
        return _customTransition(child: const GuestInfoKartuProdukPage());

      /// ------ INFO KARTU ------ ///

      /// ------ PAKET STREAMING ------ ///
      case GuestPaketStreamingProviderPage.routeName:
        return _customTransition(child: const GuestPaketStreamingProviderPage());
      case GuestPaketStreamingProdukPage.routeName:
        return _customTransition(child: const GuestPaketStreamingProdukPage());

      /// ------ PAKET STREAMING ------ ///

      /// ------ VOUCHER DIGITAL ------ ///
      case GuestVoucherDigitalProviderPage.routeName:
        return _customTransition(child: const GuestVoucherDigitalProviderPage());
      case GuestVoucherDigitalProdukPage.routeName:
        return _customTransition(child: const GuestVoucherDigitalProdukPage());

      /// ------ VOUCHER DIGITAL ------ ///

      /// ------ AKTIVASI PERDANA ------ ///
      case GuestAktivasiPerdanaProviderPage.routeName:
        return _customTransition(child: const GuestAktivasiPerdanaProviderPage());
      case GuestAktivasiPerdanaProdukPage.routeName:
        return _customTransition(child: const GuestAktivasiPerdanaProdukPage());

      /// ------ AKTIVASI PERDANA ------ ///

      /// ------ CEK STATUS VOUCHER ------ ///
      case GuestCekStatusVoucherProviderPage.routeName:
        return _customTransition(child: const GuestCekStatusVoucherProviderPage());
      case GuestCekStatusVoucherProdukPage.routeName:
        return _customTransition(child: const GuestCekStatusVoucherProdukPage());

      /// ------ CEK STATUS VOUCHER ------ ///

      /// ------ PAKET CUAN ------ ///
      case GuestPaketCuanProviderPage.routeName:
        return _customTransition(child: const GuestPaketCuanProviderPage());
      case GuestPaketCuanSubProviderPage.routeName:
        return _customTransition(child: const GuestPaketCuanSubProviderPage());
      case GuestPaketCuanProdukPage.routeName:
        return _customTransition(child: const GuestPaketCuanProdukPage());
      /// ------ PAKET CUAN ------ ///

      default:
        return null;
    }
  }

  static PageTransition _customTransition({required Widget child}) {
    return PageTransition(
      child: child,
      type: PageTransitionType.rightToLeft,
      duration: const Duration(milliseconds: 225),
      reverseDuration: const Duration(milliseconds: 225),
    );
  }

  static PageTransition _customTransitionBottomToTop({required Widget child}) {
    return PageTransition(
      child: child,
      type: PageTransitionType.bottomToTop,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
  }
}
