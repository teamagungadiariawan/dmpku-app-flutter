import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_produk_page.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/tab/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'member_dompet_digital_produk_nominal_bebas_page.dart';

class MemberDompetDigitalProviderPage extends StatefulWidget {
  static const String routeName = '/member/produk/ppob/dompet-digital/provider';

  const MemberDompetDigitalProviderPage({super.key});

  @override
  State<MemberDompetDigitalProviderPage> createState() =>
      _MemberDompetDigitalProviderPageState();
}

class _MemberDompetDigitalProviderPageState
    extends State<MemberDompetDigitalProviderPage>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late final CustomTabController _tabController;

  int _activeTab = 0;

  final _tabs = const [
    TabItem(key: 'nominalpilihan', title: 'Nominal Pilihan'),
    TabItem(key: 'nominalbebas', title: 'Nominal Sesuai Keinginan'),
  ];

  @override
  void initState() {
    super.initState();
    getMemberDompetDigitalProvider(context).fetchProviders();
    _pageViewController = PageController();
    _tabController = CustomTabController(length: _tabs.length);
  }

  void _handleTabChange(int index, {bool fromTabBar = false}) {
    setState(() {
      _activeTab = index;
    });

    if (fromTabBar) {
      _pageViewController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _tabController.animateTo(index);
    }
  }

  Future<void> _onRefresh() async {
    getMemberDompetDigitalProvider(context).fetchProviders();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void closePage() {
    pop();
  }

  List<ProviderModel> _filterProviders(
    List<ProviderModel> providers,
    String search,
  ) {
    return providers.where((provider) {
      var namaProvider = provider.namaprovider.replaceAll(
        RegExp(r'[^\w\s]'),
        '',
      );
      return namaProvider.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  List<ProductModel> _filterProduct(
    List<ProductModel> providers,
    String search,
  ) {
    return providers.where((provider) {
      var namaProvider = provider.namaproduk.replaceAll(RegExp(r'[^\w\s]'), '');
      return namaProvider.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Top Up Game",
            onBackButtonPressed: () {
              closePage();
            },
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildBanner(context),
                Gap(8),
                CustomTabBar(
                  activeIndex: _activeTab,
                  onChange: (index) =>
                      _handleTabChange(index, fromTabBar: true),
                  tabs: _tabs,
                  primaryColor: context.primary,
                ),
                Gap(8),
                _buildSearchField(context),
                Gap(10),
                Expanded(
                  child: PageView(
                    controller: _pageViewController,
                    onPageChanged: _handleTabChange,
                    children: <Widget>[
                      _buildListProviderDompetDigital(context),
                      _buildListProviderNominalBebas(context),
                    ],
                  ),
                ),
                Gap(8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      padding: paddingCard,
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(MdiIcons.wallet, color: Colors.white, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Topup Dompet Digital",
                  style: context.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Topup dompet digital dengan mudah dan aman",
                  style: context.bodySmall.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListProviderDompetDigital(BuildContext context) {
    return BlocBuilder<MemberDompetDigitalProvider, MemberDompetDigitalState>(
      buildWhen: (previous, current) =>
          previous.nominalPilihanProviders != current.nominalPilihanProviders ||
          previous.searchProvider != current.searchProvider ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        var providers = _filterProviders(
          state.nominalPilihanProviders,
          state.searchProvider,
        );
        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          itemBuilder: (context, provider, index) {
            return CardProvider(
              title: provider.namaprovider,
              subtitle: provider.deskripsiprovider,
              imageUrl: provider.imgprovider,
              onPressed: () {
                pushNamed(
                  MemberDompetDigitalProdukPage.routeName,
                  arguments: getMemberDompetDigitalProvider(context),
                );
                getMemberDompetDigitalProvider(
                  context,
                ).setSelectedProvider(provider);
              },
            );
          },
          emptyTitle: state.tujuan.isEmpty
              ? 'Masukkan nomor untuk melihat provider'
              : 'Provider tidak ditemukan',
        );
      },
    );
  }

  Widget _buildListProviderNominalBebas(BuildContext context) {
    return BlocBuilder<MemberDompetDigitalProvider, MemberDompetDigitalState>(
      buildWhen: (previous, current) =>
          previous.nominalBebsasProducts != current.nominalBebsasProducts ||
          previous.searchProvider != current.searchProvider ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        var providers = _filterProduct(
          state.nominalBebsasProducts,
          state.searchProvider,
        );
        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          itemBuilder: (context, provider, index) {
            return CardProvider(
              title: provider.namaproduk,
              subtitle: provider.deskripsiproduk,
              imageUrl: provider.imgproduk,
              onPressed: () {
                pushNamed(
                  MemberDompetDigitalProdukNominalBebasPage.routeName,
                  arguments: getMemberDompetDigitalProvider(context),
                );
                getMemberDompetDigitalProvider(
                  context,
                ).setSelectedProduct(provider, isNominalBebas: true);
              },
            );
          },
          emptyTitle: state.tujuan.isEmpty
              ? 'Masukkan nomor untuk melihat provider'
              : 'Provider tidak ditemukan',
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return BlocBuilder<MemberDompetDigitalProvider, MemberDompetDigitalState>(
      buildWhen: (previous, current) =>
          previous.searchProvider != current.searchProvider,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(color: context.border, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(LucideIcons.search, size: 18, color: context.foreground),
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: state.searchProviderController,
                  onChanged: (val) => getMemberDompetDigitalProvider(
                    context,
                  ).setSearchProvider(val),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Produk',
                    suffixIcon: state.searchProvider.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberDompetDigitalProvider(
                                context,
                              ).setSearchProvider('', updateController: true);
                            },
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: context.foreground,
                            ),
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
