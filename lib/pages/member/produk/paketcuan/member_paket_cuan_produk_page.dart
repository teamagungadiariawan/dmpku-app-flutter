import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/product_cuan_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_konfirmasi_transaksi_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/card_product.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MemberPaketCuanProdukPage extends StatefulWidget {
  static const routeName = '/member/paketcuan/produk';

  const MemberPaketCuanProdukPage({super.key});

  @override
  State<MemberPaketCuanProdukPage> createState() =>
      _MemberPaketCuanProdukPageState();
}

class _MemberPaketCuanProdukPageState extends State<MemberPaketCuanProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getMemberPaketCuanProvider(context).fetchProducts();
  }

  void closePage() {
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
            title: getMemberPaketCuanProvider(
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
          bottomNavigationBar:
              BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
                buildWhen: (previous, current) =>
                    previous.selectedProduct != current.selectedProduct ||
                    previous.tujuanHasError != current.tujuanHasError ||
                    previous.tujuan != current.tujuan ||
                    previous.apiFetchProductStatus !=
                        current.apiFetchProductStatus,
                builder: (context, state) {
                  var prod = DEFAULT_PRODUCT.copyWith(
                    idproduk: state.selectedProduct.kodepaket != '' ? 1 : 0,
                    namaproduk: state.selectedProduct.namapaket,
                    hargaproduk: state.selectedProduct.hargapaket,
                  );

                  final bottomInset = MediaQuery.of(context).viewInsets.bottom;

                  return Padding(
                    padding: EdgeInsets.only(bottom: bottomInset),
                    child: ButtonCheckout(
                      isDisabled:
                          prod.idproduk == 0 ||
                          state.tujuanHasError ||
                          state.tujuan.isEmpty ||
                          state.apiFetchProductStatus.isLoading,
                      selectedProduct: prod,
                      onContinue: () => pushNamed(
                        MemberPaketCuanKonfirmasiTransaksiPage.routeName,
                        arguments: getMemberPaketCuanProvider(context),
                      ),
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuan(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: false,
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getMemberPaketCuanProvider(context).setTujuan(value);
          },
          onClear: () {
            getMemberPaketCuanProvider(
              context,
            ).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: false,

          onFavoritResult: (val) {},
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
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
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
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
            getMemberPaketCuanProvider(context).setSearchProduct(val);
          },
          onClearSearch: () {
            getMemberPaketCuanProvider(
              context,
            ).setSearchProduct('', updateController: true);
          },
          onSortSelected: (sortBy) {
            getMemberPaketCuanProvider(context).setSortProduct(sortBy);
          },
        );
      },
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
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
                getMemberPaketCuanProvider(context).setSelectedProduct(product);
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
