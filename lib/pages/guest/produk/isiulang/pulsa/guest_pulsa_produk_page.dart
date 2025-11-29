import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/produk/card_product.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa_shimmer.dart';
import 'package:dmpku/widgets/produk/custom_popup_sort_product.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class GuestPulsaProdukPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/pulsa/produk';

  const GuestPulsaProdukPage({super.key});

  @override
  State<GuestPulsaProdukPage> createState() => _GuestPulsaProdukPageState();
}

class _GuestPulsaProdukPageState extends State<GuestPulsaProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getPulsaProvider(context).resetProduk();
    pop();
  }

  Future<void> _onRefresh() async {
    getPulsaProvider(context).fetchPulsaProviders();
  }

  List<ProductModel> _filterProducts(
    List<ProductModel> product,
    String search,
    SortProductBy sortBy,
  ) {
    List<ProductModel> filteredProducts = product;
    if (search.isNotEmpty) {
      filteredProducts = filteredProducts.where((prod) {
        // remove tanda baca dan spasi dari pencarian

        var namaproduk = prod.namaproduk.replaceAll(RegExp(r'[^\w\s]'), '');
        var deskripsiproduk = prod.deskripsiproduk.replaceAll(
          RegExp(r'[^\w\s]'),
          '',
        );

        return namaproduk.toLowerCase().contains(search.toLowerCase()) ||
            deskripsiproduk.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    filteredProducts = sortProducts(filteredProducts, sortBy);

    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) => closePage(),
        child: Scaffold(
          appBar: CustomAppBar(
            title: getPulsaProvider(
              context,
            ).state.selectedProvider.namaprovider,
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildPhoneNumberCard(context),
                _buildSortFilterProduct(context),
                Expanded(child: _buildListProduk(context)),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<PulsaProvider, PulsaState>(
            builder: (context, state) {
              return ButtonCheckout(
                isDisabled:
                    state.selectedProduct.idproduk == 0 ||
                    state.hasErrorInputTujuan ||
                    state.tujuan.isEmpty ||
                    state.apiFetchPulsaProductStatus.isLoading,
                selectedProduct: state.selectedProduct,
                onContinue: () => BelumLoginDialog.show(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No. Tujuan",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                _buildPhoneInputField(context, state),

                if (state.hasErrorInputTujuan) ...[
                  const Gap(8),
                  Text(
                    state.errorMessageInputTujuan,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],

                const Gap(8),
                ButtonFavorit(isGuest: true, onResult: (val) {}),
                Gap(5)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneInputField(BuildContext context, PulsaState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: state.hasErrorInputTujuan
              ? context.destructive
              : context.border,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(MdiIcons.clipboardAccount, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(child: Text(state.tujuan, style: TextStyle(fontSize: 16))),
        ],
      ),
    ).withErrorShake(
      key: shakeKey,
      hasError: state.hasErrorInputTujuan,
      onShakeComplete: () {},
    );
  }

  Widget _buildSortFilterProduct(BuildContext context) {
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        return SortFilterProduct(
          searchController: state.searchProductController!,
          searchValue: state.searchProduct,
          hasError: state.hasErrorInputTujuan,
          selectedSort: state.sortProduct,
          onSearchChanged: (val) {
            getPulsaProvider(context).setSearchProduct(val);
          },
          onClearSearch: () {
            getPulsaProvider(
              context,
            ).setSearchProduct('', updateTextController: true);
          },
          onSortSelected: (sortBy) {
            getPulsaProvider(context).setSortProduct(sortBy);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, PulsaState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(Assets.animations.noData, width: 200, fit: BoxFit.cover),
          Text(
            'Product tidak ditemukan',
            style: context.bodyMedium
                .copyWith(color: context.mutedForeground)
                .withWeight(FontWeight.bold),
          ),
          Text(
            'Tarik ke bawah untuk refresh',
            style: context.bodySmall.copyWith(color: context.mutedForeground),
          ),
        ],
      ),
    );
  }

  Widget _buildListProduk(BuildContext context) {
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        if (state.apiFetchPulsaProductStatus.isLoading) {
          return CardProductPulsaListShimmer(itemCount: 6);
        }

        var products = _filterProducts(
          state.pulsaProduct,
          state.searchProduct,
          state.sortProduct,
        );

        if (products.isEmpty && !state.apiFetchPulsaProductStatus.isLoading) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: context.primary,
            backgroundColor: context.card,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: _buildEmptyState(context, state),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _onRefresh,
          color: context.primary,
          backgroundColor: context.card,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return CardProductPulsa(
                title: product.namaproduk,
                subtitle: product.deskripsiproduk,
                harga: product.hargaproduk.toString(),
                selected: state.selectedProduct.idproduk == product.idproduk,
                isGangguan: product.isGangguan,
                isPulsa: true,
                onPress: () {
                  getPulsaProvider(context).setSelectedProduct(product);
                },
              );
            },
          ),
        );
      },
    );
  }
}
