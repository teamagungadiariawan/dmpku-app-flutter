import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MemberInfoKartuProviderPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/info-kartu/provider';

  const MemberInfoKartuProviderPage({super.key});

  @override
  State<MemberInfoKartuProviderPage> createState() =>
      _MemberInfoKartuProviderPageState();
}

class _MemberInfoKartuProviderPageState
    extends State<MemberInfoKartuProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getMemberInfoKartuProvider(context).fetchProducts();
  }

  void closePage() {
    pop();
  }

  List<ProductModel> _filterProviders(
    List<ProductModel> providers,
    String search,
  ) {
    var filteredProviders = providers;

    if (search.isNotEmpty) {
      filteredProviders = filteredProviders.where((provider) {
        var namaProvider = provider.namaproduk.replaceAll(
          RegExp(r'[^\w\s]'),
          '',
        );
        return namaProvider.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    return filteredProviders;
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
            title: "Pilih Provider Info Kartu",
            onBackButtonPressed: () {
              closePage();
            },
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildSearchField(context),
                Gap(10),
                Expanded(child: _buildListProvider(context)),
                Gap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<MemberInfoKartuProvider, MemberInfoKartuState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.searchProduct != current.searchProduct ||
          previous.apiFetchProductStatus != current.apiFetchProductStatus,
      builder: (context, state) {
        var providers = _filterProviders(state.products, state.searchProduct);
        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchProductStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          itemBuilder: (context, provider, index) {
            return CardProvider(
              title: provider.namaproduk,
              subtitle: provider.deskripsiproduk,
              imageUrl: provider.imgproduk,
              onPressed: () {
                pushNamed(
                  MemberInfoKartuProdukPage.routeName,
                  arguments: getMemberInfoKartuProvider(context),
                );
                getMemberInfoKartuProvider(
                  context,
                ).setSelectedProduct(provider);
              },
            );
          },
          emptyTitle: 'Provider tidak ditemukan',
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return BlocBuilder<MemberInfoKartuProvider, MemberInfoKartuState>(
      buildWhen: (previous, current) =>
          previous.searchProduct != current.searchProduct,
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
                  controller: state.searchProductController,
                  onChanged: getMemberInfoKartuProvider(
                    context,
                  ).setSearchProduct,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Provider',
                    suffixIcon: state.searchProduct.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberInfoKartuProvider(
                                context,
                              ).setSearchProduct('', updateController: true);
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
