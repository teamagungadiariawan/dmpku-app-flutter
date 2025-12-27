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
import 'package:dmpku/pages/member/kasir/calculator/calculator_page.dart';
import 'package:dmpku/pages/member/akun/daftar_devices/member_daftar_devices.dart';
import 'package:dmpku/pages/member/akun/detail_akun/member_detail_akun_page.dart';
import 'package:dmpku/pages/member/akun/favorit/member_daftar_favorit_page.dart';
import 'package:dmpku/pages/member/banner/banner_page.dart';
import 'package:dmpku/pages/member/kasir/catatan/member_catatan_page.dart';
import 'package:dmpku/pages/member/kasir/menu_penjualan_page.dart';

import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_perdana/aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/cek_status_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/info_kartu/info_kartu_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/masa_aktif_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/paket_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/paket_nelpon_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_streaming/paket_streaming_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_tv/paket_tv_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/token_pln/token_pln_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/topup_game_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_data/voucher_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_digital/voucher_digital_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/wifi_id/wifi_id_provider.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/paket_cuan_provider.dart';
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
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider.dart';
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
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_provider.dart';
import 'package:dmpku/pages/member/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_provider.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return _customTransition(
          child: BlocProvider(
            create: (_) => PulsaProvider()..fetchProviders(),
            child: const GuestPulsaProviderPage(),
          ),
        );
      case GuestPulsaProdukPage.routeName:
        final bloc = settings.arguments as PulsaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPulsaProdukPage(),
          ),
        );

      // Guest Paket Data
      case GuestPaketDataProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => PaketDataProvider()..fetchProviders(),
            child: const GuestPaketDataProviderPage(),
          ),
        );
      case GuestPaketDataProdukPage.routeName:
        final bloc = settings.arguments as PaketDataProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPaketDataProdukPage(),
          ),
        );

      // Guest Masa Aktif
      case GuestMasaAktifProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MasaAktifProvider()..fetchProviders(),
            child: const GuestMasaAktifProviderPage(),
          ),
        );
      case GuestMasaAktifProdukPage.routeName:
        final bloc = settings.arguments as MasaAktifProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestMasaAktifProdukPage(),
          ),
        );

      // Guest Paket Nelpon
      case GuestPaketNelponProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => PaketNelponProvider()..fetchProviders(),
            child: const GuestPaketNelponProviderPage(),
          ),
        );
      case GuestPaketNelponProdukPage.routeName:
        final bloc = settings.arguments as PaketNelponProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPaketNelponProdukPage(),
          ),
        );

      // Guest Topup Game
      case GuestTopupGameProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => TopupGameProvider()..fetchProviders(),
            child: const GuestTopupGameProviderPage(),
          ),
        );
      case GuestTopupGameProdukPage.routeName:
        final bloc = settings.arguments as TopupGameProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestTopupGameProdukPage(),
          ),
        );

      // Guest Token PLN
      case GuestTokenPlnProdukPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => TokenPlnProvider()..fetchProducts(),
            child: const GuestTokenPlnProdukPage(),
          ),
        );

      // Guest Aktivasi Voucher
      case GuestAktivasiVoucherProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => AktivasiVoucherProvider()..fetchProviders(),
            child: const GuestAktivasiVoucherProviderPage(),
          ),
        );
      case GuestAktivasiVoucherProdukPage.routeName:
        final bloc = settings.arguments as AktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestAktivasiVoucherProdukPage(),
          ),
        );
      case GuestAkitvasiVoucherBerurutanPage.routeName:
        final bloc = settings.arguments as AktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestAkitvasiVoucherBerurutanPage(),
          ),
        );
      case GuestAkitvasiVoucherSatuanPage.routeName:
        final bloc = settings.arguments as AktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestAkitvasiVoucherSatuanPage(),
          ),
        );

      // Guest Voucher Data
      case GuestVoucherDataProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => VoucherDataProvider()..fetchProviders(),
            child: const GuestVoucherDataProviderPage(),
          ),
        );
      case GuestVoucherDataProdukPage.routeName:
        final bloc = settings.arguments as VoucherDataProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestVoucherDataProdukPage(),
          ),
        );

      // Guest Wifi ID
      case GuestWifiIdProdukPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => WifiIdProvider()..fetchProducts(),
            child: const GuestWifiIdProdukPage(),
          ),
        );

      // Guest Paket TV
      case GuestPaketTvProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => PaketTvProvider()..fetchProviders(),
            child: const GuestPaketTvProviderPage(),
          ),
        );
      case GuestPaketTvProdukPage.routeName:
        final bloc = settings.arguments as PaketTvProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPaketTvProdukPage(),
          ),
        );

      // Guest Info Kartu
      case GuestInfoKartuProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => InfoKartuProvider()..fetchProducts(),
            child: const GuestInfoKartuProviderPage(),
          ),
        );
      case GuestInfoKartuProdukPage.routeName:
        final bloc = settings.arguments as InfoKartuProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestInfoKartuProdukPage(),
          ),
        );

      // Guest Paket Streaming
      case GuestPaketStreamingProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => PaketStreamingProvider()..fetchProviders(),
            child: const GuestPaketStreamingProviderPage(),
          ),
        );
      case GuestPaketStreamingProdukPage.routeName:
        final bloc = settings.arguments as PaketStreamingProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPaketStreamingProdukPage(),
          ),
        );

      // Guest Voucher Digital
      case GuestVoucherDigitalProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => VoucherDigitalProvider()..fetchProviders(),
            child: const GuestVoucherDigitalProviderPage(),
          ),
        );
      case GuestVoucherDigitalProdukPage.routeName:
        final bloc = settings.arguments as VoucherDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestVoucherDigitalProdukPage(),
          ),
        );

      // Guest Aktivasi Perdana
      case GuestAktivasiPerdanaProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => AktivasiPerdanaProvider()..fetchProviders(),
            child: const GuestAktivasiPerdanaProviderPage(),
          ),
        );
      case GuestAktivasiPerdanaProdukPage.routeName:
        final bloc = settings.arguments as AktivasiPerdanaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestAktivasiPerdanaProdukPage(),
          ),
        );

      // Guest Cek Status Voucher
      case GuestCekStatusVoucherProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => CekStatusVoucherProvider()..fetchProducts(),
            child: const GuestCekStatusVoucherProviderPage(),
          ),
        );
      case GuestCekStatusVoucherProdukPage.routeName:
        final bloc = settings.arguments as CekStatusVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestCekStatusVoucherProdukPage(),
          ),
        );

      // Guest Paket Cuan
      case GuestPaketCuanProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => PaketCuanProvider()..fetchProviders(),
            child: const GuestPaketCuanProviderPage(),
          ),
        );
      case GuestPaketCuanSubProviderPage.routeName:
        final bloc = settings.arguments as PaketCuanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPaketCuanSubProviderPage(),
          ),
        );
      case GuestPaketCuanProdukPage.routeName:
        final bloc = settings.arguments as PaketCuanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const GuestPaketCuanProdukPage(),
          ),
        );

      // Member
      case MemberMainPage.routeName:
        final args = settings.arguments as int?;
        return _customTransitionBottomToTop(
          child: MemberMainPage(initialIndex: args ?? 0),
        );

      case MemberCatatanPage.routeName:
        return _customTransition(child: const MemberCatatanPage());
      case MemberMenuPenjualanPage.routeName:
        return _customTransition(child: const MemberMenuPenjualanPage());

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
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPulsaProvider()..fetchProviders(),
            child: const MemberPulsaProviderPage(),
          ),
        );
      case MemberPulsaProdukPage.routeName:
        final bloc = settings.arguments as MemberPulsaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPulsaProdukPage(),
          ),
        );
      case MemberPulsaKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPulsaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPulsaKonfirmasiTransaksiPage(),
          ),
        );

      // Member Paket Data
      case MemberPaketDataProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPaketDataProvider()..fetchProviders(),
            child: const MemberPaketDataProviderPage(),
          ),
        );
      case MemberPaketDataProdukPage.routeName:
        final bloc = settings.arguments as MemberPaketDataProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketDataProdukPage(),
          ),
        );
      case MemberPaketDataKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPaketDataProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketDataKonfirmasiTransaksiPage(),
          ),
        );

      // Member Masa Aktif
      case MemberMasaAktifProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberMasaAktifProvider()..fetchProviders(),
            child: const MemberMasaAktifProviderPage(),
          ),
        );
      case MemberMasaAktifProdukPage.routeName:
        final bloc = settings.arguments as MemberMasaAktifProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberMasaAktifProdukPage(),
          ),
        );
      case MemberMasaAktifKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberMasaAktifProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberMasaAktifKonfirmasiTransaksiPage(),
          ),
        );

      // Member Paket Nelpon
      case MemberPaketNelponProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPaketNelponProvider()..fetchProviders(),
            child: const MemberPaketNelponProviderPage(),
          ),
        );
      case MemberPaketNelponProdukPage.routeName:
        final bloc = settings.arguments as MemberPaketNelponProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketNelponProdukPage(),
          ),
        );
      case MemberPaketNelponKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPaketNelponProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketNelponKonfirmasiTransaksiPage(),
          ),
        );

      // Member Topup Game
      case MemberTopupGameProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberTopupGameProvider()..fetchProviders(),
            child: const MemberTopupGameProviderPage(),
          ),
        );
      case MemberTopupGameProdukPage.routeName:
        final bloc = settings.arguments as MemberTopupGameProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberTopupGameProdukPage(),
          ),
        );
      case MemberTopupGameKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberTopupGameProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberTopupGameKonfirmasiTransaksiPage(),
          ),
        );

      // Member Wifi ID
      case MemberWifiIdProdukPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberWifiIdProvider()..fetchProducts(),
            child: const MemberWifiIdProdukPage(),
          ),
        );
      case MemberWifiIdKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberWifiIdProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberWifiIdKonfirmasiTransaksiPage(),
          ),
        );

      // Member Paket TV
      case MemberPaketTvProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPaketTvProvider()..fetchProviders(),
            child: const MemberPaketTvProviderPage(),
          ),
        );
      case MemberPaketTvProdukPage.routeName:
        final bloc = settings.arguments as MemberPaketTvProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketTvProdukPage(),
          ),
        );
      case MemberPaketTvKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPaketTvProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketTvKonfirmasiTransaksiPage(),
          ),
        );

      // Member Token PLN
      case MemberTokenPlnProdukPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberTokenPlnProvider()..fetchProducts(),
            child: const MemberTokenPlnProdukPage(),
          ),
        );
      case MemberTokenPlnKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberTokenPlnProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberTokenPlnKonfirmasiTransaksiPage(),
          ),
        );

      // Member Info Kartu
      case MemberInfoKartuProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberInfoKartuProvider()..fetchProducts(),
            child: const MemberInfoKartuProviderPage(),
          ),
        );
      case MemberInfoKartuProdukPage.routeName:
        final bloc = settings.arguments as MemberInfoKartuProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberInfoKartuProdukPage(),
          ),
        );

      // Member Aktivasi Perdana
      case MemberAktivasiPerdanaProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberAktivasiPerdanaProvider()..fetchProviders(),
            child: const MemberAktivasiPerdanaProviderPage(),
          ),
        );
      case MemberAktivasiPerdanaProdukPage.routeName:
        final bloc = settings.arguments as MemberAktivasiPerdanaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberAktivasiPerdanaProdukPage(),
          ),
        );
      case MemberAktivasiPerdanaKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberAktivasiPerdanaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberAktivasiPerdanaKonfirmasiTransaksiPage(),
          ),
        );

      // Member Aktivasi Voucher
      case MemberAktivasiVoucherProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberAktivasiVoucherProvider()..fetchProviders(),
            child: const MemberAktivasiVoucherProviderPage(),
          ),
        );
      case MemberAktivasiVoucherProdukPage.routeName:
        final bloc = settings.arguments as MemberAktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberAktivasiVoucherProdukPage(),
          ),
        );
      case MemberAkitvasiVoucherBerurutanPage.routeName:
        final bloc = settings.arguments as MemberAktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberAkitvasiVoucherBerurutanPage(),
          ),
        );
      case MemberAkitvasiVoucherSatuanPage.routeName:
        final bloc = settings.arguments as MemberAktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberAkitvasiVoucherSatuanPage(),
          ),
        );

      case MemberAktivasiVoucherKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberAktivasiVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberAktivasiVoucherKonfirmasiTransaksiPage(),
          ),
        );

      // Member Cek Status Voucher
      case MemberCekStatusVoucherProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberCekStatusVoucherProvider()..fetchProducts(),
            child: const MemberCekStatusVoucherProviderPage(),
          ),
        );
      case MemberCekStatusVoucherProdukPage.routeName:
        final bloc = settings.arguments as MemberCekStatusVoucherProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberCekStatusVoucherProdukPage(),
          ),
        );

      // Member Paket Streaming
      case MemberPaketStreamingProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPaketStreamingProvider()..fetchProviders(),
            child: const MemberPaketStreamingProviderPage(),
          ),
        );
      case MemberPaketStreamingProdukPage.routeName:
        final bloc = settings.arguments as MemberPaketStreamingProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketStreamingProdukPage(),
          ),
        );
      case MemberPaketStreamingKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPaketStreamingProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketStreamingKonfirmasiTransaksiPage(),
          ),
        );

      // Member Voucher Data
      case MemberVoucherDataProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberVoucherDataProvider()..fetchProviders(),
            child: const MemberVoucherDataProviderPage(),
          ),
        );
      case MemberVoucherDataProdukPage.routeName:
        final bloc = settings.arguments as MemberVoucherDataProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberVoucherDataProdukPage(),
          ),
        );
      case MemberVoucherDataKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberVoucherDataProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberVoucherDataKonfirmasiTransaksiPage(),
          ),
        );

      // Member Voucher Digital
      case MemberVoucherDigitalProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberVoucherDigitalProvider()..fetchProviders(),
            child: const MemberVoucherDigitalProviderPage(),
          ),
        );
      case MemberVoucherDigitalProdukPage.routeName:
        final bloc = settings.arguments as MemberVoucherDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberVoucherDigitalProdukPage(),
          ),
        );
      case MemberVoucherDigitalKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberVoucherDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberVoucherDigitalKonfirmasiTransaksiPage(),
          ),
        );

      // Member HP Pasca
      case MemberHpPascaProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberHpPascaProvider()..fetchProducts(),
            child: const MemberHpPascaProviderPage(),
          ),
        );
      case MemberHpPascaProdukPage.routeName:
        final bloc = settings.arguments as MemberHpPascaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberHpPascaProdukPage(),
          ),
        );
      case MemberHpPascaKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberHpPascaProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberHpPascaKonfirmasiTransaksiPage(),
          ),
        );

      // Member Pln Tagihan
      case MemberPlnTagihanProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPlnTagihanProvider()..fetchProducts(),
            child: const MemberPlnTagihanProviderPage(),
          ),
        );
      case MemberPlnTagihanProdukPage.routeName:
        final bloc = settings.arguments as MemberPlnTagihanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPlnTagihanProdukPage(),
          ),
        );
      case MemberPlnTagihanKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPlnTagihanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPlnTagihanKonfirmasiTransaksiPage(),
          ),
        );

      // Member Uang Elektronik
      case MemberUangElektronikProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberUangElektronikProvider()..fetchProviders(),
            child: const MemberUangElektronikProviderPage(),
          ),
        );
      case MemberUangElektronikProdukPage.routeName:
        final bloc = settings.arguments as MemberUangElektronikProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberUangElektronikProdukPage(),
          ),
        );
      case MemberUangElektronikKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberUangElektronikProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberUangElektronikKonfirmasiTransaksiPage(),
          ),
        );

      // Member Dompet Digital
      case MemberDompetDigitalProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberDompetDigitalProvider()..fetchProviders(),
            child: const MemberDompetDigitalProviderPage(),
          ),
        );
      case MemberDompetDigitalProdukPage.routeName:
        final bloc = settings.arguments as MemberDompetDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberDompetDigitalProdukPage(),
          ),
        );
      case MemberDompetDigitalKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberDompetDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberDompetDigitalKonfirmasiTransaksiPage(),
          ),
        );
      case MemberDompetDigitalProdukNominalBebasPage.routeName:
        final bloc = settings.arguments as MemberDompetDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberDompetDigitalProdukNominalBebasPage(),
          ),
        );
      case MemberDompetDigitalNominalBebasKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberDompetDigitalProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child:
                const MemberDompetDigitalNominalBebasKonfirmasiTransaksiPage(),
          ),
        );

      // Member BPJS Kesehatan
      // Member BPJS Kesehatan
      case MemberBpjsKesehatanProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberBpjsKesehatanProvider()..fetchProducts(),
            child: const MemberBpjsKesehatanProviderPage(),
          ),
        );
      case MemberBpjsKesehatanProdukPage.routeName:
        final bloc = settings.arguments as MemberBpjsKesehatanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberBpjsKesehatanProdukPage(),
          ),
        );
      case MemberBpjsKesehatanKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberBpjsKesehatanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberBpjsKesehatanKonfirmasiTransaksiPage(),
          ),
        );

      // Member BPJS TKN
      case MemberBpjsTknProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberBpjsTknProvider()..fetchProducts(),
            child: const MemberBpjsTknProviderPage(),
          ),
        );
      case MemberBpjsTknProdukPage.routeName:
        final bloc = settings.arguments as MemberBpjsTknProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberBpjsTknProdukPage(),
          ),
        );
      case MemberBpjsTknKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberBpjsTknProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberBpjsTknKonfirmasiTransaksiPage(),
          ),
        );

      // Member E-Commerce
      case MemberECommerceProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberECommerceProvider()..fetchProducts(),
            child: const MemberECommerceProviderPage(),
          ),
        );
      case MemberECommerceProdukPage.routeName:
        final bloc = settings.arguments as MemberECommerceProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberECommerceProdukPage(),
          ),
        );
      case MemberECommerceKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberECommerceProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberECommerceKonfirmasiTransaksiPage(),
          ),
        );

      // Member E-Samsat
      case MemberESamsatProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberESamsatProvider()..fetchProducts(),
            child: const MemberESamsatProviderPage(),
          ),
        );
      case MemberESamsatProdukPage.routeName:
        final bloc = settings.arguments as MemberESamsatProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberESamsatProdukPage(),
          ),
        );
      case MemberESamsatKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberESamsatProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberESamsatKonfirmasiTransaksiPage(),
          ),
        );

      // Member Internet & TV
      case MemberInternetTvProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberInternetTvProvider()..fetchProducts(),
            child: const MemberInternetTvProviderPage(),
          ),
        );
      case MemberInternetTvProdukPage.routeName:
        final bloc = settings.arguments as MemberInternetTvProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberInternetTvProdukPage(),
          ),
        );
      case MemberInternetTvKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberInternetTvProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberInternetTvKonfirmasiTransaksiPage(),
          ),
        );

      // Member PBB
      case MemberPbbProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPbbProvider()..fetchProducts(),
            child: const MemberPbbProviderPage(),
          ),
        );
      case MemberPbbProdukPage.routeName:
        final bloc = settings.arguments as MemberPbbProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPbbProdukPage(),
          ),
        );
      case MemberPbbKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPbbProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPbbKonfirmasiTransaksiPage(),
          ),
        );

      // Member PDAM
      case MemberPdamProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPdamProvider()..fetchProducts(),
            child: const MemberPdamProviderPage(),
          ),
        );
      case MemberPdamProdukPage.routeName:
        final bloc = settings.arguments as MemberPdamProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPdamProdukPage(),
          ),
        );
      case MemberPdamKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPdamProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPdamKonfirmasiTransaksiPage(),
          ),
        );

      // Member Tagihan Gas
      case MemberTagihanGasProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberTagihanGasProvider()..fetchProducts(),
            child: const MemberTagihanGasProviderPage(),
          ),
        );
      case MemberTagihanGasProdukPage.routeName:
        final bloc = settings.arguments as MemberTagihanGasProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberTagihanGasProdukPage(),
          ),
        );
      case MemberTagihanGasKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberTagihanGasProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberTagihanGasKonfirmasiTransaksiPage(),
          ),
        );

      // Member Paket Cuan
      case MemberPaketCuanProviderPage.routeName:
        return _customTransition(
          child: BlocProvider(
            create: (_) => MemberPaketCuanProvider()..fetchProviders(),
            child: const MemberPaketCuanProviderPage(),
          ),
        );
      case MemberPaketCuanSubProviderPage.routeName:
        final bloc = settings.arguments as MemberPaketCuanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketCuanSubProviderPage(),
          ),
        );
      case MemberPaketCuanProdukPage.routeName:
        final bloc = settings.arguments as MemberPaketCuanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketCuanProdukPage(),
          ),
        );
      case MemberPaketCuanKonfirmasiTransaksiPage.routeName:
        final bloc = settings.arguments as MemberPaketCuanProvider;
        return _customTransition(
          child: BlocProvider.value(
            value: bloc,
            child: const MemberPaketCuanKonfirmasiTransaksiPage(),
          ),
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
