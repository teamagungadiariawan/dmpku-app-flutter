import 'package:dmpku/core/enums/status_tiket.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/card_tanya.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTiketQrisPage extends StatefulWidget {
  static const routeName = '/member/isistok/qris/detail_tiket';

  const DetailTiketQrisPage({super.key});

  @override
  State<DetailTiketQrisPage> createState() => _DetailTiketQrisPageState();
}

class _DetailTiketQrisPageState extends State<DetailTiketQrisPage> {
  void closePage() {
    getMemberIsiStokProvider(
      context,
    ).setSelectedRiwayatQris(DEFAULT_RIWAYAT_TIKET_QRIS);
    getMemberIsiStokProvider(context).stopTimerDebounce();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          closePage();
        },
        child: Scaffold(
          body: BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
            builder: (context, state) {
              final tiket = state.selectedRiwayatQris;
              return Stack(
                children: [
                  _buildHeader(context, tiket, state.tiketDuration),
                  Padding(
                    padding: paddingPage,
                    child: Column(
                      children: [
                        const SizedBox(height: 210),
                        _buildQrCodeCard(context, tiket),
                        const Gap(5),
                        Container(
                          padding: paddingCard,
                          decoration: BoxDecoration(
                            color: context.destructive,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  "!",
                                  style: context.pageTitle.withColor(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              Gap(12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pengingat",
                                    style: context.bodyLarge
                                        .withColor(Colors.white)
                                        .withWeight(FontWeight.w600),
                                    textHeightBehavior:
                                        AppTextHeightBehavior.noPadding,
                                  ),

                                  RichText(
                                    text: TextSpan(
                                      style: context.captionMedium.withColor(
                                        Colors.white,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "Nominal stok yang masuk adalah ",
                                        ),
                                        TextSpan(
                                          text: ToCurrency(
                                            tiket.saldomasuk.toString(),
                                          ),
                                          style: context.bodySmall
                                              .withColor(Colors.white)
                                              .withWeight(FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(5),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              _buildRincianCard(context, tiket),
                              const Gap(5),
                              CardTanya(
                                onTap: () {},
                                title: "Ada kendala saat isi stok?",
                                borderColor: tiket.tiketStatus.bgColor(context),
                              ),
                              const Gap(30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    RiwayatTiketQRISModel tiket,
    Duration duration,
  ) {
    final formattedTime =
        '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final expiredDate = DateHelper.tryParse(tiket.expired) ?? DateTime.now();
    final formattedDate = DateHelper.formatFullDateWithDayShort(expiredDate);
    final hourMinute = DateHelper.formatTime(expiredDate);

    return Container(
      height: 250,
      color: tiket.tiketStatus.bgColor(context),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  backgroundColor: Colors.transparent,
                  title: 'Detail Tiket QRIS',
                  onBackButtonPressed: closePage,
                ),
                const Gap(20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: paddinPageh),
                  padding: paddingCard.copyWith(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? slate[800] : slate[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: tiket.tiketStatus.bgColor(context),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        tiket.tiketStatus.icon,
                        size: 20,
                        color: tiket.tiketStatus.textColorSecondary(context),
                      ),
                      const Gap(8),
                      Text(
                        !tiket.tiketStatus.isPending
                            ? tiket.tiketStatus.text
                            : formattedTime,
                        style: GoogleFonts.inconsolata(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: tiket.tiketStatus.textColorSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Text(
                  "Batas waktu pembayaran",
                  style: context.sectionTitle
                      .withColor(Colors.white)
                      .withWeight(FontWeight.w600),
                ),
                Text(
                  "$formattedDate \u2022 $hourMinute",
                  style: context.pageTitle
                      .withColor(Colors.white)
                      .withWeight(FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCodeCard(BuildContext context, RiwayatTiketQRISModel tiket) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Text(
              "Scan QRIS",
              style: context.sectionTitle,
              textHeightBehavior: AppTextHeightBehavior.noPadding,
            ),
            const Gap(15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: context.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImage(url: tiket.qrurl, size: 200),
              ),
            ),
            const Gap(15),
            CustomButton(
              text: "Download QRIS",
              icon: MdiIcons.download,
              onPressed: () {
                // TODO: Implement download QRIS
              },
              variant: ButtonVariant.outline,
              height: 40,
            ),
            const Gap(12),
            Container(
              padding: paddingCard,
              decoration: BoxDecoration(
                color: context.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.primary),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    MdiIcons.informationSlabCircle,
                    color: context.primary,
                    size: 20,
                  ),
                  const Gap(5),
                  Expanded(
                    child: Text(
                      "Scan QRIS di atas menggunakan aplikasi e-wallet atau mobile banking Anda.",
                      style: context.bodyMedium.withColor(context.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRincianCard(BuildContext context, RiwayatTiketQRISModel tiket) {
    return Card(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: paddingCard,
            decoration: BoxDecoration(
              color: !context.isDarkMode ? slate[50] : slate[800],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              border: Border(
                bottom: BorderSide(color: context.border, width: 1),
              ),
            ),
            child: Text(
              "Rincian Pembayaran",
              style: context.bodyLarge.withWeight(FontWeight.w600),
            ),
          ),
          Padding(
            padding: paddingCard,
            child: Column(
              children: [
                _buildRow(
                  context,
                  "Nominal Topup",
                  ToCurrency(tiket.nominal.toString()),
                ),
                const Gap(8),
                _buildRow(
                  context,
                  "Biaya Admin",
                  ToCurrency(tiket.admin.toString()),
                ),
                const Divider(height: 20),
                _buildRow(
                  context,
                  "Total Bayar",
                  ToCurrency(tiket.totalbayar.toString()),
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyMedium.withColor(context.mutedForeground),
        ),
        Text(
          value,
          style: context.bodyMedium.withWeight(
            isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
