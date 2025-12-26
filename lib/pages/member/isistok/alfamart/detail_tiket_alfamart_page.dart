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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTiketAlfamartPage extends StatefulWidget {
  static const routeName = '/member/isistok/alfamart/detail_tiket';

  const DetailTiketAlfamartPage({super.key});

  @override
  State<DetailTiketAlfamartPage> createState() =>
      _DetailTiketAlfamartPageState();
}

class _DetailTiketAlfamartPageState extends State<DetailTiketAlfamartPage> {
  void closePage() {
    getMemberIsiStokProvider(
      context,
    ).setSelectedRiwayatAlfamart(DEFAULT_RIWAYAT_TIKET_ALFAMART);
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
              final tiket = state.selectedRiwayatAlfamart;
              return Stack(
                children: [
                  _buildHeader(context, tiket, state.tiketDuration),
                  Padding(
                    padding: paddingPage,
                    child: Column(
                      children: [
                        const SizedBox(height: 200),
                        _buildKodeBayarCard(context, tiket),
                        const Gap(5),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              _buildRincianCard(context, tiket),
                              const Gap(5),
                              _buildCaraBayarCard(context),
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
    RiwayatTiketAlfamartModel tiket,
    Duration duration,
  ) {
    final formattedTime =
        '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final expiredDate =
        DateHelper.tryParse(tiket.expireddata) ?? DateTime.now();
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
                  title: 'Detail Tiket Alfamart',
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

  Widget _buildKodeBayarCard(
    BuildContext context,
    RiwayatTiketAlfamartModel tiket,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Text(
              "Kode Pembayaran",
              style: context.sectionTitle,
              textHeightBehavior: AppTextHeightBehavior.noPadding,
            ),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tiket.kodebayar,
                  style: GoogleFonts.inconsolata(
                    color: context.foreground,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Gap(10),
                CustomButton(
                  text: "Salin",
                  icon: MdiIcons.contentCopy,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: tiket.kodebayar));
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 32,
                ),
              ],
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
                      "Tunjukkan kode pembayaran ini ke kasir Alfamart terdekat.",
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

  Widget _buildRincianCard(
    BuildContext context,
    RiwayatTiketAlfamartModel tiket,
  ) {
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
                _buildRow(context, "Nominal Topup", ToCurrency(tiket.nominal.toString())),
                const Gap(8),
                _buildRow(context, "Biaya Admin", ToCurrency(tiket.admin.toString())),
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

  Widget _buildCaraBayarCard(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Cara Pembayaran",
          style: context.bodyLarge.withWeight(FontWeight.w600),
        ),
        children: [
          Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStep(1, "Datang ke gerai Alfamart terdekat."),
                _buildStep(
                  2,
                  "Sampaikan ke kasir ingin melakukan pembayaran PLASAMALL.",
                ),
                _buildStep(3, "Tunjukkan Kode Pembayaran kepada kasir."),
                _buildStep(4, "Lakukan pembayaran sesuai nominal yang tertera."),
                _buildStep(5, "Simpan struk sebagai bukti pembayaran yang sah."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number. ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
