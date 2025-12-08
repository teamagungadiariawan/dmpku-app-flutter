import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/dashboard/widgets/dashboard_app_bar.dart';
import 'package:dmpku/pages/member/dashboard/widgets/dashboard_header.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/beranda/menu_section.dart';
import 'package:dmpku/widgets/beranda/paket_cuan_banner.dart';
import 'package:dmpku/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberDashboardPage extends StatefulWidget {
  const MemberDashboardPage({super.key});

  @override
  State<MemberDashboardPage> createState() => _MemberDashboardPageState();
}

class _MemberDashboardPageState extends State<MemberDashboardPage> {
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

  Future<void> _onRefresh() async {
    await getMemberProvider(context).getProfile();
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
            RefreshIndicator(
              onRefresh: _onRefresh,
              color: context.primary,
              backgroundColor: context.card,
              edgeOffset: kToolbarHeight + MediaQuery.of(context).padding.top,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: DashboardHeader(
                      onPromoTap: () {},
                      onMenuTap: _handleMenuTap,
                      salesMenus: _salesMenus,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MenuSection(
                      title: 'Isi Ulang',
                      subtitle: 'Isi Ulang Produk Digital sesuai kebutuhan Anda',
                      menus: _isiUlangMenus,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: _handlePaketCuanTap,
                      child: PaketCuanBanner(onTap: _handlePaketCuanTap),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                      child: MenuSection(
                        title: 'Top Up E-Wallet & Bayar Tagihan',
                        subtitle:
                        'Top Up E-Wallet dan Bayar Tagihan secara mudah dan cepat',
                        menus: _ppobMenus,
                      ),
                    ),
                  ),
                  // Extra space at bottom
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                ],
              ),
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
        pushNamed(MemberPulsaProviderPage.routeName);
        getMemberPulsaProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Paket Data",
      Assets.img.menuIsiUlang.iconPaketData.provider(),
      onTap: () {},
    ),
    MenuData(
      "Paket SMS & Telepon",
      Assets.img.menuIsiUlang.iconPaketSmsTelepon.provider(),
      onTap: () {},
    ),
    MenuData(
      "Masa Aktif",
      Assets.img.menuIsiUlang.iconMasaAktif.provider(),
      onTap: () {},
    ),
    MenuData(
      "Topup Game",
      Assets.img.menuIsiUlang.iconTopupGame.provider(),
      onTap: () {},
    ),
    MenuData(
      "Token PLN",
      Assets.img.menuIsiUlang.iconTokenPln.provider(),
      onTap: () {},
    ),
    MenuData(
      "Aktivasi Voucher",
      Assets.img.menuIsiUlang.iconAktivasiVoucher.provider(),
      onTap: () {},
    ),
    MenuData(
      "Voucher Data",
      Assets.img.menuIsiUlang.iconVoucherData.provider(),
      onTap: () {},
    ),
    MenuData(
      "Aktivasi Perdana",
      Assets.img.menuIsiUlang.iconAktivasiPerdana.provider(),
      onTap: () {},
    ),
    MenuData(
      "Cek Status Voucher",
      Assets.img.menuIsiUlang.iconCekStatusVoucher.provider(),
      onTap: () {},
    ),
    MenuData(
      "Info Kartu",
      Assets.img.menuIsiUlang.iconInfoKartu.provider(),
      onTap: () {},
    ),
    MenuData(
      "Voucher Digital",
      Assets.img.menuIsiUlang.iconVoucherDigital.provider(),
      onTap: () {},
    ),
    MenuData(
      "Paket TV",
      Assets.img.menuIsiUlang.iconPaketTv.provider(),
      onTap: () {},
    ),
    MenuData(
      "Paket Streaming",
      Assets.img.menuIsiUlang.iconPaketStreaming.provider(),
      onTap: () {},
    ),
    MenuData(
      "Wifi ID",
      Assets.img.menuIsiUlang.iconWifiId.provider(),
      onTap: () {},
    ),
  ];

  List<MenuData> get _ppobMenus => [
    MenuData(
      "Dompet Digital",
      Assets.img.menuPpob.iconDompetDigital.provider(),
      onTap: () {},
    ),
    MenuData(
      "Uang Elektronik",
      Assets.img.menuPpob.iconUangElektronik.provider(),
      onTap: () {},
    ),
    MenuData(
      "PLN Tagihan",
      Assets.img.menuPpob.iconPlnTagihan.provider(),
      onTap: () {},
    ),
    MenuData(
      "HP Pasca",
      Assets.img.menuPpob.iconHpPasca.provider(),
      onTap: () {},
    ),
    MenuData(
      "Tagihan Gas",
      Assets.img.menuPpob.iconTagihanGas.provider(),
      onTap: () {},
    ),
    MenuData("PDAM", Assets.img.menuPpob.iconPdam.provider(), onTap: () {}),
    MenuData(
      "Internet & TV",
      Assets.img.menuPpob.iconInternetTv.provider(),
      onTap: () {},
    ),
    MenuData(
      "BPJS Kesehatan",
      Assets.img.menuPpob.iconBpjsKesehatan.provider(),
      onTap: () {},
    ),
    MenuData(
      "BPJS TKN",
      Assets.img.menuPpob.iconBpjsTkn.provider(),
      onTap: () {},
    ),
    MenuData(
      "E-Commerce",
      Assets.img.menuPpob.iconEcommerce.provider(),
      onTap: () {},
    ),
    MenuData(
      "E-SAMSAT",
      Assets.img.menuPpob.iconEsamsat.provider(),
      onTap: () {},
    ),
    MenuData("PBB", Assets.img.menuPpob.iconPbb.provider(), onTap: () {}),
  ];

  // ============================================================
  // Event Handlers
  // ============================================================

  void _handleMenuTap(String menuTitle) {}

  void _handlePaketCuanTap() {}

  void _handleNotificationTap() {
    debugPrint('Notification tapped');
  }

  void _handleHelpTap() {
    debugPrint('Help tapped');
  }
}