import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/guest_paket_data_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/paket_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/widgets/card_input_tujuan_pulsa.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class GuestPaketDataProviderPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/paket-data/provider';

  const GuestPaketDataProviderPage({super.key});

  @override
  State<GuestPaketDataProviderPage> createState() =>
      _GuestPaketDataProviderPageState();
}

class _GuestPaketDataProviderPageState
    extends State<GuestPaketDataProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    getPaketDataProvider(context).resetState();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getPaketDataProvider(context).fetchPaketDataProviders();
  }

  void closePage() {
    getPaketDataProvider(context).resetState();
    pop();
  }

  List<ProviderModel> _filterProviders(
    List<ProviderModel> providers,
    String tujuan,
  ) {
    if (tujuan.length <= 2) return providers;

    return providers.where((provider) {
      return provider.prefixList.any((prefix) {
        final maxRange = tujuan.length < prefix.length
            ? tujuan.length
            : prefix.length;
        return prefix.startsWith(tujuan.substring(0, maxRange));
      });
    }).toList();
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
            title: "Pilih Provider Paket Data",
            onBackButtonPressed: () {
              closePage();
            },
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildPhoneNumberCard(context),
                Expanded(child: _buildListProvider(context)),
                const Gap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<PaketDataProvider, PaketDataState>(
      builder: (context, state) {
        return CardInputTujuanPulsa(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.hasErrorInputTujuan,
          errorMessage: state.errorMessageInputTujuan,
          isEditable: true,
          controller: state.inputTujuanController,
          focusNode: state.inputTujuanFocusNode,
          onChanged: (value) {
            getPaketDataProvider(context).setTujuan(value);
          },
          onClear: () {
            getPaketDataProvider(
              context,
            ).setTujuan('', updateTextController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: true,
          suffixWidget: CustomPopupInputTujuan(
            onResult: (val) {},
            isContact: true,
            isTempel: true,
            isVoice: true,
          ),
          onFavoritResult: (val) {},
        );
      },
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<PaketDataProvider, PaketDataState>(
      builder: (context, state) {
        var providers = _filterProviders(
          state.paketDataProviders,
          state.tujuan,
        );
        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchPaketDataProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          itemBuilder: (context, provider, index) {
            return CardProvider(
              title: provider.namaprovider,
              subtitle: provider.deskripsiprovider,
              imageUrl: provider.imgprovider,
              onPressed: () {
                var valid = getPaketDataProvider(
                  context,
                ).validateTujuan(selectedProvider: provider);

                if (!valid) {
                  shakeKey.currentState?.shake();
                  return;
                } else {
                  pushNamed(GuestPaketDataProdukPage.routeName);
                  getPaketDataProvider(context).setSelectedProvider(provider);
                }
              },
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
