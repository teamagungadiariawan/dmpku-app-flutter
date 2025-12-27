import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/status_trx.dart';
import 'package:dmpku/core/enums/tipe_trx.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_bagikan_elektrik_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_cetak_struk_elektrik_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_cetak_struk_elektrik_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_bagikan_nominal_bebas_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_cetak_struk_nominal_bebas_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_cetak_struk_nominal_bebas_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_bagikan_ppob_1_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_bagikan_ppob_2_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_cetak_struk_ppob_2_page.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_cetak_struk_ppob_2_provider.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/pilih_ppob_cetak_dialog.dart';
import 'package:dmpku/widgets/card_tanya.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberDetailRiwayatPage extends StatefulWidget {
  static const routeName = '/member/riwayat/detail';

  const MemberDetailRiwayatPage({super.key});

  @override
  State<MemberDetailRiwayatPage> createState() =>
      _MemberDetailRiwayatPageState();
}

class _MemberDetailRiwayatPageState extends State<MemberDetailRiwayatPage> {
  // --- Constants ---
  final List<String> keySalin = [
    'tujuan',
    'ref',
    'token',
    'idpelanggan',
    'noakun',
    'idakun',
    'norekenening',
    'nosambungan',
    'nobank',
    'idgame',
    'voucher',
    'sn',
    'kodereeedem',
    'kodevoucher',
    'iddoku',
    'idmaxim',
    'noseri',
  ];

  final List<String> keyHide = ['totalbayar', 'totalpotongstok'];

  // --- Actions ---
  void closePage() {
    getMemberDetailRiwayatProvider(context).resetDetailTransaksi();
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
    return BlocBuilder<MemberDetailRiwayatProvider, MemberDetailRiwayatState>(
      buildWhen: (old, current) =>
          old.detailTransaksiStatus != current.detailTransaksiStatus ||
          old.detailTransaksi != current.detailTransaksi,
      builder: (context, state) {
        var color = context.isDarkMode ? neutral[800] : neutral[400];
        var status = TrxStatus.expired;
        var waktu = DateTime.now();

        if (state.detailTransaksiStatus.isSuccess) {
          color = state.detailTransaksi.statusTrx.bgColorTrx(context);
          status = state.detailTransaksi.statusTrx;
          waktu = state.detailTransaksi.waktuTrx;
        }

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
                    _buildAppBar(status),
                    _buildStatusIconAndDate(
                      context,
                      state,
                      status,
                      hariTanggal,
                      jam,
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

  Widget _buildAppBar(TrxStatus status) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: closePage,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(LucideIcons.chevronLeft, size: 22, color: Colors.white),
            const Gap(5),
            Text(
              "Detail Riwayat",
              style: context.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Image(image: status.imageProvider, height: 36, width: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIconAndDate(
    BuildContext context,
    MemberDetailRiwayatState state,
    TrxStatus status,
    String hariTanggal,
    String jam,
  ) {
    return Container(
      padding: paddingPage.copyWith(top: 2),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.card.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: context.primaryForeground, width: 1.5),
            ),
            child: Icon(
              status.icon,
              color: context.primaryForeground,
              size: 24,
            ),
          ),
          const Gap(10),
          Text(
            state.detailTransaksiStatus.isLoading
                ? "Memuat Transaksi ..."
                : "Transaksi ${status.text}",
            textAlign: TextAlign.center,
            style: context.sectionTitle.copyWith(
              fontWeight: FontWeight.w600,
              color: context.primaryForeground,
            ),
          ),
          Text(
            state.detailTransaksiStatus.isLoading
                ? ""
                : "$hariTanggal \u2022 $jam",
            textAlign: TextAlign.center,
            style: context.bodySmall
                .copyWith(color: context.primaryForeground)
                .withWeight(FontWeight.w400),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION: MAIN CONTENT (White Card)
  // ===========================================================================
  Widget _buildMainContent(BuildContext context) {
    return BlocBuilder<MemberDetailRiwayatProvider, MemberDetailRiwayatState>(
      buildWhen: (old, current) =>
          old.detailTransaksiStatus != current.detailTransaksiStatus ||
          old.detailTransaksi != current.detailTransaksi,
      builder: (context, state) {
        // Determine styling vars
        var color = context.isDarkMode ? neutral[800] : neutral[400];
        var status = TrxStatus.expired;
        if (state.detailTransaksiStatus.isSuccess) {
          color = state.detailTransaksi.statusTrx.bgColorTrx(context);
          status = state.detailTransaksi.statusTrx;
        }

        return Column(
          children: [
            const SizedBox(height: 180),
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
                child: Column(
                  children: [
                    _buildProductInfo(context, state),
                    Divider(height: 1, thickness: 0.7, color: color),
                    _buildScrollableDetails(context, state, color, status),
                  ],
                ),
              ),
            ),
            _buildActionButtons(
              context,
              status,
              state.detailTransaksi.tipeTrx,
              state,
            ),
            const Gap(6),
          ],
        );
      },
    );
  }

  Widget _buildProductInfo(
    BuildContext context,
    MemberDetailRiwayatState state,
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
    MemberDetailRiwayatState state,
    Color? dividerColor,
    TrxStatus status,
  ) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          // 1. List Detail Transaksi
          _buildSectionHeader(context, "Detail Transaksi"),
          if (state.detailTransaksiStatus.isLoading)
            _buildListShimmerDetailItem(context)
          else
            ..._buildDataList(state.dataSplit.dataTransaksi),

          // 2. List Biaya / Potong Stok
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: _buildSectionHeader(context, "Detail Potong Stok"),
          ),
          if (state.detailTransaksiStatus.isLoading)
            _buildListShimmerDetailItem(context)
          else
            ..._buildDataList(state.dataSplit.dataBiaya, isCurrency: true),

          // 3. Footer (Total & Warnings)
          _buildFooterSection(context, state, dividerColor, status),
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

    bool canCopy = keySalin.contains(keyLower);

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
          if (canCopy) ...[
            const Gap(4),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: item.value));
                showSuccessMessage("Berhasil menyalin ${item.key}");
              },
              child: Icon(
                MdiIcons.contentCopy,
                size: 16,
                color: context.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION: FOOTER (Total, Warning, Help)
  // ===========================================================================
  Widget _buildFooterSection(
    BuildContext context,
    MemberDetailRiwayatState state,
    Color? color,
    TrxStatus status,
  ) {
    if (state.detailTransaksiStatus.isLoading) {
      return _buildShimmerTotal(context);
    }

    return Column(
      children: [
        // Total Harga Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Total Potong Stok",
                  style: context.bodyMedium
                      .withWeight(FontWeight.w600)
                      .withColor(Colors.white),
                ),
              ),
              Text(
                state.detailTransaksi.totalHargaFormatted,
                style: context.bodyMedium
                    .withWeight(FontWeight.w800)
                    .withColor(Colors.white),
              ),
            ],
          ),
        ),

