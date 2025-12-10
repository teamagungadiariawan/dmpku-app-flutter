import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/topup_game_provider.dart';import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/card_product.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa_shimmer.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestTopupGameProdukPage extends StatefulWidget {
  static const String routeName = '/guest/produk/isiulang/topup-game/produk';

  const GuestTopupGameProdukPage({super.key});

  @override
  State<GuestTopupGameProdukPage> createState() =>
      _GuestTopupGameProdukPageState();
}

class _GuestTopupGameProdukPageState extends State<GuestTopupGameProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getTopupGameProvider(context).resetProduct();
    pop();
  }

  Future<void> _onRefresh() async {
    getTopupGameProvider(context).fetchProducts();
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
            title: getTopupGameProvider(
              context,
            ).state.selectedProvider.namaprovider,
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildIdAkunCard(context),
                _buildSortFilterProduct(context),
                _buildDetailProvider(context),
                Expanded(child: _buildListProduk(context)),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<TopupGameProvider, TopupGameState>(
            buildWhen: (previous, current) =>
                previous.selectedProduct != current.selectedProduct ||
                previous.tujuanHasError != current.tujuanHasError ||
                previous.tujuan != current.tujuan ||
                previous.apiFetchProductStatus != current.apiFetchProductStatus,
            builder: (context, state) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;

              return Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: ButtonCheckout(
                  isDisabled:
                  state.selectedProduct.idproduk == 0 ||
                      state.tujuanHasError ||
                      state.tujuan.isEmpty ||
                      state.apiFetchProductStatus.isLoading,
                  selectedProduct: state.selectedProduct,
                  onContinue: () => BelumLoginDialog.show(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIdAkunCard(BuildContext context) {
    return BlocBuilder<TopupGameProvider, TopupGameState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError ||
          previous.titleForm != current.titleForm ||
          previous.hintForm != current.hintForm ||
          previous.isCekAkun != current.isCekAkun ||
          previous.selectedProvider != current.selectedProvider,
      builder: (context, state) {
        return CardInputTujuan(
          tujuan: state.tujuan,
          label: state.titleForm,
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: true,
          hintText: state.hintForm,
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getTopupGameProvider(context).setTujuan(value);
          },
          onClear: () {
            getTopupGameProvider(
              context,
            ).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: true,
          isCekAkun: state.isCekAkun,
          tipeInput: state.selectedProvider.inputTipe,
          suffixWidget: CustomPopupInputTujuan(
            onResult: (val) {
              getTopupGameProvider(
                context,
              ).setTujuan(val, updateController: true);
            },
          ),
          onFavoritResult: (val) {},
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<TopupGameProvider, TopupGameState>(
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
    return BlocBuilder<TopupGameProvider, TopupGameState>(
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
            getTopupGameProvider(context).setSearchProduct(val);
          },
          onClearSearch: () {
            getTopupGameProvider(
              context,
            ).setSearchProduct('', updateController: true);
          },
          onSortSelected: (sortBy) {
            getTopupGameProvider(context).setSortProduct(sortBy);
          },
        );
      },
    );
  }

  Widget _buildListProduk(BuildContext context) {
    return BlocBuilder<TopupGameProvider, TopupGameState>(
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
            return CardProduct(
              title: product.namaproduk,
              subtitle: product.deskripsiproduk,
              harga: product.hargaproduk.toString(),
              selected: state.selectedProduct.idproduk == product.idproduk,
              isGangguan: product.isGangguan,
              onPress: () {
                getTopupGameProvider(context).setSelectedProduct(product);
              },
            );
          },
          emptyTitle: 'Produk tidak ditemukan',
        );
      },
    );
  }
}
