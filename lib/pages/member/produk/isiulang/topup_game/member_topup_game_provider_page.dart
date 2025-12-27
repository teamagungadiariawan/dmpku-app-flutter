import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/grid_provider.dart';
import 'package:dmpku/widgets/produk/grid_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_grid.dart';
import 'package:dmpku/widgets/tab/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MemberTopupGameProviderPage extends StatefulWidget {
  static const String routeName = '/member/produk/isiulang/topup-game/provider';

  const MemberTopupGameProviderPage({super.key});

  @override
  State<MemberTopupGameProviderPage> createState() =>
      _MemberTopupGameProviderPageState();
}

class _MemberTopupGameProviderPageState
    extends State<MemberTopupGameProviderPage>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late final CustomTabController _tabController;

  int _activeTab = 0;

  final _tabs = const [
    TabItem(key: 'topupgame', title: 'Top Up Game'),
    TabItem(key: 'vouchergame', title: 'Voucher Game'),
  ];

  @override
  void initState() {
    super.initState();
    getMemberTopupGameProvider(context).fetchProviders();
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
    getMemberTopupGameProvider(context).fetchProviders();
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
                      _buildListProviderTopupGame(context),
                      _buildListProviderVoucherGame(context),
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
    var title = ['Top Up Game Langsung', 'Beli Voucher Game'];

    var subTitle = [
      'Pembelian Diamond langsung masuk ke akun game kamu.',
      'Beli voucher dan Gift Card untuk berbagai game populer.',
    ];

    var icon = [MdiIcons.controllerClassic, Icons.card_giftcard];

    return Container(
      padding: paddingCard,
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon[_activeTab], color: Colors.white, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title[_activeTab],
                  style: context.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle[_activeTab],
                  style: context.bodySmall.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListProviderTopupGame(BuildContext context) {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (previous, current) =>
          previous.topupGameProviders != current.topupGameProviders ||
          previous.searchProvider != current.searchProvider ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        var providers = _filterProviders(
          state.topupGameProviders,
          state.searchProvider,
        );
        return RefreshableGrid(
          loadingWidget: GridProviderVerticalGridShimmer(
            itemCount: 12,
            crossAxisCount: 4,
            aspectRatio: 0.8,
            mainAxisSpacing: 5,
          ),
          isLoading: state.apiFetchProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          childAspectRatio: 0.8,
          itemBuilder: (context, provider, index) {
            return GridProvider(
              title: provider.namaprovider,
              imageUrl: provider.imgprovider,
              onPressed: () {
                getMemberTopupGameProvider(
                  context,
                ).setSelectedProvider(provider);
                pushNamed(
                  MemberTopupGameProdukPage.routeName,
                  arguments: getMemberTopupGameProvider(context),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildListProviderVoucherGame(BuildContext context) {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (previous, current) =>
          previous.voucherGameProviders != current.voucherGameProviders ||
          previous.searchProvider != current.searchProvider ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        var providers = _filterProviders(
          state.voucherGameProviders,
          state.searchProvider,
        );
        return RefreshableGrid(
          loadingWidget: GridProviderVerticalGridShimmer(
            itemCount: 12,
            crossAxisCount: 4,
            aspectRatio: 0.8,
            mainAxisSpacing: 5,
          ),
          isLoading: state.apiFetchProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          childAspectRatio: 0.8,
          itemBuilder: (context, provider, index) {
            return GridProvider(
              title: provider.namaprovider,
              imageUrl: provider.imgprovider,
              onPressed: () {
                getMemberTopupGameProvider(context).setSelectedProvider(
                  provider,
                  titleForm: 'No. Tujuan',
                  hintForm: 'Contoh : 081XXXXXXXXX',
                );
                pushNamed(
                  MemberTopupGameProdukPage.routeName,
                  arguments: getMemberTopupGameProvider(context),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
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
                  onChanged: (val) => getMemberTopupGameProvider(
                    context,
                  ).setSearchProvider(val),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Produk',
                    suffixIcon: state.searchProvider.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberTopupGameProvider(
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
