import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/promo_response.dart';
import 'package:dmpku/pages/member/produk/promo/member_promo_provider.dart';
import 'package:dmpku/pages/member/produk/promo/widgets/promo_header.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dmpku/pages/member/produk/promo/member_promo_checkout_page.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';

class MemberPromoPage extends StatefulWidget {
  static const routeName = '/member/produk/promo';

  const MemberPromoPage({super.key});

  @override
  State<MemberPromoPage> createState() => _MemberPromoPageState();
}

class _MemberPromoPageState extends State<MemberPromoPage> {
  late PageController _pageViewController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();

    // Fetch promo products when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MemberPromoProvider>().fetchPromoProducts();
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    _pageViewController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Promo',
          showBackButton: false,
          backgroundColor: context.primary,
        ),
        backgroundColor: context.secondary,
        body: BlocBuilder<MemberPromoProvider, MemberPromoState>(
          builder: (context, state) {
            return Column(
              children: [
                PromoHeader(
                  promoCategories: state.promoCategories,
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: _onTabChanged,
                  isLoading: state.apiFetchPromoStatus.isLoading,
                ),
                Expanded(child: _buildContent(context, state)),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<MemberPromoProvider, MemberPromoState>(
          builder: (context, state) {
            final selectedProduct = ProductModel(
              idproduk: state.selectedProduct.idproduk,
              idprovider: state.selectedProduct.idprovider,
              tipeproduk: state.selectedProduct.tipeproduk,
              kodeproduk: state.selectedProduct.kodeproduk,
              namaproduk: state.selectedProduct.namaproduk,
              deskripsiproduk: state.selectedProduct.deskripsiproduk,
              nominalproduk: state.selectedProduct.nominalproduk,
              hargaproduk: state.selectedProduct.hargaproduk,
              maxproduk: 0,
              imgproduk: state.selectedProduct.imgproduk,
              urutanproduk: state.selectedProduct.urutanproduk,
              statusproduk: state.selectedProduct.statusproduk,
              kodeprodukcek: state.selectedProduct.kodeprodukcek,
              minnominalbebas: 0,
              maxnominalbebas: 0,
              tipeinput: state.selectedProduct.tipeinput,
              mintujuan: state.selectedProduct.mintujuan,
              maxtujuan: state.selectedProduct.maxtujuan,
            );

            return ButtonCheckout(
              selectedProduct: selectedProduct,
              isDisabled:
                  state.selectedProduct.idproduk == 0 ||
                  state.apiFetchPromoStatus.isLoading,
              onContinue: () {
                Navigator.pushNamed(
                  context,
                  MemberPromoCheckoutPage.routeName,
                  arguments: context.read<MemberPromoProvider>(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, MemberPromoState state) {
    return Column(
      children: [
        _buildPromoBanner(context),
        // _buildInputTujuan(context), // Removed input field
        Expanded(
          child: Container(
            color: context.secondary,
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<MemberPromoProvider>().fetchPromoProducts();
              },
              child: state.promoCategories.isEmpty
                  ? _buildEmptyState(context)
                  : PageView.builder(
                      controller: _pageViewController,
                      itemCount: state.promoCategories.length,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                        final category = state.promoCategories[index];
                        context.read<MemberPromoProvider>().setSelectedCategory(
                          category,
                        );
                        if (category.data.isNotEmpty) {
                          context
                              .read<MemberPromoProvider>()
                              .setSelectedProvider(category.data.first);
                        }
                      },
                      itemBuilder: (context, index) {
                        final category = state.promoCategories[index];
                        return _buildCategoryContent(context, category);
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.primary, context.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to promo details or show promo list
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.campaign_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROMO MENARIK',
                        style: context.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Diskon spesial hari ini hanya untukmu!',
                        style: context.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_offer_outlined,
                size: 64,
                color: context.mutedForeground,
              ),
              const SizedBox(height: 16),
              Text(
                'Tidak ada promo tersedia',
                style: context.bodyMedium.copyWith(
                  color: context.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryContent(
    BuildContext context,
    PromoProdukModel category,
  ) {
    return Column(
      children: [
        _buildProviderTabs(context, category),
        Expanded(child: _buildListProduk(context, category)),
      ],
    );
  }

  Widget _buildListProduk(BuildContext context, PromoProdukModel category) {
    return BlocBuilder<MemberPromoProvider, MemberPromoState>(
      builder: (context, state) {
        final products = state.selectedProvider.data;

        return RefreshableList(
          padding: EdgeInsets.symmetric(horizontal: paddinPageh),
          loadingWidget: const CardProductPulsaListShimmer(itemCount: 6),
          isLoading: state.apiFetchPromoStatus.isLoading,
          onRefresh: () async {
            await context.read<MemberPromoProvider>().fetchPromoProducts();
          },
          items: products,
          itemBuilder: (context, product, index) {
            return CardProductPulsa(
              title: product.namaproduk,
              subtitle: product.deskripsiproduk,
              harga: product.hargaproduk.toString(),
              selected: state.selectedProduct.idproduk == product.idproduk,
              isGangguan: product.statusproduk == 0,
              isPulsa: true,
              onPress: () {
                context.read<MemberPromoProvider>().setSelectedProduct(product);
              },
            );
          },
          emptyTitle: 'Produk tidak ditemukan',
          emptySubtitle: 'Silakan pilih provider lain atau refresh halaman',
        );
      },
    );
  }

  Widget _buildProviderTabs(BuildContext context, PromoProdukModel category) {
    if (category.data.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: context.secondary,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: category.data.map((provider) {
            final isSelected =
                context
                    .read<MemberPromoProvider>()
                    .state
                    .selectedProvider
                    .idprovider ==
                provider.idprovider;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  context.read<MemberPromoProvider>().setSelectedProvider(
                    provider,
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? context.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? context.primary
                          : context.mutedSmall.color ?? Colors.grey,
                    ),
                  ),
                  child: Text(
                    provider.namaprovider,
                    style: context.labelMedium.copyWith(
                      color: isSelected ? Colors.white : context.foreground,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
