import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_popup_input_tujuan.dart';
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
    // Trigger refresh data provider
    getPulsaProvider(context).fetchPulsaProviders();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          getPulsaProvider(context).resetState();
          pop();
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Pilih Provider Pulsa",
            onBackButtonPressed: () {
              getPulsaProvider(context).resetState();
              pop();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 6.0,
            ),
            child: Column(
              children: [
                _buildPhoneNumberCard(context),
                const Gap(5),
                Expanded(child: _buildListProvider(context)),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No. Tujuan",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(5),
                _buildPhoneInputField(context, state),

                if (state.hasErrorInputTujuan) ...[
                  const Gap(5),
                  Text(
                    state.errorMessageInputTujuan,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],

                const Gap(5),
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
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Masukkan No. Tujuan',
                contentPadding: EdgeInsets.zero,
                hoverColor: Colors.transparent,
                fillColor: Colors.transparent,
                focusColor: Colors.transparent,
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
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ), // Hilangkan constraint default
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

  Widget _buildListProvider(BuildContext context) {
    return BlocBuilder<PulsaProvider, PulsaState>(
      builder: (context, state) {
        if (state.apiFetchPulsaProviderStatus.isLoading) {
          return CardProviderListShimmer(itemCount: 6);
        }

        var providers = state.pulsaProviders;

        // Filter providers berdasarkan prefix nomor tujuan
        if (state.tujuan.length > 2) {
          providers = providers.where((provider) {
            var ada = false;
            var prefikList = provider.prefixList;

            for (var prefik in prefikList) {
              var maxRange = state.tujuan.length < prefik.length
                  ? state.tujuan.length
                  : prefik.length;

              if (prefik.startsWith(state.tujuan.substring(0, maxRange))) {
                ada = true;
                break;
              }
            }
            return ada;
          }).toList();
        }

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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          Assets.animations.noData,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
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
                          style: context.bodySmall.copyWith(
                            color: context.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  // Handle provider selection
                  debugPrint('Selected: ${provider.namaprovider}');
                  var valid = getPulsaProvider(
                    context,
                  ).validateTujuan(selectedProvider: provider);

                  if (!valid) {
                    shakeKey.currentState?.shake();
                    return;
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
