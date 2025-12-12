import 'package:dmpku/core/helpers/launch_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/dashboard/widgets/dashboard_app_bar.dart';
import 'package:dmpku/pages/member/dashboard/widgets/dashboard_header.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/cek_status_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/info_kartu_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/masa_aktif_provider.dart'
    as member_masa_aktif;
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/paket_data_provider.dart'
    as member_paket_data;
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/paket_nelpon_provider.dart'
    as member_paket_nelpon;
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/paket_streaming_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/paket_tv_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/token_pln_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/voucher_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/voucher_digital_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_produk_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_alt.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
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
                      subtitle:
                          'Isi Ulang Produk Digital sesuai kebutuhan Anda',
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
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
            DashboardAppBar(
              opacity: _opacity,
              onNotificationTap: _handleNotificationTap,
              onHelpTap: () => _handleHelpTap(context),
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
      onTap: () {
        pushNamed(MemberPaketDataProviderPage.routeName);
        member_paket_data.getMemberPaketDataProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Paket SMS & Telepon",
      Assets.img.menuIsiUlang.iconPaketSmsTelepon.provider(),
      onTap: () {
        pushNamed(MemberPaketNelponProviderPage.routeName);
        member_paket_nelpon
            .getMemberPaketNelponProvider(context)
            .fetchProviders();
      },
    ),
    MenuData(
      "Masa Aktif",
      Assets.img.menuIsiUlang.iconMasaAktif.provider(),
      onTap: () {
        pushNamed(MemberMasaAktifProviderPage.routeName);
        member_masa_aktif.getMemberMasaAktifProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Topup Game",
      Assets.img.menuIsiUlang.iconTopupGame.provider(),
      onTap: () {
        pushNamed(MemberTopupGameProviderPage.routeName);
        getMemberTopupGameProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Token PLN",
      Assets.img.menuIsiUlang.iconTokenPln.provider(),
      onTap: () {
        pushNamed(MemberTokenPlnProdukPage.routeName);
        getMemberTokenPlnProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "Aktivasi Voucher",
      Assets.img.menuIsiUlang.iconAktivasiVoucher.provider(),
      onTap: () {
        pushNamed(MemberAktivasiVoucherProviderPage.routeName);
        getMemberAktivasiVoucherProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Voucher Data",
      Assets.img.menuIsiUlang.iconVoucherData.provider(),
      onTap: () {
        pushNamed(MemberVoucherDataProviderPage.routeName);
        getMemberVoucherDataProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Aktivasi Perdana",
      Assets.img.menuIsiUlang.iconAktivasiPerdana.provider(),
      onTap: () {
        pushNamed(MemberAktivasiPerdanaProviderPage.routeName);
        getMemberAktivasiPerdanaProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Cek Status Voucher",
      Assets.img.menuIsiUlang.iconCekStatusVoucher.provider(),
      onTap: () {
        pushNamed(MemberCekStatusVoucherProviderPage.routeName);
        getMemberCekStatusVoucherProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "Info Kartu",
      Assets.img.menuIsiUlang.iconInfoKartu.provider(),
      onTap: () {
        pushNamed(MemberInfoKartuProviderPage.routeName);
        getMemberInfoKartuProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "Voucher Digital",
      Assets.img.menuIsiUlang.iconVoucherDigital.provider(),
      onTap: () {
        pushNamed(MemberVoucherDigitalProviderPage.routeName);
        getMemberVoucherDigitalProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Paket TV",
      Assets.img.menuIsiUlang.iconPaketTv.provider(),
      onTap: () {
        pushNamed(MemberPaketTvProviderPage.routeName);
        getMemberPaketTvProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Paket Streaming",
      Assets.img.menuIsiUlang.iconPaketStreaming.provider(),
      onTap: () {
        pushNamed(MemberPaketStreamingProviderPage.routeName);
        getMemberPaketStreamingProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Wifi ID",
      Assets.img.menuIsiUlang.iconWifiId.provider(),
      onTap: () {
        pushNamed(MemberWifiIdProdukPage.routeName);
      },
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

  void _handleNotificationTap() async {
    final link = await SecureStorageHelper.instance.getChannelWa();
    await launchUrlApp(link);
  }

  void _handleHelpTap(BuildContext context) async {
    await openBantuanWa(context);
  }

}
