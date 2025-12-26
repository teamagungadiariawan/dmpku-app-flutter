import 'package:dmpku/pages/auth/login/request_otp_login_page.dart';
import 'package:dmpku/pages/auth/login/verify_otp_login_page.dart';
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
import 'package:dmpku/pages/calculator/calculator_page.dart';
import 'package:dmpku/pages/member/akun/daftar_devices/member_daftar_devices.dart';
import 'package:dmpku/pages/member/akun/detail_akun/member_detail_akun_page.dart';
import 'package:dmpku/pages/member/akun/favorit/member_daftar_favorit_page.dart';
import 'package:dmpku/pages/member/banner/banner_page.dart';
import 'package:dmpku/pages/member/kasir/member_catatan_page.dart';

import 'package:dmpku/pages/member/isistok/alfamart/buat_tiket_alfamart_page.dart';
import 'package:dmpku/pages/member/isistok/alfamart/detail_tiket_alfamart_page.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/buat_tiket_bank_transfer_page.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/detail_tiket_bank_transfer_page.dart';
import 'package:dmpku/pages/member/isistok/indomaret/buat_tiket_indomaret_page.dart';
import 'package:dmpku/pages/member/isistok/indomaret/detail_tiket_indomaret_page.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_page.dart';
import 'package:dmpku/pages/member/isistok/member_mutasi_isi_stok_page.dart';
import 'package:dmpku/pages/member/isistok/qris/buat_tiket_qris_page.dart';
import 'package:dmpku/pages/member/nobu/progress_nobu_page.dart';
import 'package:dmpku/pages/member/isistok/qris/detail_tiket_qris_page.dart';
import 'package:dmpku/pages/member/isistok/va/buat_tiket_va_page.dart';
import 'package:dmpku/pages/member/isistok/va/detail_tiket_va_page.dart';
import 'package:dmpku/pages/member/member_main_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_akitvasi_voucher_berurutan_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_akitvasi_voucher_satuan_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_konfirmasi_transaksi_page.dart';
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
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_produk_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_produk_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_provider_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_subprovider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_nominal_bebas_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_produk_nominal_bebas_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_provider_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_aktivasi_voucher.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_bagikan_elektrik_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_cetak_struk_elektrik_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_bagikan_nominal_bebas_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_cetak_struk_nominal_bebas_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_bagikan_ppob_1_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_bagikan_ppob_2_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_cetak_struk_ppob_2_page.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_page.dart';
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
        final args = settings.arguments as int?;
        return _customTransitionBottomToTop(
          child: MemberMainPage(initialIndex: args ?? 0),
        );

      case MemberCatatanPage.routeName:
        return _customTransition(child: const MemberCatatanPage());

      // AKUN
      case MemberDetailAkunPage.routeName:
        return _customTransition(child: MemberDetailAkunPage());
      case MemberDaftarDevices.routeName:
        return _customTransition(child: MemberDaftarDevices());
      case MemberDaftarFavoritPage.routeName:
        return _customTransition(child: MemberDaftarFavoritPage());
      case MemberDetailRiwayatPage.routeName:
        return _customTransition(child: MemberDetailRiwayatPage());

      // IsiStok
      case MemberIsiStokPage.routeName:
        return _customTransition(child: MemberIsiStokPage());
      case BuatTiketBankTransferPage.routeName:
        return _customTransition(child: BuatTiketBankTransferPage());
      case DetailTiketBankTransferPage.routeName:
        return _customTransition(child: DetailTiketBankTransferPage());
      case BuatTiketVaPage.routeName:
        return _customTransition(child: BuatTiketVaPage());
      case DetailTiketVaPage.routeName:
        return _customTransition(child: DetailTiketVaPage());
      case BuatTiketAlfamartPage.routeName:
        return _customTransition(child: BuatTiketAlfamartPage());
      case DetailTiketAlfamartPage.routeName:
        return _customTransition(child: DetailTiketAlfamartPage());
      case BuatTiketIndomaretPage.routeName:
        return _customTransition(child: BuatTiketIndomaretPage());
      case DetailTiketIndomaretPage.routeName:
        return _customTransition(child: DetailTiketIndomaretPage());
      case BuatTiketQrisPage.routeName:
        return _customTransition(child: BuatTiketQrisPage());
      case DetailTiketQrisPage.routeName:
        return _customTransition(child: DetailTiketQrisPage());
      case MemberMutasiIsiStokPage.routeName:
        return _customTransition(child: MemberMutasiIsiStokPage());
      case ProgressNobuPage.routeName:
        return _customTransition(child: const ProgressNobuPage());

      case CetakStrukElektrikPage.routeName:
        return _customTransition(child: CetakStrukElektrikPage());
      case BagikanElektrikPage.routeName:
        return _customTransition(child: BagikanElektrikPage());

      case CetakStrukNominalBebasPage.routeName:
        return _customTransition(child: CetakStrukNominalBebasPage());
      case BagikanNominalBebasPage.routeName:
        return _customTransition(child: BagikanNominalBebasPage());

      case MemberCetakStrukPpob1Page.routeName:
        return _customTransition(child: MemberCetakStrukPpob1Page());
      case BagikanPpob1Page.routeName:
        return _customTransition(child: BagikanPpob1Page());
      case MemberCetakStrukPpob2Page.routeName:
        return _customTransition(child: MemberCetakStrukPpob2Page());
      case BagikanPpob2Page.routeName:
        return _customTransition(child: BagikanPpob2Page());

      // Member Transaksi Proses
      case TransaksiProsesPage.routeName:
        return _customTransition(child: TransaksiProsesPage());
      case TransaksiProsesAltPage.routeName:
        return _customTransition(child: TransaksiProsesAltPage());
      case TransaksiProsesAktivasiVoucherPage.routeName:
        return _customTransition(child: TransaksiProsesAktivasiVoucherPage());

      // Member Pulsa
      case MemberPulsaProviderPage.routeName:
        return _customTransition(child: const MemberPulsaProviderPage());
      case MemberPulsaProdukPage.routeName:
        return _customTransition(child: const MemberPulsaProdukPage());
      case MemberPulsaKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPulsaKonfirmasiTransaksiPage(),
        );

      // Member Paket Data
      case MemberPaketDataProviderPage.routeName:
        return _customTransition(child: const MemberPaketDataProviderPage());
      case MemberPaketDataProdukPage.routeName:
        return _customTransition(child: const MemberPaketDataProdukPage());
      case MemberPaketDataKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPaketDataKonfirmasiTransaksiPage(),
        );

      // Member Masa Aktif
      case MemberMasaAktifProviderPage.routeName:
        return _customTransition(child: const MemberMasaAktifProviderPage());
      case MemberMasaAktifProdukPage.routeName:
        return _customTransition(child: const MemberMasaAktifProdukPage());
      case MemberMasaAktifKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberMasaAktifKonfirmasiTransaksiPage(),
        );

      // Member Paket Nelpon
      case MemberPaketNelponProviderPage.routeName:
        return _customTransition(child: const MemberPaketNelponProviderPage());
      case MemberPaketNelponProdukPage.routeName:
        return _customTransition(child: const MemberPaketNelponProdukPage());
      case MemberPaketNelponKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPaketNelponKonfirmasiTransaksiPage(),
        );

      // Member Topup Game
      case MemberTopupGameProviderPage.routeName:
        return _customTransition(child: const MemberTopupGameProviderPage());
      case MemberTopupGameProdukPage.routeName:
        return _customTransition(child: const MemberTopupGameProdukPage());
      case MemberTopupGameKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberTopupGameKonfirmasiTransaksiPage(),
        );

      // Member Wifi ID
      case MemberWifiIdProdukPage.routeName:
        return _customTransition(child: const MemberWifiIdProdukPage());
      case MemberWifiIdKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberWifiIdKonfirmasiTransaksiPage(),
        );

      // Member Paket TV
      case MemberPaketTvProviderPage.routeName:
        return _customTransition(child: const MemberPaketTvProviderPage());
      case MemberPaketTvProdukPage.routeName:
        return _customTransition(child: const MemberPaketTvProdukPage());
      case MemberPaketTvKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPaketTvKonfirmasiTransaksiPage(),
        );

      // Member Token PLN
      case MemberTokenPlnProdukPage.routeName:
        return _customTransition(child: const MemberTokenPlnProdukPage());
      case MemberTokenPlnKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberTokenPlnKonfirmasiTransaksiPage(),
        );

      // Member Info Kartu
      case MemberInfoKartuProviderPage.routeName:
        return _customTransition(child: const MemberInfoKartuProviderPage());
      case MemberInfoKartuProdukPage.routeName:
        return _customTransition(child: const MemberInfoKartuProdukPage());

      // Member Aktivasi Perdana
      case MemberAktivasiPerdanaProviderPage.routeName:
        return _customTransition(
          child: const MemberAktivasiPerdanaProviderPage(),
        );
      case MemberAktivasiPerdanaProdukPage.routeName:
        return _customTransition(
          child: const MemberAktivasiPerdanaProdukPage(),
        );
      case MemberAktivasiPerdanaKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberAktivasiPerdanaKonfirmasiTransaksiPage(),
        );

      // Member Aktivasi Voucher
      case MemberAktivasiVoucherProviderPage.routeName:
        return _customTransition(
          child: const MemberAktivasiVoucherProviderPage(),
        );
      case MemberAktivasiVoucherProdukPage.routeName:
        return _customTransition(
          child: const MemberAktivasiVoucherProdukPage(),
        );
      case MemberAkitvasiVoucherBerurutanPage.routeName:
        return _customTransition(
          child: const MemberAkitvasiVoucherBerurutanPage(),
        );
      case MemberAkitvasiVoucherSatuanPage.routeName:
        return _customTransition(
          child: const MemberAkitvasiVoucherSatuanPage(),
        );

      case MemberAktivasiVoucherKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberAktivasiVoucherKonfirmasiTransaksiPage(),
        );

      // Member Cek Status Voucher
      case MemberCekStatusVoucherProviderPage.routeName:
        return _customTransition(
          child: const MemberCekStatusVoucherProviderPage(),
        );
      case MemberCekStatusVoucherProdukPage.routeName:
        return _customTransition(
          child: const MemberCekStatusVoucherProdukPage(),
        );

      // Member Paket Streaming
      case MemberPaketStreamingProviderPage.routeName:
        return _customTransition(
          child: const MemberPaketStreamingProviderPage(),
        );
      case MemberPaketStreamingProdukPage.routeName:
        return _customTransition(child: const MemberPaketStreamingProdukPage());
      case MemberPaketStreamingKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPaketStreamingKonfirmasiTransaksiPage(),
        );

      // Member Voucher Data
      case MemberVoucherDataProviderPage.routeName:
        return _customTransition(child: const MemberVoucherDataProviderPage());
      case MemberVoucherDataProdukPage.routeName:
        return _customTransition(child: const MemberVoucherDataProdukPage());
      case MemberVoucherDataKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberVoucherDataKonfirmasiTransaksiPage(),
        );

      // Member Voucher Digital
      case MemberVoucherDigitalProviderPage.routeName:
        return _customTransition(
          child: const MemberVoucherDigitalProviderPage(),
        );
      case MemberVoucherDigitalProdukPage.routeName:
        return _customTransition(child: const MemberVoucherDigitalProdukPage());
      case MemberVoucherDigitalKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberVoucherDigitalKonfirmasiTransaksiPage(),
        );

      // Member hp pasca
      case MemberHpPascaProviderPage.routeName:
        return _customTransition(child: const MemberHpPascaProviderPage());
      case MemberHpPascaProdukPage.routeName:
        return _customTransition(child: const MemberHpPascaProdukPage());
      case MemberHpPascaKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberHpPascaKonfirmasiTransaksiPage(),
        );

      // Member Pln Tagihan
      case MemberPlnTagihanProviderPage.routeName:
        return _customTransition(child: const MemberPlnTagihanProviderPage());
      case MemberPlnTagihanProdukPage.routeName:
        return _customTransition(child: const MemberPlnTagihanProdukPage());
      case MemberPlnTagihanKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPlnTagihanKonfirmasiTransaksiPage(),
        );

      // Member Uang Elektronik
      case MemberUangElektronikProviderPage.routeName:
        return _customTransition(
          child: const MemberUangElektronikProviderPage(),
        );
      case MemberUangElektronikProdukPage.routeName:
        return _customTransition(child: const MemberUangElektronikProdukPage());
      case MemberUangElektronikKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberUangElektronikKonfirmasiTransaksiPage(),
        );

      // Member Dompet Digital
      case MemberDompetDigitalProviderPage.routeName:
        return _customTransition(
          child: const MemberDompetDigitalProviderPage(),
        );
      case MemberDompetDigitalProdukPage.routeName:
        return _customTransition(child: const MemberDompetDigitalProdukPage());
      case MemberDompetDigitalProdukNominalBebasPage.routeName:
        return _customTransition(
          child: const MemberDompetDigitalProdukNominalBebasPage(),
        );
      case MemberDompetDigitalKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberDompetDigitalKonfirmasiTransaksiPage(),
        );

      case MemberDompetDigitalNominalBebasKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberDompetDigitalNominalBebasKonfirmasiTransaksiPage(),
        );

      // Member BPJS Kesehatan
      case MemberBpjsKesehatanProviderPage.routeName:
        return _customTransition(
          child: const MemberBpjsKesehatanProviderPage(),
        );
      case MemberBpjsKesehatanProdukPage.routeName:
        return _customTransition(child: const MemberBpjsKesehatanProdukPage());
      case MemberBpjsKesehatanKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberBpjsKesehatanKonfirmasiTransaksiPage(),
        );

      // Member BPJS TKN
      case MemberBpjsTknProviderPage.routeName:
        return _customTransition(child: const MemberBpjsTknProviderPage());
      case MemberBpjsTknProdukPage.routeName:
        return _customTransition(child: const MemberBpjsTknProdukPage());
      case MemberBpjsTknKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberBpjsTknKonfirmasiTransaksiPage(),
        );

      // Member E-Commerce
      case MemberECommerceProviderPage.routeName:
        return _customTransition(child: const MemberECommerceProviderPage());
      case MemberECommerceProdukPage.routeName:
        return _customTransition(child: const MemberECommerceProdukPage());
      case MemberECommerceKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberECommerceKonfirmasiTransaksiPage(),
        );

      // Member E-Samsat
      case MemberESamsatProviderPage.routeName:
        return _customTransition(child: const MemberESamsatProviderPage());
      case MemberESamsatProdukPage.routeName:
        return _customTransition(child: const MemberESamsatProdukPage());
      case MemberESamsatKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberESamsatKonfirmasiTransaksiPage(),
        );

      // Member Internet & TV
      case MemberInternetTvProviderPage.routeName:
        return _customTransition(child: const MemberInternetTvProviderPage());
      case MemberInternetTvProdukPage.routeName:
        return _customTransition(child: const MemberInternetTvProdukPage());
      case MemberInternetTvKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberInternetTvKonfirmasiTransaksiPage(),
        );

      // Member PBB
      case MemberPbbProviderPage.routeName:
        return _customTransition(child: const MemberPbbProviderPage());
      case MemberPbbProdukPage.routeName:
        return _customTransition(child: const MemberPbbProdukPage());
      case MemberPbbKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPbbKonfirmasiTransaksiPage(),
        );

      // Member PDAM
      case MemberPdamProviderPage.routeName:
        return _customTransition(child: const MemberPdamProviderPage());
      case MemberPdamProdukPage.routeName:
        return _customTransition(child: const MemberPdamProdukPage());
      case MemberPdamKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPdamKonfirmasiTransaksiPage(),
        );

      // Member Tagihan Gas
      case MemberTagihanGasProviderPage.routeName:
        return _customTransition(child: const MemberTagihanGasProviderPage());
      case MemberTagihanGasProdukPage.routeName:
        return _customTransition(child: const MemberTagihanGasProdukPage());
      case MemberTagihanGasKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberTagihanGasKonfirmasiTransaksiPage(),
        );

      // Member Paket Cuan
      case MemberPaketCuanProviderPage.routeName:
        return _customTransition(child: const MemberPaketCuanProviderPage());
      case MemberPaketCuanSubProviderPage.routeName:
        return _customTransition(child: const MemberPaketCuanSubProviderPage());
      case MemberPaketCuanProdukPage.routeName:
        return _customTransition(child: const MemberPaketCuanProdukPage());
      case MemberPaketCuanKonfirmasiTransaksiPage.routeName:
        return _customTransition(
          child: const MemberPaketCuanKonfirmasiTransaksiPage(),
        );

      case CalculatorPage.routeName:
        return _customTransition(child: const CalculatorPage());

      case BannerPage.routeName:
        return _customTransition(child: const BannerPage());

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
