import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_produk.dart';

import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa_shimmer.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberVoucherDataProdukPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/voucher-data/produk';

  const MemberVoucherDataProdukPage({super.key});

  @override
  State<MemberVoucherDataProdukPage> createState() =>
      _MemberVoucherDataProdukPageState();
}

class _MemberVoucherDataProdukPageState
    extends State<MemberVoucherDataProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getMemberVoucherDataProvider(context).resetProduct();
    pop();
  }

  Future<void> _onRefresh() async {
    getMemberVoucherDataProvider(context).fetchProviders();
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
      child: WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: getMemberVoucherDataProvider(
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
                _buildDetailProvider(context),
                Expanded(child: _buildListProduk(context)),
              ],
            ),
          ),
          bottomNavigationBar: BlocProvider.value(
            value: getMemberVoucherDataProvider(context),
            child:
                BlocBuilder<MemberVoucherDataProvider, MemberVoucherDataState>(
                  buildWhen: (previous, current) =>
                      previous.selectedProduct != current.selectedProduct ||
                      previous.tujuanHasError != current.tujuanHasError ||
                      previous.tujuan != current.tujuan ||
                      previous.apiFetchProductStatus !=
                          current.apiFetchProductStatus,
                  builder: (context, state) {
                    final bottomInset = MediaQuery.of(
                      context,
                    ).viewInsets.bottom;

                    return Padding(
                      padding: EdgeInsets.only(bottom: bottomInset),
                      child: ButtonCheckout(
                        isDisabled:
                            state.selectedProduct.idproduk == 0 ||
                            state.tujuanHasError ||
                            state.tujuan.isEmpty ||
                            state.apiFetchProductStatus.isLoading,
                        selectedProduct: state.selectedProduct,
                        onContinue: () {
                          getMemberVoucherDataProvider(
                            context,
                          ).setNewKonfirmasi();
                        },
                      ),
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<MemberVoucherDataProvider, MemberVoucherDataState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuan(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: true,
          hintText: 'Contoh : 081XXXXXXXXX',
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getMemberVoucherDataProvider(context).setTujuan(value);
          },
          onClear: () {
            getMemberVoucherDataProvider(
              context,
            ).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: false,
          tipeProduk: TipeProduk.voucherData,

          onFavoritResult: (val) {
            getMemberVoucherDataProvider(
              context,
            ).setTujuan(val, updateController: true);
          },
          suffixWidget: CustomPopupInputTujuan(
            isContact: true,
            isVoice: true,
            isTempel: true,
            onResult: (val) {
              getMemberVoucherDataProvider(
                context,
              ).setTujuan(val, updateController: true);
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<MemberVoucherDataProvider, MemberVoucherDataState>(
      buildWhen: (previous, current) =>
          previous.selectedProvider != current.selectedProvider,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProvider(
              imageUrl: state.selectedProvider.imgprovider,
              title: state.selectedProvider.namaprovider,
              subtitle: state.selectedProvider.deskripsiprovider,
              isGanti: false,
              onPressed: () {
                closePage();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSortFilterProduct(BuildContext context) {
    return BlocBuilder<MemberVoucherDataProvider, MemberVoucherDataState>(
      buildWhen: (previous, current) =>
          previous.searchProduct != current.searchProduct ||
          previous.sortProduct != current.sortProduct,
      builder: (context, state) {
        return SortFilterProduct(
          searchController: state.searchProductController!,
          searchValue: state.searchProduct,
          hasError: state.tujuanHasError,
          selectedSort: state.sortProduct,
          onSearchChanged: (val) {
            getMemberVoucherDataProvider(context).setSearchProduct(val);
          },
          onClearSearch: () {
            getMemberVoucherDataProvider(
              context,
            ).setSearchProduct('', updateController: true);
          },
          onSortSelected: (sortBy) {
            getMemberVoucherDataProvider(context).setSortProduct(sortBy);
          },
        );
      },
    );
  }

  Widget _buildListProduk(BuildContext context) {
    return BlocBuilder<MemberVoucherDataProvider, MemberVoucherDataState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.searchProduct != current.searchProduct ||
          previous.sortProduct != current.sortProduct ||
          previous.selectedProduct != current.selectedProduct ||
          previous.apiFetchProductStatus != current.apiFetchProductStatus,
      builder: (context, state) {
        var products = _filterProducts(
          state.products,
          state.searchProduct,
          state.sortProduct,
        );

        return RefreshableList(
          loadingWidget: CardProductPulsaListShimmer(itemCount: 6),
          isLoading: state.apiFetchProductStatus.isLoading,
          onRefresh: _onRefresh,
          items: products,
          itemBuilder: (context, provider, index) {
            final product = products[index];
            return CardProductPulsa(
              title: product.namaproduk,
              subtitle: product.deskripsiproduk,
              harga: product.hargaproduk.toString(),
              selected: state.selectedProduct.idproduk == product.idproduk,
              isGangguan: product.isGangguan,
              isPulsa: true,
              onPress: () {
                getMemberVoucherDataProvider(
                  context,
                ).setSelectedProduct(product);
              },
            );
          },
          emptyTitle: 'Produk tidak ditemukan',
        );
      },
    );
  }
}
