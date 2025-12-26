import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/mutasi_deposit_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/isistok/widgets/card_mutasi_deposit_shimmer.dart';
import 'package:dmpku/pages/member/isistok/widgets/filter_mutasi_stok_dialog.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_local_image.dart';
import 'package:dmpku/widgets/produk/grouped_refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MemberMutasiIsiStokPage extends StatefulWidget {
  static const String routeName = '/member/mutasi-isi-stok';

  const MemberMutasiIsiStokPage({super.key});

  @override
  State<MemberMutasiIsiStokPage> createState() =>
      _MemberMutasiIsiStokPageState();
}

class _MemberMutasiIsiStokPageState extends State<MemberMutasiIsiStokPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMemberIsiStokProvider(context).refreshMutasiDeposit();
    });
  }

  void closePage() {
    getMemberIsiStokProvider(context).clearMutasiDeposit();
    pop();
  }

  @override
  void dispose() {
    getMemberIsiStokProvider(context).clearMutasiDeposit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("WillPopScope: onWillPop");
        closePage();
        return true; // true = izinkan pop
      },
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(title: "Riwayat Stok"),
            _buildFilterBar(context),
            Expanded(
              child: BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
                builder: (context, state) {
                  return GroupedRefreshableList<
                    GroupedMutasiDepositModel,
                    MutasiDepositModel
                  >(
                    isLoading:
                        state.apiMutasiStatus.isLoading &&
                        state.pageMutasi == 1,
                    loadingWidget: const CardMutasiDepositListShimmer(
                      itemCount: 6,
                      itemMargin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                    ),
                    onRefresh: () async {
                      getMemberIsiStokProvider(context).refreshMutasiDeposit();
                    },
                    groups: state.listMutasiDepositGrouped.groupedMutasiList,
                    getItems: (group) => group.mutasiList,
                    groupHeaderBuilder: (context, group) {
                      DateTime? date;
                      try {
                        date = DateTime.parse(group.tanggal);
                      } catch (_) {}

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: context.isDarkMode ? stone[800] : stone[100],
                        child: Text(
                          date != null
                              ? DateHelper.formatFullDate(date)
                              : group.tanggal,
                          style: context.bodySmall.withWeight(FontWeight.w600),
                        ),
                      );
                    },
                    itemBuilder: (context, item, index) {
                      return _buildMutasiItem(context, item);
                    },
                    // Pagination
                    canLoadMore: state.hasMoreMutasi,
                    onLoadMore: () {
                      getMemberIsiStokProvider(context).nextPageMutasiDeposit();
                    },
                    isLoadingMore:
                        state.apiMutasiStatus.isLoading && state.pageMutasi > 1,

                    // Empty State
                    emptyTitle: "Belum ada riwayat",
                    emptySubtitle: "Riwayat mutasi stok akan muncul di sini",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      builder: (context, state) {
        final start = state.dateStartFilter ?? DateTime.now();
        final end = state.dateEndFilter ?? DateTime.now();

        // Format dates
        final startStr = DateHelper.formatSimpleDate(start);
        final endStr = DateHelper.formatSimpleDate(end);
        final dateDisplay = (startStr == endStr)
            ? startStr
            : "$startStr - $endStr";

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: context.card,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Periode",
                    style: context.captionRegular.withWeight(FontWeight.w600),
                  ),
                  const Gap(2),
                  Text(dateDisplay, style: context.bodySmall),
                ],
              ),
              Row(
                children: [
                  CustomButton(
                    height: 30,
                    text: "Filter",
                    icon: MdiIcons.filter,
                    onPressed: () {
                      FilterMutasiStokDialog.show(
                        context,
                        startDate: state.dateStartFilter,
                        endDate: state.dateEndFilter,
                      );
                    },
                    variant: ButtonVariant.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: context.captionRegular
                        .withColor(context.primaryForeground)
                        .withWeight(FontWeight.w600),
                  ),
                  const Gap(8),
                  CustomButton(
                    height: 30,
                    text: "Refresh",
                    icon: MdiIcons.refresh,
                    onPressed: () {
                      getMemberIsiStokProvider(context).refreshMutasiDeposit();
                    },
                    variant: ButtonVariant.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: context.captionRegular
                        .withColor(context.primaryForeground)
                        .withWeight(FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMutasiItem(BuildContext context, MutasiDepositModel item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.border),
            ),
            child: CustomLocalImage(
              imagePath: Assets.img.stok.icSaldoTf.path,
              size: 32,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateHelper.formatTime(
                    DateHelper.tryParse(item.waktu_mutasi) ?? DateTime.now(),
                  ),
                  style: context.captionRegular.withColor(
                    context.mutedForeground,
                  ),
                ),
                const Gap(4),
                Text(
                  item.keterangan
                      .replaceAll("Saldo", "Stok")
                      .replaceAll("saldo", "stok"),
                  style: context.bodySmall.withWeight(FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+${ToRupiah(item.mutasi.toString())}",
                style: context.bodySmall
                    .withColor(context.primary)
                    .withWeight(FontWeight.w600),
              ),
              Text(
                "Stok : ${ToRupiah(item.saldo.toString())}",
                style: context.captionRegular.withColor(context.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
