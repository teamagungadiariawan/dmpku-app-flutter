import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/guest_masa_aktif_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/guest_masa_aktif_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/guest_paket_data_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/guest_paket_data_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/guest_paket_nelpon_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/guest_paket_nelpon_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/guest_topup_game_provider_page.dart';
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

      /// ------  TOPUP GAME ------ ///
      ///
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
