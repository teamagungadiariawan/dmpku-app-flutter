import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/guest_masa_aktif_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/masa_aktif_provider.dart';
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

class GuestMasaAktifProviderPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/masa-aktif/provider';

  const GuestMasaAktifProviderPage({super.key});

  @override
  State<GuestMasaAktifProviderPage> createState() =>
      _GuestMasaAktifProviderPageState();
}

class _GuestMasaAktifProviderPageState
    extends State<GuestMasaAktifProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    getMasaAktifProvider(context).resetState();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getMasaAktifProvider(context).fetchProviders();
  }

  void closePage() {
    getMasaAktifProvider(context).resetState();
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
      child:  WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Pilih Provider Masa Aktif",
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
    return BlocBuilder<MasaAktifProvider, MasaAktifState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuanPulsa(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: true,
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getMasaAktifProvider(context).setTujuan(value);
          },
          onClear: () {
            getMasaAktifProvider(
              context,
            ).setTujuan('', updateController: true);
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
    return BlocBuilder<MasaAktifProvider, MasaAktifState>(
      buildWhen: (previous, current) =>
          previous.providers != current.providers ||
          previous.tujuan != current.tujuan ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        var providers = _filterProviders(
          state.providers,
          state.tujuan,
        );
        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: providers,
          itemBuilder: (context, provider, index) {
            return CardProvider(
              title: provider.namaprovider,
              subtitle: provider.deskripsiprovider,
              imageUrl: provider.imgprovider,
              onPressed: () {
                var valid = getMasaAktifProvider(
                  context,
                ).validateTujuan(provider: provider);

                if (!valid) {
                  shakeKey.currentState?.shake();
                  return;
                } else {
                  pushNamed(GuestMasaAktifProdukPage.routeName);
                  getMasaAktifProvider(context).setSelectedProvider(provider);
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
