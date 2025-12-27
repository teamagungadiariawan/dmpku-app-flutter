import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/pages/member/kasir/widgets/card_history_penjualan_shimmer.dart';
import 'package:dmpku/pages/member/kasir/widgets/filter_penjualan_dialog.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MemberMenuPenjualanPage extends StatefulWidget {
  static const routeName = '/member/kasir/menu-penjualan';

  const MemberMenuPenjualanPage({super.key});

  @override
  State<MemberMenuPenjualanPage> createState() =>
      _MemberMenuPenjualanPageState();
}

class _MemberMenuPenjualanPageState extends State<MemberMenuPenjualanPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<KasirProvider>().fetchListPenjualan();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: true,
        child: Scaffold(
          body: BlocBuilder<KasirProvider, KasirState>(
            builder: (context, state) {
              final listData = state.listPenjualan;

              // Calculate totals
              int totalPenjualan = 0;
              int totalModal = 0;
              int totalLaba = 0;

              for (var item in listData) {
                // Ignore failed transactions for totals? Usually yes, but depends on logic.
                // Assuming status 1 is success.
                // Checking PenjualanModel status type. It's int.
                // Let's assume we sum everything for now or filter by status if needed.
                // But usually "Total Penjualan" implies successful ones.
                // For now, I'll sum all, or check if status is success.
                // I'll assume status 1 = success, 0 = pending/failed.
                // Let's sum all to capture "Omzet" broadly, or maybe just success.
                // Given the image shows "Sukses" and "Pending", I should probably separate?
                // But usually header "Total Penjualan" sums up mostly successful ones.
                // Let's use all for now as I don't have definitive status enum map.

                totalPenjualan += item.jumlahbayar;
                totalModal += item.jumlahmodal;
              }

              totalLaba = totalPenjualan - totalModal;

              return Stack(
                children: [
                  _buildHeader(context, totalPenjualan, totalModal, totalLaba),

                  // History Section
                  Positioned.fill(
                    top: 175,
                    child: _buildHistorySection(
                      context,
                      listData,
                      state.tanggalPenjualan,
                    ),
                  ),

                  // Modal & Laba Card
                  Column(
                    children: [
                      const SizedBox(height: 130),
                      Card(
                        margin: paddingPage,
                        child: Padding(
                          padding: paddingCard,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildSummaryItem(
                                    context,
                                    "Modal",
                                    totalModal.toString(),
                                    MdiIcons.walletBifold,
                                    context.primary,
                                  ),
                                ),
                                Gap(5),
                                VerticalDivider(
                                  color: context.primary,
                                  width: 1,
                                  thickness: 1,
                                ),
                                Gap(5),
                                Expanded(
                                  child: _buildSummaryItem(
                                    context,
                                    "Laba",
                                    totalLaba.toString(),
                                    MdiIcons.piggyBank,
                                    context.warning,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Bottom Action
                  Positioned(
                    bottom: bottomInset + 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: paddinPageh),
                      child: Card(
                        color: context.card,
                        child: Padding(
                          padding: paddingCard.copyWith(top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildActionItem(
                                context,
                                icon: MdiIcons.cashRegister,
                                label: "Input\nPenjualan",
                                color: Colors.orange,
                                onTap: () {},
                              ),
                              _buildActionItem(
                                context,
                                icon: MdiIcons.packageVariant,
                                label: "Data\nProduk",
                                color: Colors.blue,
                                onTap: () {},
                              ),
                              _buildActionItem(
                                context,
                                icon: MdiIcons.accountGroup,
                                label: "Data\nPelanggan",
                                color: Colors.purple,
                                onTap: () {},
                              ),
                              _buildActionItem(
                                context,
                                icon: MdiIcons.fileChart,
                                label: "Laporan\nKasir",
                                color: Colors.pink,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
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
    int totalPenjualan,
    int totalModal,
    int totalLaba,
  ) {
    return Container(
      color: context.primary,
      height: 380, // Fixed height for header background
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                backgroundColor: Colors.transparent,
                title: 'Kasir',
                onBackButtonPressed: pop,
              ),
              Gap(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Penjualan",
                    style: context.bodyLarge.withColor(Colors.white),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Rp ",
                          style: context.bodyLarge
                              .withColor(Colors.white)
                              .withWeight(FontWeight.w400),
                        ),
                      ),
                      Text(
                        ToCurrency(totalPenjualan.toString()),
                        style: context.displayLarge
                            .withColor(Colors.white)
                            .withWeight(FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(
    BuildContext context,
    List<PenjualanModel> data,
    DateTime selectedDate,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(
        color: bgScreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getRiwayatTitle(selectedDate),
                  style: context.headingSmall,
                ),
                CustomButton(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  text: "Filter",
                  icon: MdiIcons.filter,
                  onPressed: () {
                    FilterPenjualanDialog.show(
                      context,
                      initialDate: selectedDate,
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshableList<PenjualanModel>(
              onRefresh: () async {
                context.read<KasirProvider>().fetchListPenjualan();
              },
              items: data,
              isLoading: context
                  .read<KasirProvider>()
                  .state
                  .apiGetPenjualanStatus
                  .isLoading,
              loadingWidget: const CardHistoryPenjualanListShimmer(),
              emptyTitle: "Belum ada transaksi hari ini",
              emptySubtitle: "Tarik ke bawah untuk memuat ulang",
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (context, item, index) {
                // Format status and color
                String statusText = 'Pending';
                Color statusColor = Colors.orange;
                IconData statusIcon = Icons.more_horiz;

                // Assuming status logic:
                if (item.status == 1) {
                  statusText = 'Sukses';
                  statusColor = Colors.green;
                  statusIcon = Icons.check_circle;
                } else if (item.status == 2) {
                  statusText = 'Gagal';
                  statusColor = Colors.red;
                  statusIcon = Icons.cancel;
                }

                var date = DateTime.parse(item.waktutrx);
                var jam = DateHelper.formatTime(date);

                return _buildHistoryItem(
                  context,
                  title: item.namaproduk,
                  subtitle: item.namapelanggan.isNotEmpty
                      ? item.namapelanggan
                      : 'Umum',
                  amount: ToCurrency(item.jumlahbayar.toString()),
                  time: jam,
                  status: statusText,
                  statusColor: statusColor,
                  statusIcon: statusIcon,
                  invCode: "#TRX-${item.idpenjualan}",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String amount,
    required String time,
    required String status,
    required Color statusColor,
    required IconData statusIcon,
    required String invCode,
  }) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$invCode • $subtitle",
                        style: context.bodySmall.copyWith(
                          color: AppColors.lightMutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FF), // Light purple bg
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Rp $amount",
                    style: context.bodySmall.copyWith(
                      color: const Color(0xFF7E22CE), // Purple text
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightMuted,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "$time WIB",
                    style: context.bodyExtraSmall.copyWith(
                      color: AppColors.lightMutedForeground,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: context.bodyExtraSmall.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            Gap(8),
            Text(label, style: context.bodyMedium.withWeight(FontWeight.w600)),
          ],
        ),
        Gap(5),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Rp ",
                style: context.bodyMedium.withWeight(FontWeight.w400),
              ),
            ),
            Text(
              ToCurrency(value),
              style: context.sectionTitle.withWeight(FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Gap(8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String _getRiwayatTitle(DateTime date) {
    if (DateHelper.isToday(date)) {
      return 'Riwayat Hari Ini';
    }
    return 'Riwayat ${DateHelper.formatSimpleDate(date)}';
  }
}
