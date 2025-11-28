import 'package:dmpku/core/helpers/encrypt_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/dashboard/widgets/menu_button.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_provider_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/dashboard_app_bar.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/isi_ulang_section.dart';
import 'widgets/paket_cuan_banner.dart';

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
                    onPromoTap: _handlePromoTap,
                    onMenuTap: _handleMenuTap,
                  ),
                ),
                SliverToBoxAdapter(
                  child: IsiUlangSection(menus: _isiUlangMenus),
                ),
                SliverToBoxAdapter(
                  child: PaketCuanBanner(onTap: _handlePaketCuanTap),
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
        getPulsaProvider(context).fetchPulsaProviders();
        pushNamed(GuestPulsaProviderPage.routeName);
      },
    ),
    MenuData("Paket Data", Assets.img.menuIsiUlang.iconPaketData.provider()),
    MenuData(
      "Paket SMS & Telepon",
      Assets.img.menuIsiUlang.iconPaketSmsTelepon.provider(),
    ),
    MenuData("Masa Aktif", Assets.img.menuIsiUlang.iconMasaAktif.provider()),
    MenuData("Topup Game", Assets.img.menuIsiUlang.iconTopupGame.provider()),
    MenuData("Token PLN", Assets.img.menuIsiUlang.iconTokenPln.provider()),
    MenuData(
      "Aktivasi Voucher",
      Assets.img.menuIsiUlang.iconAktivasiVoucher.provider(),
    ),
    MenuData(
      "Voucher Data",
      Assets.img.menuIsiUlang.iconVoucherData.provider(),
    ),
    MenuData(
      "Aktivasi Perdana",
      Assets.img.menuIsiUlang.iconAktivasiPerdana.provider(),
    ),
    MenuData(
      "Cek Status Voucher",
      Assets.img.menuIsiUlang.iconCekStatusVoucher.provider(),
    ),
    MenuData("Info Kartu", Assets.img.menuIsiUlang.iconInfoKartu.provider()),
    MenuData(
      "Voucher Digital",
      Assets.img.menuIsiUlang.iconVoucherDigital.provider(),
    ),
    MenuData("Paket TV", Assets.img.menuIsiUlang.iconPaketTv.provider()),
    MenuData(
      "Paket Streaming",
      Assets.img.menuIsiUlang.iconPaketStreaming.provider(),
    ),
    MenuData("Wifi ID", Assets.img.menuIsiUlang.iconWifiId.provider()),
  ];

  // ============================================================
  // Event Handlers
  // ============================================================

  void _handleMenuTap(String menuTitle) {
    BelumLoginDialog.show(context);
  }

  void _handlePromoTap() {
    debugPrint('Promo tapped');
    // TODO: Navigate to login/register
  }

  void _handlePaketCuanTap() {
    debugPrint('Paket Cuan tapped');
    // TODO: Navigate to paket cuan page
  }

  void _handleNotificationTap() {
    debugPrint('Notification tapped');
    // TODO: Navigate to notifications
  }

  void _handleHelpTap() {
    debugPrint('Help tapped');
    // TODO: Navigate to help/support
  }
}
