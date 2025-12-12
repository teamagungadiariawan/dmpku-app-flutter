import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/produk/button_cek_akun.dart';
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
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MemberTopupGameProdukPage extends StatefulWidget {
  static const String routeName = '/member/produk/isiulang/topup-game/produk';

  const MemberTopupGameProdukPage({super.key});

  @override
  State<MemberTopupGameProdukPage> createState() =>
      _MemberTopupGameProdukPageState();
}

class _MemberTopupGameProdukPageState extends State<MemberTopupGameProdukPage> {
  final _shakeKey = GlobalKey<ShakeErrorWidgetState>();

  MemberTopupGameProvider get _provider => getMemberTopupGameProvider(context);

  void closePage() {
    _provider.resetProduct();
    pop();
  }

  Future<void> _onRefresh() async => _provider.fetchProducts();

  List<ProductModel> _filterProducts(
    List<ProductModel> products,
    String search,
    SortProductBy sortBy,
  ) {
    var filtered = products;

    if (search.isNotEmpty) {
      final searchLower = search.toLowerCase();
      filtered = filtered.where((p) {
        final nama = p.namaproduk
            .replaceAll(RegExp(r'[^\w\s]'), '')
            .toLowerCase();
        final deskripsi = p.deskripsiproduk
            .replaceAll(RegExp(r'[^\w\s]'), '')
            .toLowerCase();
        return nama.contains(searchLower) || deskripsi.contains(searchLower);
      }).toList();
    }

    return sortProducts(filtered, sortBy);
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
            title: _provider.state.selectedProvider.namaprovider,
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildIdAkunCard(),
                _buildCekAkunDetail(),
                _buildSortFilterProduct(),
                _buildDetailProvider(),
                Expanded(child: _buildListProduk()),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BlocProvider.value(
      value: _provider,
      child: BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
        buildWhen: (prev, curr) =>
            prev.selectedProduct != curr.selectedProduct ||
            prev.tujuanHasError != curr.tujuanHasError ||
            prev.tujuan != curr.tujuan ||
            prev.apiFetchProductStatus != curr.apiFetchProductStatus,
        builder: (context, state) {
          final bottomInset = MediaQuery.of(context).viewInsets.bottom;
          final isDisabled =
              state.selectedProduct.idproduk == 0 ||
              state.tujuanHasError ||
              state.tujuan.isEmpty ||
              state.apiFetchProductStatus.isLoading;

          return Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: ButtonCheckout(
              isDisabled: isDisabled,
              selectedProduct: state.selectedProduct,
              onContinue: () => _provider.setNewKonfirmasi(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIdAkunCard() {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (prev, curr) =>
          prev.tujuan != curr.tujuan ||
          prev.tujuanHasError != curr.tujuanHasError ||
          prev.titleForm != curr.titleForm ||
          prev.hintForm != curr.hintForm ||
          prev.isCekAkun != curr.isCekAkun ||
          prev.selectedProvider != curr.selectedProvider,
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
          onChanged: (value) => _provider.setTujuan(value),
          onClear: () => _provider.setTujuan('', updateController: true),
          shakeKey: _shakeKey,
          showFavoritButton: true,
          isGuest: false,
          tipeInput: state.selectedProvider.inputTipe,
          suffixWidget: CustomPopupInputTujuan(
            onResult: (val) => _provider.setTujuan(val, updateController: true),
            isTempel: true,
            isVoice: true,
            isContact: true,
          ),
          onFavoritResult: (val) {},
        );
      },
    );
  }

  Widget _buildCekAkunDetail() {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (prev, curr) =>
          prev.selectedProvider != curr.selectedProvider ||
          prev.isCekAkun != curr.isCekAkun ||
          prev.apiCekAkunStatus != curr.apiCekAkunStatus ||
          prev.tujuan != curr.tujuan,
      builder: (context, state) {
        if (!state.isCekAkun) return const SizedBox.shrink();

        final isMobileLegend = state.selectedProvider.namaprovider
            .toLowerCase()
            .contains('mobile legend');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMobileLegend) _buildMobileLegendInfo(),
            if (state.isCekAkun)
              ButtonCekAkun(
                onPressed: () {
                  getMemberTopupGameProvider(context).cekAkunGame();
                },
                isLoading: state.apiCekAkunStatus.isLoading,
                dataAkun: state.cekAkunResult,
                tujuan: state.tujuan,
              ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLegendInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: paddingCard,
        decoration: BoxDecoration(
          color: context.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.primary),
        ),
        child: Row(
          children: [
            Icon(MdiIcons.informationOutline, size: 18, color: context.primary),
            const Gap(6),
            Expanded(
              child: Text(
                'Gabungkan ID Game dan Zone ID.\n'
                'Contoh: ID Game 12345678 Dan ID Zone 1234 maka IDGAME : 123456781234.',
                style: context.bodySmall
                    .withColor(context.primary)
                    .withWeight(FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCekAkunButton(MemberTopupGameState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CustomButton(
        text: 'Cek Akun',
        onPressed: () => _provider.cekAkunGame(),
        isLoading: state.apiCekAkunStatus.isLoading,
        height: 25,
        width: double.infinity,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildCekAkunResultCard(MemberTopupGameState state) {
    return Card(
      child: Padding(
        padding: paddingPage,
        child: ListView.builder(
          itemCount: state.cekAkunResult.items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = state.cekAkunResult.items[index];
            return Row(
              children: [
                Expanded(
                  child: Text(
                    item.key,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                ),
                Text(
                  item.value,
                  style: context.bodyMedium.withWeight(FontWeight.w400),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailProvider() {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (prev, curr) => prev.selectedProvider != curr.selectedProvider,
      builder: (context, state) {
        return CardProvider(
          imageUrl: state.selectedProvider.imgprovider,
          title: state.selectedProvider.namaprovider,
          subtitle: state.selectedProvider.deskripsiprovider,
          isGanti: false,
          onPressed: closePage,
        );
      },
    );
  }

  Widget _buildSortFilterProduct() {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (prev, curr) =>
          prev.searchProduct != curr.searchProduct ||
          prev.sortProduct != curr.sortProduct,
      builder: (context, state) {
        return SortFilterProduct(
          searchController: state.searchProductController!,
          searchValue: state.searchProduct,
          hasError: state.tujuanHasError,
          selectedSort: state.sortProduct,
          onSearchChanged: (val) => _provider.setSearchProduct(val),
          onClearSearch: () =>
              _provider.setSearchProduct('', updateController: true),
          onSortSelected: (sortBy) => _provider.setSortProduct(sortBy),
        );
      },
    );
  }

  Widget _buildListProduk() {
    return BlocBuilder<MemberTopupGameProvider, MemberTopupGameState>(
      buildWhen: (prev, curr) =>
          prev.products != curr.products ||
          prev.searchProduct != curr.searchProduct ||
          prev.sortProduct != curr.sortProduct ||
          prev.selectedProduct != curr.selectedProduct ||
          prev.apiFetchProductStatus != curr.apiFetchProductStatus,
      builder: (context, state) {
        final products = _filterProducts(
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
              onPress: () => _provider.setSelectedProduct(product),
            );
          },
          emptyTitle: 'Produk tidak ditemukan',
        );
      },
    );
  }
}
