import 'package:dmpku/core/helpers/launch_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/calculator/calculator_page.dart';
import 'package:dmpku/pages/member/akun/favorit/member_daftar_favorit_page.dart';
import 'package:dmpku/pages/member/banner/banner_page.dart' show BannerPage;
import 'package:dmpku/pages/member/dashboard/widgets/dashboard_app_bar.dart';
import 'package:dmpku/pages/member/dashboard/widgets/dashboard_header.dart';
import 'package:dmpku/pages/member/kasir/member_catatan_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_provider.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_provider_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_provider_page.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_provider.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_page_aktivasi_voucher.dart';
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
    MenuData(
      'Kasir',
      Assets.img.menuPenjualan.icKasir.provider(),
      onTap: () {},
    ),
    MenuData(
      'Catatan',
      Assets.img.menuPenjualan.icCatatan.provider(),
      onTap: () {
        pushNamed(MemberCatatanPage.routeName);
      },
    ),
    MenuData(
      'Kalkulator',
      Assets.img.menuPenjualan.icKalkulator.provider(),
      onTap: () {
        pushNamed(CalculatorPage.routeName);
      },
    ),
    MenuData(
      'Favorit',
      Assets.img.menuPenjualan.icFavorit.provider(),
      onTap: () {
        pushNamed(MemberDaftarFavoritPage.routeName);
      },
    ),
    MenuData(
      'Banner',
      Assets.img.menuPenjualan.icBanner.provider(),
      onTap: () {
        pushNamed(BannerPage.routeName);
      },
    ),
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
        getMemberPaketDataProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Paket SMS & Telepon",
      Assets.img.menuIsiUlang.iconPaketSmsTelepon.provider(),
      onTap: () {
        pushNamed(MemberPaketNelponProviderPage.routeName);
        getMemberPaketNelponProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Masa Aktif",
      Assets.img.menuIsiUlang.iconMasaAktif.provider(),
      onTap: () {
        pushNamed(MemberMasaAktifProviderPage.routeName);
        getMemberMasaAktifProvider(context).fetchProviders();
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
        getMemberWifiIdProvider(context).fetchProducts();
      },
    ),
  ];

  List<MenuData> get _ppobMenus => [
    MenuData(
      "Dompet Digital",
      Assets.img.menuPpob.iconDompetDigital.provider(),
      onTap: () {
        pushNamed(MemberDompetDigitalProviderPage.routeName);
        getMemberDompetDigitalProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "Uang Elektronik",
      Assets.img.menuPpob.iconUangElektronik.provider(),
      onTap: () {
        pushNamed(MemberUangElektronikProviderPage.routeName);
        getMemberUangElektronikProvider(context).fetchProviders();
      },
    ),
    MenuData(
      "PLN Tagihan",
      Assets.img.menuPpob.iconPlnTagihan.provider(),
      onTap: () {
        pushNamed(MemberPlnTagihanProviderPage.routeName);
        getMemberPlnTagihanProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "HP Pasca",
      Assets.img.menuPpob.iconHpPasca.provider(),
      onTap: () {
        pushNamed(MemberHpPascaProviderPage.routeName);
        getMemberHpPascaProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "Tagihan Gas",
      Assets.img.menuPpob.iconTagihanGas.provider(),
      onTap: () {
        pushNamed(MemberTagihanGasProviderPage.routeName);
        getMemberTagihanGasProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "PDAM",
      Assets.img.menuPpob.iconPdam.provider(),
      onTap: () {
        pushNamed(MemberPdamProviderPage.routeName);
        getMemberPdamProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "Internet & TV",
      Assets.img.menuPpob.iconInternetTv.provider(),
      onTap: () {
        pushNamed(MemberInternetTvProviderPage.routeName);
        getMemberInternetTvProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "BPJS Kesehatan",
      Assets.img.menuPpob.iconBpjsKesehatan.provider(),
      onTap: () {
        pushNamed(MemberBpjsKesehatanProviderPage.routeName);
        getMemberBpjsKesehatanProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "BPJS TKN",
      Assets.img.menuPpob.iconBpjsTkn.provider(),
      onTap: () {
        pushNamed(MemberBpjsTknProviderPage.routeName);
        getMemberBpjsTknProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "E-Commerce",
      Assets.img.menuPpob.iconEcommerce.provider(),
      onTap: () {
        pushNamed(MemberECommerceProviderPage.routeName);
        getMemberECommerceProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "E-SAMSAT",
      Assets.img.menuPpob.iconEsamsat.provider(),
      onTap: () {
        pushNamed(MemberESamsatProviderPage.routeName);
        getMemberESamsatProvider(context).fetchProducts();
      },
    ),
    MenuData(
      "PBB",
      Assets.img.menuPpob.iconPbb.provider(),
      onTap: () {
        pushNamed(MemberPbbProviderPage.routeName);
        getMemberPbbProvider(context).fetchProducts();
      },
    ),
  ];

  // ============================================================
  // Event Handlers
  // ============================================================

  void _handleMenuTap(String menuTitle) {}

  void _handlePaketCuanTap() {
    pushNamed(MemberPaketCuanProviderPage.routeName);
    getMemberPaketCuanProvider(context).fetchProviders();
  }

  void _handleNotificationTap() async {
    final link = await SecureStorageHelper.instance.getChannelWa();
    await launchUrlApp(link);
  }

  void _handleHelpTap(BuildContext context) async {
    // await openBantuanWa(context);

    getTransaksiProsesProvider(
      context,
    ).setImage(Assets.img.produk.icTokenPln.provider());
    getTransaksiProsesProvider(context).setProduct(
      DEFAULT_PRODUCT.copyWith(
        namaproduk: "Token PLN 20.000",
        hargaproduk: 20000,
        kodeproduk: "PLN20K",
      ),
    );
    getTransaksiProsesProvider(context).setPotongStok(20000);
    getTransaksiProsesProvider(context).setTujuanHistory([
      ProsesTrxBanyak(tujuan: "081234567890", success: true),
      ProsesTrxBanyak(tujuan: "089876543210", success: false),
      ProsesTrxBanyak(tujuan: "082112345678", success: true),
    ]);
    getTransaksiProsesProvider(context).setWaktuTransaksi("12 Mei 2024 14:30");
    pushNamed(TransaksiProsesAktivasiVoucherPage.routeName);
  }
}
