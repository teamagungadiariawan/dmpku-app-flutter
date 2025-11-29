import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/produk/card_product.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa.dart';
import 'package:dmpku/widgets/produk/custom_popup_sort_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
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
        onPopInvoked: (didPop) async {
          closePage();
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: getPulsaProvider(
              context,
            ).state.selectedProvider.namaprovider,
            onBackButtonPressed: () {
              closePage();
            },
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
                const Gap(5),
                _buildPhoneInputField(context, state),

                if (state.hasErrorInputTujuan) ...[
                  const Gap(5),
                  Text(
                    state.errorMessageInputTujuan,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],

                const Gap(5),
                ButtonFavorit(isGuest: true, onResult: (val) {}),
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
        return Row(
          children: [
            Expanded(
              child: Container(
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
                    Icon(
                      LucideIcons.search,
                      size: 18,
                      color: context.foreground,
                    ),
                    Gap(6),
                    Expanded(
                      child: TextField(
                        controller: state.searchProductController,
                        onChanged: (val) {
                          getPulsaProvider(context).setSearchProduct(val);
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Cari Produk',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (state.searchProduct.isNotEmpty) ...[
                                  InkWell(
                                    onTap: () {
                                      getPulsaProvider(
                                        context,
                                      ).setSearchProduct(
                                        '',
                                        updateTextController: true,
                                      );
                                    },
                                    child: Icon(
                                      MdiIcons.close,
                                      size: 18,
                                      color: context.foreground,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(6),
            CustomPopupSortProduct(
              selectedSort: state.sortProduct,
              onSelected: (sortBy) {
                getPulsaProvider(context).setSortProduct(sortBy);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildListProduk(BuildContext context) {
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        if (state.apiFetchPulsaProductStatus.isLoading) {
          return Center(
            child: CupertinoActivityIndicator(color: context.primary),
          );
        }

        var products = _filterProducts(
          state.pulsaProduct,
          state.searchProduct,
          state.sortProduct,
        );

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