        // Warning Box if Failed
        if (status.isFailed)
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: double.infinity,
            padding: paddingCard,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: status.bgColor(context),
              border: Border.all(color: context.destructive, width: 1),
            ),
            child: Text(
              "Jika transaksi gagal, stok akan dikembalikan secara penuh (100%) secara otomatis. Silakan cek riwayat pengembalian pada menu Mutasi Stok.",
              style: context.bodySmall
                  .withColor(context.destructive)
                  .withWeight(FontWeight.w600),
            ),
          ),

        const Gap(6),
        CardTanya(
          onTap: () {},
          title: "Ada kendala dengan transaksi?",
          borderColor: context.primary,
        ),
      ],
    );
  }

  Widget _buildShimmerTotal(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Container(
              height: 16,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: ACTION BUTTONS (Share/Print)
  // ===========================================================================
  Widget _buildActionButtons(
    BuildContext context,
    TrxStatus status,
    TipeTrx tipeTrx,
    MemberDetailRiwayatState state,
  ) {
    if (state.detailTransaksiStatus.isLoading) {
      return Padding(
        padding: paddingPage.copyWith(bottom: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  height: 16,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: paddingPage.copyWith(bottom: 12, top: 5),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              padding: EdgeInsets.zero,
              height: 30,
              text: "Bagikan",
              onPressed: () {
                if (tipeTrx.isElektrik) {
                  getMemberCetakStrukElektrikProvider(context)
                    ..reloadKiosInfo()
                    ..setTotalBayar(state.detailTransaksi.totalharga.toString())
                    ..setDataTrx(
                      state.dataSplit.dataTransaksi ?? [],
                      ubahTemp: true,
                    )
                    ..setDetailTransaksi(state.detailTransaksi)
                    ..setDataBiaya(
                      state.dataSplit.dataBiaya ?? [],
                      ubahTemp: true,
                    );
                  pushNamed(BagikanElektrikPage.routeName);
                } else if (tipeTrx.isNominalBebas) {
                  getMemberCetakStrukNominalBebasProvider(context)
                    ..reloadKiosInfo()
                    ..setTotalBayar(
                      state.detailTransaksi.totalharga.toString(),
                    )
                    ..setDetailTransaksi(state.detailTransaksi)
                    ..setDataTrx(
                      state.dataSplit.dataTransaksi ?? [],
                      ubahTemp: true,
                    )
                    ..setDataBiaya(
                      state.dataSplit.dataBiaya ?? [],
                      ubahTemp: true,
                    );
                  pushNamed(BagikanNominalBebasPage.routeName);
                } else if (tipeTrx.isBayarTagihan) {
                  PilihPpobCetakDialog.show(
                    context,
                    onPPOB1: () {
                      getMemberCetakStrukPpob1Provider(context)
                        ..reloadKiosInfo()
                        ..setTotalPotongStok(state.detailTransaksi.totalharga)
                        ..setDetailTransaksi(state.detailTransaksi)
                        ..setDataTrx(
                          state.dataSplit.dataTransaksi ?? [],
                          ubahTemp: true,
                        )
                        ..setDataBiaya(
                          state.dataSplit.dataBiaya ?? [],
                          ubahTemp: true,
                        );

                      pushNamed(BagikanPpob1Page.routeName);
                    },
                    onPPOB2: () {
                      getMemberCetakStrukPpob2Provider(context)
                        ..reloadKiosInfo()
                        ..setTotalPotongStok(state.detailTransaksi.totalharga)
                        ..setDetailTransaksi(state.detailTransaksi)
                        ..setDataTrx(
                          state.dataSplit.dataTransaksi ?? [],
                          ubahTemp: true,
                        )
                        ..setDataBiaya(
                          state.dataSplit.dataBiaya ?? [],
                          ubahTemp: true,
                        );

                      pushNamed(BagikanPpob2Page.routeName);
                    },
                  );
                }
              },
              borderColor: context.primary,
              foregroundColor: context.primary,
              icon: LucideIcons.share2,
              variant: ButtonVariant.border,
            ),
          ),
          const Gap(6),
          if (status.isSuccess)
            Expanded(
              child: CustomButton(
                padding: EdgeInsets.zero,
                height: 30,
                text: "Cetak Struk",
                onPressed: () {
                  if (tipeTrx.isElektrik) {
                    getMemberCetakStrukElektrikProvider(context)
                      ..reloadKiosInfo()
                      ..setTotalBayar(
                        state.detailTransaksi.totalharga.toString(),
                      )
                      ..setDataTrx(
                        state.dataSplit.dataTransaksi ?? [],
                        ubahTemp: true,
                      )
                      ..setDataBiaya(
                        state.dataSplit.dataBiaya ?? [],
                        ubahTemp: true,
                      );
                    pushNamed(CetakStrukElektrikPage.routeName);
                  } else if (tipeTrx.isNominalBebas) {
                    getMemberCetakStrukNominalBebasProvider(context)
                      ..reloadKiosInfo()
                      ..setTotalBayar(
                        state.detailTransaksi.totalharga.toString(),
                      )
                      ..setDataTrx(
                        state.dataSplit.dataTransaksi ?? [],
                        ubahTemp: true,
                      )
                      ..setDataBiaya(
                        state.dataSplit.dataBiaya ?? [],
                        ubahTemp: true,
                      );
                    pushNamed(CetakStrukNominalBebasPage.routeName);
                  } else if (tipeTrx.isBayarTagihan) {
                    PilihPpobCetakDialog.show(
                      context,
                      onPPOB1: () {
                        getMemberCetakStrukPpob1Provider(context)
                          ..reloadKiosInfo()
                          ..setTotalPotongStok(state.detailTransaksi.totalharga)
                          ..setDataTrx(
                            state.dataSplit.dataTransaksi ?? [],
                            ubahTemp: true,
                          )
                          ..setDataBiaya(
                            state.dataSplit.dataBiaya ?? [],
                            ubahTemp: true,
                          );

                        pushNamed(MemberCetakStrukPpob1Page.routeName);
                      },
                      onPPOB2: () {
                        getMemberCetakStrukPpob2Provider(context)
                          ..reloadKiosInfo()
                          ..setTotalPotongStok(state.detailTransaksi.totalharga)
                          ..setDataTrx(
                            state.dataSplit.dataTransaksi ?? [],
                            ubahTemp: true,
                          )
                          ..setDataBiaya(
                            state.dataSplit.dataBiaya ?? [],
                            ubahTemp: true,
                          );

                        pushNamed(MemberCetakStrukPpob2Page.routeName);
                      },
                    );
                  }
                },
                icon: LucideIcons.printer,
              ),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION: SHIMMER HELPERS
  // ===========================================================================
  Widget _buildShimmerDetailItem(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: context.border, width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 16, width: 80, color: Colors.white),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Container(height: 16, width: 120, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListShimmerDetailItem(BuildContext context) {
    return Column(
      children: List.generate(5, (_) => _buildShimmerDetailItem(context)),
    );
  }


}
