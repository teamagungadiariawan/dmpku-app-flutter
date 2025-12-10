import 'package:dmpku/pages/auth/loading_splash_page.dart';
import 'package:dmpku/pages/auth/login/request_otp_login_page.dart';
import 'package:dmpku/pages/auth/login/verify_otp_login_page.dart';
import 'package:dmpku/pages/guest/belum_login_page.dart';
import 'package:dmpku/pages/guest/dashboard/dashboard_page.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/pages/guest/official/official_page.dart';
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
import 'package:dmpku/pages/member/akun/member_akun_page.dart';
import 'package:dmpku/pages/member/member_main_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_akitvasi_voucher_berurutan_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_akitvasi_voucher_satuan_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_produk_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case RequestOtpLoginPage.routeName:
        return _customTransition(child: const RequestOtpLoginPage());
      case VerifyOtpLoginPage.routeName:
        return _customTransition(child: const VerifyOtpLoginPage());

      // Guest
      case MainPage.routeName:
        return _customTransitionBottomToTop(child: const MainPage());

      // Guest Pulsa
      case GuestPulsaProviderPage.routeName:
        return _customTransition(child: const GuestPulsaProviderPage());
      case GuestPulsaProdukPage.routeName:
        return _customTransition(child: const GuestPulsaProdukPage());

      // Guest Paket Data
      case GuestPaketDataProviderPage.routeName:
        return _customTransition(child: const GuestPaketDataProviderPage());
      case GuestPaketDataProdukPage.routeName:
        return _customTransition(child: const GuestPaketDataProdukPage());

      // Guest Masa Aktif
      case GuestMasaAktifProviderPage.routeName:
        return _customTransition(child: const GuestMasaAktifProviderPage());
      case GuestMasaAktifProdukPage.routeName:
        return _customTransition(child: const GuestMasaAktifProdukPage());

      // Guest Paket Nelpon
      case GuestPaketNelponProviderPage.routeName:
        return _customTransition(child: const GuestPaketNelponProviderPage());
      case GuestPaketNelponProdukPage.routeName:
        return _customTransition(child: const GuestPaketNelponProdukPage());

      // Guest Topup Game
      case GuestTopupGameProviderPage.routeName:
        return _customTransition(child: const GuestTopupGameProviderPage());
      case GuestTopupGameProdukPage.routeName:
        return _customTransition(child: const GuestTopupGameProdukPage());

      // Guest Token PLN
      case GuestTokenPlnProdukPage.routeName:
        return _customTransition(child: const GuestTokenPlnProdukPage());

      // Guest Aktivasi Voucher
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

      // Guest Voucher Data
      case GuestVoucherDataProviderPage.routeName:
        return _customTransition(child: const GuestVoucherDataProviderPage());
      case GuestVoucherDataProdukPage.routeName:
        return _customTransition(child: const GuestVoucherDataProdukPage());

      // Guest Wifi ID
      case GuestWifiIdProdukPage.routeName:
        return _customTransition(child: const GuestWifiIdProdukPage());

      // Guest Paket TV
      case GuestPaketTvProviderPage.routeName:
        return _customTransition(child: const GuestPaketTvProviderPage());
      case GuestPaketTvProdukPage.routeName:
        return _customTransition(child: const GuestPaketTvProdukPage());

      // Guest Info Kartu
      case GuestInfoKartuProviderPage.routeName:
        return _customTransition(child: const GuestInfoKartuProviderPage());
      case GuestInfoKartuProdukPage.routeName:
        return _customTransition(child: const GuestInfoKartuProdukPage());

      // Guest Paket Streaming
      case GuestPaketStreamingProviderPage.routeName:
        return _customTransition(
          child: const GuestPaketStreamingProviderPage(),
        );
      case GuestPaketStreamingProdukPage.routeName:
        return _customTransition(child: const GuestPaketStreamingProdukPage());

      // Guest Voucher Digital
      case GuestVoucherDigitalProviderPage.routeName:
        return _customTransition(
          child: const GuestVoucherDigitalProviderPage(),
        );
      case GuestVoucherDigitalProdukPage.routeName:
        return _customTransition(child: const GuestVoucherDigitalProdukPage());

      // Guest Aktivasi Perdana
      case GuestAktivasiPerdanaProviderPage.routeName:
        return _customTransition(
          child: const GuestAktivasiPerdanaProviderPage(),
        );
      case GuestAktivasiPerdanaProdukPage.routeName:
        return _customTransition(child: const GuestAktivasiPerdanaProdukPage());

      // Guest Cek Status Voucher
      case GuestCekStatusVoucherProviderPage.routeName:
        return _customTransition(
          child: const GuestCekStatusVoucherProviderPage(),
        );
      case GuestCekStatusVoucherProdukPage.routeName:
        return _customTransition(
          child: const GuestCekStatusVoucherProdukPage(),
        );

      // Guest Paket Cuan
      case GuestPaketCuanProviderPage.routeName:
        return _customTransition(child: const GuestPaketCuanProviderPage());
      case GuestPaketCuanSubProviderPage.routeName:
        return _customTransition(child: const GuestPaketCuanSubProviderPage());
      case GuestPaketCuanProdukPage.routeName:
        return _customTransition(child: const GuestPaketCuanProdukPage());

      // Member
      case MemberMainPage.routeName:
        return _customTransitionBottomToTop(child: const MemberMainPage());

      // Member Pulsa
      case MemberPulsaProviderPage.routeName:
        return _customTransition(child: const MemberPulsaProviderPage());
      case MemberPulsaProdukPage.routeName:
        return _customTransition(child: const MemberPulsaProdukPage());
      case MemberPulsaKonfirmasiTransaksiPage.routeName:
        return _customTransition(
            child: const MemberPulsaKonfirmasiTransaksiPage());

      // Member Paket Data
      case MemberPaketDataProviderPage.routeName:
        return _customTransition(child: const MemberPaketDataProviderPage());
      case MemberPaketDataProdukPage.routeName:
        return _customTransition(child: const MemberPaketDataProdukPage());
      case MemberPaketDataKonfirmasiTransaksiPage.routeName:
        return _customTransition(
            child: const MemberPaketDataKonfirmasiTransaksiPage());

      // Member Masa Aktif
      case MemberMasaAktifProviderPage.routeName:
        return _customTransition(child: const MemberMasaAktifProviderPage());
      case MemberMasaAktifProdukPage.routeName:
        return _customTransition(child: const MemberMasaAktifProdukPage());
      case MemberMasaAktifKonfirmasiTransaksiPage.routeName:
        return _customTransition(
            child: const MemberMasaAktifKonfirmasiTransaksiPage());

      // Member Paket Nelpon
      case MemberPaketNelponProviderPage.routeName:
        return _customTransition(child: const MemberPaketNelponProviderPage());
      case MemberPaketNelponProdukPage.routeName:
        return _customTransition(child: const MemberPaketNelponProdukPage());
      case MemberPaketNelponKonfirmasiTransaksiPage.routeName:
        return _customTransition(
            child: const MemberPaketNelponKonfirmasiTransaksiPage());

      // Member Topup Game
      case MemberTopupGameProviderPage.routeName:
        return _customTransition(child: const MemberTopupGameProviderPage());
      case MemberTopupGameProdukPage.routeName:
        return _customTransition(child: const MemberTopupGameProdukPage());

      // Member Wifi ID
      case MemberWifiIdProdukPage.routeName:
        return _customTransition(child: const MemberWifiIdProdukPage());

      // Member Paket TV
      case MemberPaketTvProviderPage.routeName:
        return _customTransition(child: const MemberPaketTvProviderPage());
      case MemberPaketTvProdukPage.routeName:
        return _customTransition(child: const MemberPaketTvProdukPage());

      // Member Token PLN
      case MemberTokenPlnProdukPage.routeName:
        return _customTransition(child: const MemberTokenPlnProdukPage());

      // Member Info Kartu
      case MemberInfoKartuProviderPage.routeName:
        return _customTransition(child: const MemberInfoKartuProviderPage());
      case MemberInfoKartuProdukPage.routeName:
        return _customTransition(child: const MemberInfoKartuProdukPage());

      // Member Aktivasi Perdana
      case MemberAktivasiPerdanaProviderPage.routeName:
        return _customTransition(
            child: const MemberAktivasiPerdanaProviderPage());
      case MemberAktivasiPerdanaProdukPage.routeName:
        return _customTransition(
            child: const MemberAktivasiPerdanaProdukPage());

      // Member Aktivasi Voucher
      case MemberAktivasiVoucherProviderPage.routeName:
        return _customTransition(
            child: const MemberAktivasiVoucherProviderPage());
      case MemberAktivasiVoucherProdukPage.routeName:
        return _customTransition(
            child: const MemberAktivasiVoucherProdukPage());
      case MemberAkitvasiVoucherBerurutanPage.routeName:
        return _customTransition(
            child: const MemberAkitvasiVoucherBerurutanPage());
      case MemberAkitvasiVoucherSatuanPage.routeName:
        return _customTransition(
            child: const MemberAkitvasiVoucherSatuanPage());

      // Member Cek Status Voucher
      case MemberCekStatusVoucherProviderPage.routeName:
        return _customTransition(
            child: const MemberCekStatusVoucherProviderPage());
      case MemberCekStatusVoucherProdukPage.routeName:
        return _customTransition(
            child: const MemberCekStatusVoucherProdukPage());

      // Member Paket Streaming
      case MemberPaketStreamingProviderPage.routeName:
        return _customTransition(
            child: const MemberPaketStreamingProviderPage());
      case MemberPaketStreamingProdukPage.routeName:
        return _customTransition(
            child: const MemberPaketStreamingProdukPage());

      // Member Voucher Data
      case MemberVoucherDataProviderPage.routeName:
        return _customTransition(
            child: const MemberVoucherDataProviderPage());
      case MemberVoucherDataProdukPage.routeName:
        return _customTransition(child: const MemberVoucherDataProdukPage());

      // Member Voucher Digital
      case MemberVoucherDigitalProviderPage.routeName:
        return _customTransition(
            child: const MemberVoucherDigitalProviderPage());
      case MemberVoucherDigitalProdukPage.routeName:
        return _customTransition(
            child: const MemberVoucherDigitalProdukPage());

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
