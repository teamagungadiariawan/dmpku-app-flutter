import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/detail_tiket_bank_transfer_page.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/isistok/widgets/riwayat_list_bank_transfer_shimmer.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RiwayatListBankTransfer extends StatelessWidget {
  const RiwayatListBankTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      buildWhen: (previous, current) =>
          previous.listRiwayatTiketBank != current.listRiwayatTiketBank ||
          previous.apiRiwayatTiketBankStatus !=
              current.apiRiwayatTiketBankStatus,
      builder: (context, state) {
        if (state.apiRiwayatTiketBankStatus.isLoading) {
          return const RiwayatListBankTransferShimmer();
        }

        return RefreshableList(
          padding: paddingPage.copyWith(bottom: 29),
          onRefresh: () async {
            getMemberIsiStokProvider(context).fetchRiwayatTiketBankTransfer();
          },
          items: state.listRiwayatTiketBank,
          itemBuilder: (context, tiket, index) {
            var statusColor = context.warning;
            var textColor = context.warningForeground;
            var statusText = "Pending";
            if (tiket.status == 1) {
              statusText = "Sukses";
              statusColor = context.success;
              textColor = context.successForeground;
            } else if (tiket.status == 0) {
              statusText = "Pending";
              statusColor = context.warning;
              textColor = context.warningForeground;
            } else {
              statusText = "Expired";
              statusColor = context.destructive;
              textColor = context.destructiveForeground;
            }

            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  getMemberIsiStokProvider(
                    context,
                  ).setSelectedRiwayatTiket(tiket);
                  pushNamed(DetailTiketBankTransferPage.routeName);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: paddingCard,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: context.border),
                              color: context.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNetworkImage(
                              size: 25,
                              url: tiket.icon,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tiket.namaakun,
                                  style: context.bodyMedium.withWeight(
                                    FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  "${DateHelper.formatFullDate(DateHelper.tryParse(tiket.waktureq) ?? DateTime.now())}, ${DateHelper.formatTime(DateHelper.tryParse(tiket.waktureq) ?? DateTime.now())}",
                                  style: context.bodySmall.withColor(
                                    context.mutedForeground,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              statusText,
                              style: context.captionRegular
                                  .withColor(textColor)
                                  .withWeight(FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: context.border),
                    Padding(
                      padding: paddingCard,
                      child: Row(
                        children: [
                          Text("Nominal Transfer", style: context.bodyMedium),
                          const Spacer(),
                          Text(
                            ToRupiah(
                              tiket.jumlahnominalantriantiket.toString(),
                            ),
                            style: context.bodyMedium.withWeight(
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
