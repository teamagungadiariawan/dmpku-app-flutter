import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/guest_paket_nelpon_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/paket_nelpon_provider.dart';import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class GuestPaketNelponProviderPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/paket-nelpon/provider';

  const GuestPaketNelponProviderPage({super.key});

  @override
  State<GuestPaketNelponProviderPage> createState() =>
      _GuestPaketNelponProviderPageState();
}

class _GuestPaketNelponProviderPageState
    extends State<GuestPaketNelponProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    getPaketNelponProvider(context).resetState();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getPaketNelponProvider(context).fetchProviders();
  }

  void closePage() {
    getPaketNelponProvider(context).resetState();
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
            title: "Pilih Provider Paket Nelpon",
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
    return BlocBuilder<PaketNelponProvider, PaketNelponState>(
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
            getPaketNelponProvider(context).setTujuan(value);
          },
          onClear: () {
            getPaketNelponProvider(context).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: true,
          tipeInput: TipeInput.numericOnly,
          icon: MdiIcons.clipboardAccount,
          suffixWidget: CustomPopupInputTujuan(
            onResult: (val) {
              getPaketNelponProvider(context).setTujuan(val, updateController: true);
            },
            isTempel: true,
            isVoice: true,
            isContact: true,
          ),
          onFavoritResult: (val) {},
        );
      },
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<PaketNelponProvider, PaketNelponState>(
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
                var valid = getPaketNelponProvider(
                  context,
                ).validateTujuan(provider: provider);

                debugPrint('Is Valid Tujuan: $valid');

                if (!valid) {
                  shakeKey.currentState?.shake();
                  return;
                } else {
                  pushNamed(GuestPaketNelponProdukPage.routeName);
                  getPaketNelponProvider(context).setSelectedProvider(provider);
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
