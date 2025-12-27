import 'dart:io';

import 'package:dmpku/core/enums/status_trx.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/widgets/atur_harga_ppob_1_dialog.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class BagikanPpob1Page extends StatefulWidget {
  static const routeName = '/member/riwayat/bagikan-struk-ppob_1';

  const BagikanPpob1Page({super.key});

  @override
  State<BagikanPpob1Page> createState() => _BagikanPpob1PageState();
}

class _BagikanPpob1PageState extends State<BagikanPpob1Page> {
  final List<String> keyHide = ['totalbayar', 'totalpotongstok'];

  // REVISI: Max 32 Karakter
  final int maxChars = 32;

  void closePage() {
    getMemberCetakStrukPpob1Provider(context).resetState();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: WillPopScope(
        onWillPop: () async {
          closePage();
          return true;
        },
        child: Scaffold(
          body: Stack(
            children: [
              _buildHeaderSection(context),
              _buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: HEADER (Background Berwarna)
  // ===========================================================================
  Widget _buildHeaderSection(BuildContext context) {
    return BlocBuilder<
      MemberCetakStrukPpob1Provider,
      MemberCetakStrukPpob1State
    >(
      buildWhen: (old, current) =>
          old.detailTransaksi != current.detailTransaksi,
      builder: (context, state) {
        var color = state.detailTransaksi.statusTrx.bgColorTrx(context);
        var status = state.detailTransaksi.statusTrx;
        var waktu = state.detailTransaksi.waktuTrx;

        final hariTanggal = DateHelper.formatSimpleDate(waktu);
        final jam = DateHelper.formatTime(waktu);

        return Container(
          height: 250,
          color: color,
          child: Stack(
            children: [
              Positioned.fill(
                child: RhombusPattern(
                  color: Colors.black.withValues(alpha: 0.05),
                  radius: 4,
                  spacing: 30,
                  isStaggered: false,
                ),
              ),
              Positioned.fill(
                child: Column(
                  children: [
                    _buildAppBar(context, status),
                    const Gap(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddinPageh),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.card.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.primaryForeground,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              status.icon,
                              color: context.primaryForeground,
                              size: 24,
                            ),
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaksi ${status.text}",
                                textAlign: TextAlign.center,
                                style: context.sectionTitle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.primaryForeground,
                                ),
                              ),
                              Text(
                                "$hariTanggal \u2022 $jam",
                                textAlign: TextAlign.center,
                                style: context.bodySmall
                                    .copyWith(color: context.primaryForeground)
                                    .withWeight(FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, TrxStatus status) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: closePage,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.chevronLeft, size: 22, color: Colors.white),
            Spacer(),
            Text(
              "Bagikan Struk",
              style: context.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Image(image: status.imageProvider, width: 25, height: 25),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: MAIN CONTENT (White Card)
  // ===========================================================================
  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 140),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: paddingPage,
            decoration: BoxDecoration(
              color: context.card,
              border: Border.all(color: context.border, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 25,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child:
                BlocBuilder<
                  MemberCetakStrukPpob1Provider,
                  MemberCetakStrukPpob1State
                >(
                  builder: (context, state) {
                    var color = state.detailTransaksi.statusTrx.bgColorTrx(
                      context,
                    );
                    var status = state.detailTransaksi.statusTrx;

                    return Column(
                      children: [
                        _buildProductInfo(context, state),

                        Divider(height: 1, thickness: 0.7, color: color),
                        _buildScrollableDetails(context, state, color, status),
                      ],
                    );
                  },
                ),
          ),
        ),
        BlocBuilder<MemberCetakStrukPpob1Provider, MemberCetakStrukPpob1State>(
          builder: (context, state) {
            return _buildFooterSection(context, state);
          },
        ),
        const Gap(10),
      ],
    );
  }

  Widget _buildProductInfo(
    BuildContext context,
    MemberCetakStrukPpob1State state,
  ) {
    return Padding(
      padding: paddingCard,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.isDarkMode ? neutral[700] : slate[300],
            ),
            child: CustomNetworkImage(url: state.detailTransaksi.imgproduk),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.detailTransaksi.namaproduk,
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                ),
                Text(
                  state.detailTransaksi.keteranganproduk,
                  maxLines: 2,
                  style: context.bodySmall.withColor(context.foreground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION: LISTS & DETAILS
  // ===========================================================================
  Widget _buildScrollableDetails(
    BuildContext context,
    MemberCetakStrukPpob1State state,
    Color? dividerColor,
    TrxStatus status,
  ) {
    var dataTrx = state.dataTrx;
    if (status.isSuccess) {
      bool hasSn = dataTrx.any((item) => item.key == state.titleSn);
      if (!hasSn) dataTrx.add(KeyValue(key: state.titleSn, value: state.sn));
    }

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          ..._buildDataList(dataTrx),

          // 2. List Biaya / Potong Stok
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: _buildSectionHeader(context, "Detail Potong Stok"),
          ),
          ..._buildDataList(state.dataBiaya, isCurrency: true),

          // 3. Footer (Total & Warnings)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: status.bgColorTrx(context),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Total Bayar",
                    style: context.bodyMedium
                        .withWeight(FontWeight.w600)
                        .withColor(Colors.white),
                  ),
                ),
                Text(
                  ToCurrency(state.totalBayar.toString()),
                  style: context.bodyMedium
                      .withWeight(FontWeight.w800)
                      .withColor(Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Container(
      padding: paddingCard,
      decoration: BoxDecoration(
        color: context.isDarkMode ? slate[600] : slate[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(title, style: context.bodyMedium.withWeight(FontWeight.w600)),
    );
  }

  List<Widget> _buildDataList(List<KeyValue>? data, {bool isCurrency = false}) {
    if (data == null) return [];
    return data.map((item) {
      if (isCurrency) {
        // Modif value untuk format currency
        final displayValue = (item.value == "0" || item.value == '')
            ? "0"
            : ToCurrency(item.value);
        return _buildDetailItem(context, item.copyWith(value: displayValue));
      }
      return _buildDetailItem(context, item);
    }).toList();
  }

  Widget _buildDetailItem(BuildContext context, KeyValue? item) {
    if (item == null) return const SizedBox.shrink();

    var keyLower = item.key.toString().toLowerCase();
    keyLower = keyLower.replaceAll(' ', '');
    keyLower = removeNonAlphanumeric(keyLower);

    if (keyHide.contains(keyLower) || item.value.toString().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.border, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              item.key,
              style: context.bodyMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.foreground),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              item.value,
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodySmall
                  .withWeight(FontWeight.w500)
                  .withColor(context.foreground),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION: FOOTER
  // ===========================================================================
  Widget _buildFooterSection(
    BuildContext context,
    MemberCetakStrukPpob1State state,
  ) {
    ButtonVariant buttonVariant = ButtonVariant.primary;

    var status = state.detailTransaksi.statusTrx;
    if (status.isFailed) {
      buttonVariant = ButtonVariant.destructive;
    } else if (status.isPending) {
      buttonVariant = ButtonVariant.warning;
    } else if (status.isSuccess) {
      buttonVariant = ButtonVariant.primary;
    }

    return Container(
      padding: paddingPage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (state.detailTransaksi.statusTrx.isSuccess) ...[
                Expanded(
                  child: CustomButton(
                    padding: EdgeInsets.zero,
                    height: 30,
                    text: "Atur Harga",
                    onPressed: () {
                      AturHargaPpob1Dialog.show(
                        context,
                        initialBiayaJasa: state.biayaJasa,
                      );
                    },
                    icon: MdiIcons.cashEdit,
                  ),
                ),
                Gap(6),
              ],
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  padding: EdgeInsets.zero,
                  height: 30,
                  text: "Bagikan",
                  variant: buttonVariant,
                  onPressed: () {
                    _handleShareFullPage(context, state);
                  },
                  icon: LucideIcons.share2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _handleShareFullPage(
    BuildContext context,
    MemberCetakStrukPpob1State state,
  ) async {
    var color = state.detailTransaksi.statusTrx.bgColorTrx(context);
    var status = state.detailTransaksi.statusTrx;

    var dataTrx = state.dataTrx;

    // 1. AMBIL BLOC YANG UDAH ADA
    final myBloc = context.read<MemberCetakStrukPpob1Provider>();

    final Uint8List? image = await screenshotController.captureFromWidget(
      // 2. SUNTIK BLOC KE DALAM WIDGET SCREENSHOT
      BlocProvider.value(
        value: myBloc, // Ini kuncinya biar BlocBuilder di dalemnya gak error
        child: InheritedTheme.captureAll(
          context,
          Material(
            child: Container(
              width: double.maxFinite,
              child: Stack(
                children: [
                  _buildHeaderSection(
                    context,
                  ), // BlocBuilder di sini sekarang aman
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 140),
                      Container(
                        width: double.infinity,
                        margin: paddingPage,
                        decoration: BoxDecoration(
                          color: context.card,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          border: Border.all(color: context.border, width: 0.5),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildProductInfo(context, state),
                            Divider(height: 1, thickness: 0.7, color: color),
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              children: [
                                ..._buildDataList(dataTrx),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: _buildSectionHeader(
                                    context,
                                    "Detail Potong Stok",
                                  ),
                                ),
                                ..._buildDataList(
                                  state.dataBiaya,
                                  isCurrency: true,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    color: status.bgColorTrx(context),
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Total Bayar",
                                          style: context.bodyMedium
                                              .withWeight(FontWeight.w600)
                                              .withColor(Colors.white),
                                        ),
                                      ),
                                      Text(
                                        ToCurrency(state.totalBayar.toString()),
                                        style: context.bodyMedium
                                            .withWeight(FontWeight.w800)
                                            .withColor(Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Center(
                        child: Text(
                          "Simpan bukti transaksi ini.",
                          style: context.bodySmall,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      delay: const Duration(milliseconds: 100),
      context: context,
    );

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/struk_full.png').create();
      await imagePath.writeAsBytes(image);
      await Share.shareXFiles([XFile(imagePath.path)], text: 'Bukti Transaksi');
    }
  }
}
