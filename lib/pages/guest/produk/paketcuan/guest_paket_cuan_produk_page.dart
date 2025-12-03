import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/product_cuan_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/widgets/card_input_tujuan_pulsa.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/card_product.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class GuestPaketCuanProdukPage extends StatefulWidget {
  static const routeName = '/guest/paketcuan/produk';

  const GuestPaketCuanProdukPage({super.key});

  @override
  State<GuestPaketCuanProdukPage> createState() =>
      _GuestPaketCuanProdukPageState();
}

class _GuestPaketCuanProdukPageState extends State<GuestPaketCuanProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    getPaketCuanProvider(context).resetProductState();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getPaketCuanProvider(context).fetchProducts();
  }

  void closePage() {
    getPaketCuanProvider(context).resetProductState();
    pop();
  }

  List<ProductCuanModel> _filterProducts(
    List<ProductCuanModel> product,
    String search,
    SortProductBy sortBy,
  ) {
    List<ProductCuanModel> filteredProducts = product;
    if (search.isNotEmpty) {
      filteredProducts = filteredProducts.where((prod) {
        // remove tanda baca dan spasi dari pencarian

        var namaproduk = prod.namapaket.replaceAll(RegExp(r'[^\w\s]'), '');
        var deskripsiproduk = prod.detailpaket.replaceAll(
          RegExp(r'[^\w\s]'),
          '',
        );

        return namaproduk.toLowerCase().contains(search.toLowerCase()) ||
            deskripsiproduk.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    filteredProducts = sortProductCuan(filteredProducts, sortBy);

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
            title: getPaketCuanProvider(
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
                _buildDetailProvider(context),
                Expanded(child: _buildListProvider(context)),
                const Gap(5),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<PaketCuanProvider, PaketCuanState>(
            buildWhen: (previous, current) =>
                previous.selectedProduct != current.selectedProduct ||
                previous.tujuanHasError != current.tujuanHasError ||
                previous.tujuan != current.tujuan ||
                previous.apiFetchProductStatus != current.apiFetchProductStatus,
            builder: (context, state) {
              var prod = DEFAULT_PRODUCT.copyWith(
                idproduk: state.selectedProduct.kodepaket != '' ? 1 : 0,
                namaproduk: state.selectedProduct.namapaket,
                hargaproduk: state.selectedProduct.hargapaket,
              );

              return ButtonCheckout(
                isDisabled:
                    prod.idproduk == 0 ||
                    state.tujuanHasError ||
                    state.tujuan.isEmpty ||
                    state.apiFetchProductStatus.isLoading,
                selectedProduct: prod,
                onContinue: () => BelumLoginDialog.show(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<PaketCuanProvider, PaketCuanState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuanPulsa(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: false,
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getPaketCuanProvider(context).setTujuan(value);
          },
          onClear: () {
            getPaketCuanProvider(context).setTujuan('', updateController: true);
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
    return BlocBuilder<PaketCuanProvider, PaketCuanState>(
      buildWhen: (previous, current) =>
          previous.selectedSubProvider != current.selectedSubProvider,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProvider(
              imageUrl: state.selectedSubProvider.imgproduk,
              title: state.selectedSubProvider.namaproduk,
              subtitle: state.selectedSubProvider.deskripsiproduk,
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
    return BlocBuilder<PaketCuanProvider, PaketCuanState>(
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
            getPaketCuanProvider(context).setSearchProduct(val);
          },
          onClearSearch: () {
            getPaketCuanProvider(
              context,
            ).setSearchProduct('', updateController: true);
          },
          onSortSelected: (sortBy) {
            getPaketCuanProvider(context).setSortProduct(sortBy);
          },
        );
      },
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<PaketCuanProvider, PaketCuanState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.tujuan != current.tujuan ||
          previous.apiFetchProductStatus != current.apiFetchProductStatus,
      builder: (context, state) {
        var product = _filterProducts(
          state.products,
          state.searchProduct,
          state.sortProduct,
        );

        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchProductStatus.isLoading,
          onRefresh: _onRefresh,
          items: product,
          itemBuilder: (context, product, index) {
            return CardProduct(
              title: product.namapaket,
              subtitle: product.detailpaket,
              onPress: () {
                getPaketCuanProvider(context).setSelectedProduct(product);
              },
              harga: product.hargapaket.toString(),
              selected: state.selectedProduct.kodepaket == product.kodepaket,
              isGangguan: false,
            );
          },
          emptyTitle: state.tujuan.isEmpty
              ? 'Masukkan nomor untuk melihat provider'
              : 'Provider tidak ditemukan',
        );
      },
    );
  }
}
