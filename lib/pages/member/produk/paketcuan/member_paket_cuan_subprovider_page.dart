import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_produk.dart';

import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/pages/member/produk/paketcuan/member_paket_cuan_produk_page.dart';
import 'package:dmpku/pages/member/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MemberPaketCuanSubProviderPage extends StatefulWidget {
  static const routeName = '/member/paketcuan/subprovider';

  const MemberPaketCuanSubProviderPage({super.key});

  @override
  State<MemberPaketCuanSubProviderPage> createState() =>
      _MemberPaketCuanSubProviderPageState();
}

class _MemberPaketCuanSubProviderPageState
    extends State<MemberPaketCuanSubProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getMemberPaketCuanProvider(context).fetchSubProviders();
  }

  void closePage() {
    pop();
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
          isEditable: true,
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
          tipeProduk: TipeProduk.pulsa,
          suffixWidget: CustomPopupInputTujuan(
            onResult: (val) {
              getMemberPaketCuanProvider(
                context,
              ).setTujuan(val, updateController: true);
            },
            isContact: true,
            isTempel: true,
            isVoice: true,
          ),
          onFavoritResult: (val) {
            getMemberPaketCuanProvider(
              context,
            ).setTujuan(val, updateController: true);
          },
        );
      },
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
      buildWhen: (previous, current) =>
          previous.subProviders != current.subProviders ||
          previous.tujuan != current.tujuan ||
          previous.apiFetchSubProviderStatus !=
              current.apiFetchSubProviderStatus,
      builder: (context, state) {
        return RefreshableList(
          loadingWidget: CardProviderListShimmer(itemCount: 6),
          isLoading: state.apiFetchSubProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: state.subProviders,
          itemBuilder: (context, product, index) {
            return CardProvider(
              title: product.namaproduk,
              subtitle: product.deskripsiproduk,
              imageUrl: product.imgproduk,
              onPressed: () {
                var valid = getMemberPaketCuanProvider(
                  context,
                ).validateTujuan();

                if (!valid) {
                  shakeKey.currentState?.shake();
                  return;
                } else {
                  getMemberPaketCuanProvider(
                    context,
                  ).setSelectedSubProvider(product);
                  pushNamed(
                    MemberPaketCuanProdukPage.routeName,
                    arguments: getMemberPaketCuanProvider(context),
                  );
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
