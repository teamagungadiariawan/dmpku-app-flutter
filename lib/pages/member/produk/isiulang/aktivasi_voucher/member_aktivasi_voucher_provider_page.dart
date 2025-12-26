import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_produk_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MemberAktivasiVoucherProviderPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/aktivasi-voucher/provider';

  const MemberAktivasiVoucherProviderPage({super.key});

  @override
  State<MemberAktivasiVoucherProviderPage> createState() =>
      _MemberAktivasiVoucherProviderPageState();
}

class _MemberAktivasiVoucherProviderPageState
    extends State<MemberAktivasiVoucherProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getMemberAktivasiVoucherProvider(context).fetchProviders();
  }

  void closePage() {
    pop();
  }

  List<ProviderModel> _filterProviders(
    List<ProviderModel> providers,
    String search,
  ) {
    var filteredProviders = providers;

    if (search.isNotEmpty) {
      filteredProviders = filteredProviders.where((provider) {
        var namaProvider = provider.namaprovider.replaceAll(
          RegExp(r'[^\w\s]'),
          '',
        );
        return namaProvider.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    return filteredProviders;
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
            title: "Pilih Provider Aktivasi Voucher",
            onBackButtonPressed: () {
              closePage();
            },
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildSearchField(context),
                Gap(10),
                Expanded(child: _buildListProvider(context)),
                Gap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<
      MemberAktivasiVoucherProvider,
      MemberAktivasiVoucherState
    >(
      buildWhen: (previous, current) =>
          previous.providers != current.providers ||
          previous.searchProvider != current.searchProvider ||
          previous.apiFetchProviderStatus != current.apiFetchProviderStatus,
      builder: (context, state) {
        var providers = _filterProviders(state.providers, state.searchProvider);
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
                pushNamed(
                  MemberAktivasiVoucherProdukPage.routeName,
                  arguments: getMemberAktivasiVoucherProvider(context),
                );
                getMemberAktivasiVoucherProvider(
                  context,
                ).setSelectedProvider(provider);
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

  Widget _buildSearchField(BuildContext context) {
    return BlocBuilder<
      MemberAktivasiVoucherProvider,
      MemberAktivasiVoucherState
    >(
      buildWhen: (previous, current) =>
          previous.searchProvider != current.searchProvider,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(color: context.border, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(LucideIcons.search, size: 18, color: context.foreground),
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: state.searchProviderController,
                  onChanged: getMemberAktivasiVoucherProvider(
                    context,
                  ).setSearchProvider,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Provider',
                    suffixIcon: state.searchProvider.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberAktivasiVoucherProvider(
                                context,
                              ).setSearchProvider('', updateController: true);
                            },
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: context.foreground,
                            ),
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
