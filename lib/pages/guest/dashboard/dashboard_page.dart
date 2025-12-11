import 'package:dmpku/core/helpers/launch_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/auth/login/request_otp_login_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_perdana/aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_perdana/guest_aktivasi_perdana_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_aktivasi_voucher_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/cek_status_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/guest_cek_status_voucher_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/info_kartu/guest_info_kartu_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/info_kartu/info_kartu_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/guest_masa_aktif_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/masa_aktif_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/guest_paket_data_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/paket_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/guest_paket_nelpon_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/paket_nelpon_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_streaming/guest_paket_streaming_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_streaming/paket_streaming_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_tv/guest_paket_tv_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_tv/paket_tv_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/token_pln/guest_token_pln_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/token_pln/token_pln_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/guest_topup_game_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/topup_game_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_data/guest_voucher_data_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_data/voucher_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_digital/guest_voucher_digital_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_digital/voucher_digital_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/wifi_id/guest_wifi_id_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/wifi_id/wifi_id_provider.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/guest_paket_cuan_provider_page.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/widgets/beranda/menu_section.dart';
import 'package:dmpku/widgets/beranda/paket_cuan_banner.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/dashboard_app_bar.dart';
import 'widgets/dashboard_header.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scrollController = ScrollController();
  double _opacity = 0.0;

  static const _scrollThreshold = 150.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final newOpacity = (_scrollController.offset / _scrollThreshold).clamp(
      0.0,
      1.0,
    );
    if (newOpacity != _opacity) {
      setState(() => _opacity = newOpacity);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: DashboardHeader(
                    salesMenus: _salesMenus,
                    onPromoTap: _handleMasukTap,
                    onMenuTap: _handleMenuTap,
                  ),
                ),
                SliverToBoxAdapter(child: MenuSection(menus: _isiUlangMenus)),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: _handlePaketCuanTap,
                    child: PaketCuanBanner(onTap: _handlePaketCuanTap),
                  ),
                ),
              ],
            ),
            DashboardAppBar(
              opacity: _opacity,
              onNotificationTap: _handleNotificationTap,
              onHelpTap: _handleHelpTap,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Menu Data
  // ============================================================

  List<MenuData> get _salesMenus => [
    MenuData('Kasir', Assets.img.menuPenjualan.icKasir.provider()),
    MenuData('Catatan', Assets.img.menuPenjualan.icCatatan.provider()),
    MenuData('Kalkulator', Assets.img.menuPenjualan.icKalkulator.provider()),
    MenuData('Favorit', Assets.img.menuPenjualan.icFavorit.provider()),
    MenuData('Banner', Assets.img.menuPenjualan.icBanner.provider()),
  ];

  List<MenuData> get _isiUlangMenus => [
    MenuData(
      "Pulsa",
      Assets.img.menuIsiUlang.iconPulsa.provider(),
      onTap: () {
        getPulsaProvider(context).fetchProviders();
        pushNamed(GuestPulsaProviderPage.routeName);
      },
    ),
    MenuData(
      "Paket Data",
      Assets.img.menuIsiUlang.iconPaketData.provider(),
      onTap: () {
        getPaketDataProvider(context).fetchProviders();
        pushNamed(GuestPaketDataProviderPage.routeName);
      },
    ),
    MenuData(
      "Paket SMS & Telepon",
      Assets.img.menuIsiUlang.iconPaketSmsTelepon.provider(),
      onTap: () {
        getPaketNelponProvider(context).fetchProviders();
        pushNamed(GuestPaketNelponProviderPage.routeName);
      },
    ),
    MenuData(
      "Masa Aktif",
      Assets.img.menuIsiUlang.iconMasaAktif.provider(),
      onTap: () {
        getMasaAktifProvider(context).fetchProviders();
        pushNamed(GuestMasaAktifProviderPage.routeName);
      },
    ),
    MenuData(
      "Topup Game",
      Assets.img.menuIsiUlang.iconTopupGame.provider(),
      onTap: () {
        getTopupGameProvider(context).fetchProviders();
        pushNamed(GuestTopupGameProviderPage.routeName);
      },
    ),
    MenuData(
      "Token PLN",
      Assets.img.menuIsiUlang.iconTokenPln.provider(),
      onTap: () {
        getTokenPlnProvider(context).fetchProducts();
        pushNamed(GuestTokenPlnProdukPage.routeName);
      },
    ),
    MenuData(
      "Aktivasi Voucher",
      Assets.img.menuIsiUlang.iconAktivasiVoucher.provider(),
      onTap: () {
        getAktivasiVoucherProvider(context).fetchProviders();
        pushNamed(GuestAktivasiVoucherProviderPage.routeName);
      },
    ),
    MenuData(
      "Voucher Data",
      Assets.img.menuIsiUlang.iconVoucherData.provider(),
      onTap: () {
        getVoucherDataProvider(context).fetchProviders();
        pushNamed(GuestVoucherDataProviderPage.routeName);
      },
    ),
    MenuData(
      "Aktivasi Perdana",
      Assets.img.menuIsiUlang.iconAktivasiPerdana.provider(),
      onTap: () {
        getAktivasiPerdanaProvider(context).fetchProviders();
        pushNamed(GuestAktivasiPerdanaProviderPage.routeName);
      },
    ),
    MenuData(
      "Cek Status Voucher",
      Assets.img.menuIsiUlang.iconCekStatusVoucher.provider(),
      onTap: () {
        getCekStatusVoucherProvider(context).fetchProducts();
        pushNamed(GuestCekStatusVoucherProviderPage.routeName);
      },
    ),
    MenuData(
      "Info Kartu",
      Assets.img.menuIsiUlang.iconInfoKartu.provider(),
      onTap: () {
        getInfoKartuProvider(context).fetchProducts();
        pushNamed(GuestInfoKartuProviderPage.routeName);
      },
    ),
    MenuData(
      "Voucher Digital",
      Assets.img.menuIsiUlang.iconVoucherDigital.provider(),
      onTap: () {
        getVoucherDigitalProvider(context).fetchProviders();
        pushNamed(GuestVoucherDigitalProviderPage.routeName);
      },
    ),
    MenuData(
      "Paket TV",
      Assets.img.menuIsiUlang.iconPaketTv.provider(),
      onTap: () {
        getPaketTvProvider(context).fetchProviders();
        pushNamed(GuestPaketTvProviderPage.routeName);
      },
    ),
    MenuData(
      "Paket Streaming",
      Assets.img.menuIsiUlang.iconPaketStreaming.provider(),
      onTap: () {
        getPaketStreamingProvider(context).fetchProviders();
        pushNamed(GuestPaketStreamingProviderPage.routeName);
      },
    ),
    MenuData(
      "Wifi ID",
      Assets.img.menuIsiUlang.iconWifiId.provider(),
      onTap: () {
        getWifiIdProvider(context).fetchProducts();
        pushNamed(GuestWifiIdProdukPage.routeName);
      },
    ),
  ];

  // ============================================================
  // Event Handlers
  // ============================================================

  void _handleMenuTap(String menuTitle) {
    BelumLoginDialog.show(context);
  }

  void _handleMasukTap() {
    pushNamed(RequestOtpLoginPage.routeName);
  }

  void _handlePaketCuanTap() {
    getPaketCuanProvider(context).fetchProviders();
    pushNamed(GuestPaketCuanProviderPage.routeName);
  }

  void _handleNotificationTap() async {
    final link = await SecureStorageHelper.instance.getChannelWa();
    await launchUrlApp(link);
  }

  void _handleHelpTap() {
    openBantuanWaGuest();
  }
}
