import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/guest_pulsa_produk_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class GuestPulsaProviderPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/pulsa/provider';

  const GuestPulsaProviderPage({super.key});

  @override
  State<GuestPulsaProviderPage> createState() => _GuestPulsaProviderPageState();
}

class _GuestPulsaProviderPageState extends State<GuestPulsaProviderPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void dispose() {
    getPulsaProvider(context).resetState();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    getPulsaProvider(context).fetchPulsaProviders();
  }

  void closePage() {
    getPulsaProvider(context).resetState();
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
            title: "Pilih Provider Pulsa",
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
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No. Tujuan",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                _buildPhoneInputField(context, state),

                if (state.hasErrorInputTujuan) ...[
                  const Gap(8),
                  Text(
                    state.errorMessageInputTujuan,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],

                const Gap(8),
                ButtonFavorit(isGuest: true, onResult: (val) {}),
                Gap(5)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneInputField(BuildContext context, PulsaState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: state.hasErrorInputTujuan
              ? context.destructive
              : context.border,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(MdiIcons.clipboardAccount, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              focusNode: state.inputTujuanFocusNode,
              controller: state.inputTujuanController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                getPulsaProvider(context).setTujuan(value);
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Masukkan No. Tujuan',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  // Sesuaikan jika perlu
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state.tujuan.isNotEmpty) ...[
                        InkWell(
                          onTap: () {
                            getPulsaProvider(
                              context,
                            ).setTujuan('', updateTextController: true);
                          },
                          child: Icon(
                            MdiIcons.close,
                            size: 18,
                            color: context.foreground,
                          ),
                        ),
                        const Gap(2),
                      ],
                      CustomPopupInputTujuan(
                        isContact: true,
                        isVoice: true,
                        isTempel: true,
                        onResult: (value) {
                          getPulsaProvider(
                            context,
                          ).setTujuan(value, updateTextController: true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).withErrorShake(
      key: shakeKey,
      hasError: state.hasErrorInputTujuan,
      onShakeComplete: () {},
    );
  }

  Widget _buildEmptyState(BuildContext context, PulsaState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(Assets.animations.noData, width: 200, fit: BoxFit.cover),
          Text(
            state.tujuan.isEmpty
                ? 'Masukkan nomor untuk melihat provider'
                : 'Provider tidak ditemukan',
            style: context.bodyMedium
                .copyWith(color: context.mutedForeground)
                .withWeight(FontWeight.bold),
          ),
          Text(
            'Tarik ke bawah untuk refresh',
            style: context.bodySmall.copyWith(color: context.mutedForeground),
          ),
        ],
      ),
    );
  }

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        if (state.apiFetchPulsaProviderStatus.isLoading) {
          return CardProviderListShimmer(itemCount: 6);
        }

        var providers = _filterProviders(state.pulsaProviders, state.tujuan);

        if (providers.isEmpty) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: context.primary,
            backgroundColor: context.card,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: _buildEmptyState(context, state),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _onRefresh,
          color: context.primary,
          backgroundColor: context.card,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              return CardProvider(
                title: provider.namaprovider,
                subtitle: provider.deskripsiprovider,
                imageUrl: provider.imgprovider,
                onPressed: () {
                  var valid = getPulsaProvider(
                    context,
                  ).validateTujuan(selectedProvider: provider);

                  if (!valid) {
                    shakeKey.currentState?.shake();
                    return;
                  } else {
                    pushNamed(GuestPulsaProdukPage.routeName);
                    getPulsaProvider(context).setSelectedProvider(provider);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
