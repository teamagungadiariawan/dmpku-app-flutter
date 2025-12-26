import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/guest_paket_cuan_subprovider_page.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/widgets/promo_banner_paket_cuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/produk/card_paket_cuan.dart';
import 'package:dmpku/widgets/produk/card_paket_cuan_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class GuestPaketCuanProviderPage extends StatefulWidget {
  static const routeName = '/guest/paketcuan/provider';

  const GuestPaketCuanProviderPage({Key? key}) : super(key: key);

  @override
  _GuestPaketCuanProviderPageState createState() =>
      _GuestPaketCuanProviderPageState();
}

class _GuestPaketCuanProviderPageState
    extends State<GuestPaketCuanProviderPage> {
  void closePage() {
    pop();
  }

  Future<void> _onRefresh() async {
    getPaketCuanProvider(context).fetchProviders();
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
            title: "Paket Cuan Spesial",
            onBackButtonPressed: () {
              closePage();
            },
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                PromoBannerPaketCuan(),
                Gap(10),
                Expanded(child: _buildListProvider(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<PaketCuanProvider, PaketCuanState>(
      buildWhen: (previous, current) =>
          previous.providers != current.providers ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        return RefreshableList(
          loadingWidget: CardPaketCuanListShimmer(
            itemCount: 6,
            itemMargin: EdgeInsets.symmetric(vertical: 6),
          ),
          isLoading: state.apiFetchProviderStatus.isLoading,
          onRefresh: _onRefresh,
          items: state.providers,
          itemBuilder: (context, provider, index) {
            return CardPaketCuan(
              title: provider.namaprovider,
              subtitle: provider.deskripsiprovider,
              imageUrl: provider.imgprovider,
              onTap: () {
                getPaketCuanProvider(context).setSelectedProvider(provider);
                pushNamed(
                  GuestPaketCuanSubProviderPage.routeName,
                  arguments: getPaketCuanProvider(context),
                );
              },
              onButtonPressed: () {
                getPaketCuanProvider(context).setSelectedProvider(provider);
                pushNamed(
                  GuestPaketCuanSubProviderPage.routeName,
                  arguments: getPaketCuanProvider(context),
                );
              },
            );
          },
          emptyTitle: 'Provider tidak ditemukan',
        );
      },
    );
  }
}
