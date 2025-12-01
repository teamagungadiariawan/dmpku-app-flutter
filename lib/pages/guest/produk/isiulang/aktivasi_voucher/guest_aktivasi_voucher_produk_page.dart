import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/paket_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/widgets/card_input_tujuan_pulsa.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa_shimmer.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestAktivasiVoucherProdukPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/aktivasi-voucher/produk';

  const GuestAktivasiVoucherProdukPage({super.key});

  @override
  State<GuestAktivasiVoucherProdukPage> createState() =>
      _GuestAktivasiVoucherProdukPageState();
}

class _GuestAktivasiVoucherProdukPageState extends State<GuestAktivasiVoucherProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getAktivasiVoucherProvider(context).resetProduk();
    pop();
  }

  Future<void> _onRefresh() async {
    getAktivasiVoucherProvider(context).fetchAktivasiVoucherProviders();
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
      child:  WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: getAktivasiVoucherProvider(
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
          bottomNavigationBar: BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
            builder: (context, state) {
              return ButtonCheckout(
                isDisabled:
                    state.selectedProduct.idproduk == 0 ||
                    state.hasErrorInputTujuan ||
                    state.tujuan.isEmpty ||
                    state.apiFetchAktivasiVoucherProductStatus.isLoading,
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
    return BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
      builder: (context, state) {
        return CardInputTujuanPulsa(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.hasErrorInputTujuan,
          errorMessage: state.errorMessageInputTujuan,
          isEditable: false,
          hintText: 'Masukkan No. Tujuan',
          controller: state.inputTujuanController,
          focusNode: state.inputTujuanFocusNode,
          onChanged: (value) {
            getAktivasiVoucherProvider(context).setTujuan(value);
          },
          onClear: () {
            getAktivasiVoucherProvider(
              context,
            ).setTujuan('', updateTextController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: true,

          onFavoritResult: (val) {},
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
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
    return BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
      builder: (context, state) {
        return SortFilterProduct(
          searchController: state.searchProductController!,
          searchValue: state.searchProduct,
          hasError: state.hasErrorInputTujuan,
          selectedSort: state.sortProduct,
          onSearchChanged: (val) {
            getAktivasiVoucherProvider(context).setSearchProduct(val);
          },
          onClearSearch: () {
            getAktivasiVoucherProvider(
              context,
            ).setSearchProduct('', updateTextController: true);
          },
          onSortSelected: (sortBy) {
            getAktivasiVoucherProvider(context).setSortProduct(sortBy);
          },
        );
      },
    );
  }

  Widget _buildListProduk(BuildContext context) {
    return BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
      builder: (context, state) {
        var products = _filterProducts(
          state.aktivasiVoucherProduct,
          state.searchProduct,
          state.sortProduct,
        );

        return RefreshableList(
          loadingWidget: CardProductPulsaListShimmer(itemCount: 6),
          isLoading: state.apiFetchAktivasiVoucherProductStatus.isLoading,
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
                getAktivasiVoucherProvider(context).setSelectedProduct(product);
              },
            );
          },
          emptyTitle: 'Produk tidak ditemukan',
        );
      },
    );
  }
}
