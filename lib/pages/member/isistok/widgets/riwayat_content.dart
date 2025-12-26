import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/isistok/alfamart/detail_tiket_alfamart_page.dart';
import 'package:dmpku/pages/member/isistok/indomaret/detail_tiket_indomaret_page.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/isistok/qris/detail_tiket_qris_page.dart';
import 'package:dmpku/pages/member/isistok/va/detail_tiket_va_page.dart';
import 'package:dmpku/pages/member/isistok/widgets/riwayat_filter_tabs.dart';
import 'package:dmpku/pages/member/isistok/widgets/riwayat_list_bank_transfer.dart';
import 'package:dmpku/pages/member/isistok/widgets/riwayat_list_bank_transfer_shimmer.dart';
import 'package:dmpku/pages/member/isistok/widgets/riwayat_list_placeholder.dart';
import 'package:dmpku/widgets/custom_local_image.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RiwayatContent extends StatefulWidget {
  const RiwayatContent({super.key});

  @override
  State<RiwayatContent> createState() => _RiwayatContentState();
}

class _RiwayatContentState extends State<RiwayatContent> {
  int _historyTabIndex = 0;
  late PageController _historyPageController;

  final List<String> _historyCategories = [
    'Bank Transfer',
    'Alfamart',
    'Indomaret',
    'Virtual Account',
    'QRIS',
  ];

  @override
  void initState() {
    super.initState();
    _historyPageController = PageController();
  }

  @override
  void dispose() {
    _historyPageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _historyTabIndex = index;
    });

    final provider = context.read<MemberIsiStokProvider>();
    switch (index) {
      case 0:
        provider.fetchRiwayatTiketBankTransfer();
        break;
      case 1:
        provider.fetchRiwayatTiketAlfamart();
        break;
      case 2:
        provider.fetchRiwayatTiketIndomaret();
        break;
      case 3:
        provider.fetchRiwayatTiketVa();
        break;
      case 4:
        provider.fetchRiwayatTiketQris();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RiwayatFilterTabs(
          selectedIndex: _historyTabIndex,
          categories: _historyCategories,
          onTabSelected: (index) {
            _historyPageController.jumpToPage(index);
          },
        ),
        Expanded(
          child: PageView.builder(
            controller: _historyPageController,
            onPageChanged: _onPageChanged,
            itemCount: _historyCategories.length,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return const RiwayatListBankTransfer();
                case 1:
                  return const RiwayatListAlfamart();
                case 2:
                  return const RiwayatListIndomaret();
                case 3:
                  return const RiwayatListVa();
                case 4:
                  return const RiwayatListQris();
                default:
                  return RiwayatListPlaceholder(
                    categoryName: _historyCategories[index],
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}

class RiwayatListAlfamart extends StatelessWidget {
  const RiwayatListAlfamart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      builder: (context, state) {
        if (state.apiRiwayatAlfamartStatus.isLoading) {
          return const RiwayatListBankTransferShimmer();
        }

        return RefreshableList(
          padding: paddingPage.copyWith(bottom: 29),
          onRefresh: () async {
            getMemberIsiStokProvider(context).fetchRiwayatTiketAlfamart();
          },
          items: state.listRiwayatAlfamart,
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
                  ).setSelectedRiwayatAlfamart(tiket);
                  pushNamed(DetailTiketAlfamartPage.routeName);
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
                            child: CustomLocalImage(
                              size: 25,
                              imagePath: Assets.img.bank.icMethodAlfamart.path,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tiket.nama,
                                  style: context.bodyMedium.withWeight(
                                    FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  "${DateHelper.formatFullDate(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}, ${DateHelper.formatTime(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}",
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
                          Text("Total Bayar", style: context.bodyMedium),
                          const Spacer(),
                          Text(
                            ToRupiah(tiket.totalbayar.toString()),
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

class RiwayatListIndomaret extends StatelessWidget {
  const RiwayatListIndomaret({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      builder: (context, state) {
        if (state.apiRiwayatIndomaretStatus.isLoading) {
          return const RiwayatListBankTransferShimmer();
        }

        return RefreshableList(
          padding: paddingPage.copyWith(bottom: 29),
          onRefresh: () async {
            getMemberIsiStokProvider(context).fetchRiwayatTiketIndomaret();
          },
          items: state.listRiwayatIndomaret,
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
                  ).setSelectedRiwayatIndomaret(tiket);
                  pushNamed(DetailTiketIndomaretPage.routeName);
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
                            child: CustomLocalImage(
                              size: 25,
                              imagePath: Assets.img.bank.icMethodIndomaret.path,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tiket.nama,
                                  style: context.bodyMedium.withWeight(
                                    FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  "${DateHelper.formatFullDate(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}, ${DateHelper.formatTime(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}",
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
                          Text("Total Bayar", style: context.bodyMedium),
                          const Spacer(),
                          Text(
                            ToRupiah(tiket.totalbayar.toString()),
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

class RiwayatListVa extends StatelessWidget {
  const RiwayatListVa({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      builder: (context, state) {
        if (state.apiRiwayatVaStatus.isLoading) {
          return const RiwayatListBankTransferShimmer();
        }

        return RefreshableList(
          padding: paddingPage.copyWith(bottom: 29),
          onRefresh: () async {
            getMemberIsiStokProvider(context).fetchRiwayatTiketVa();
          },
          items: state.listRiwayatVa,
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
                  getMemberIsiStokProvider(context).setSelectedRiwayatVa(tiket);
                  pushNamed(DetailTiketVaPage.routeName);
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
                                  tiket.nama,
                                  style: context.bodyMedium.withWeight(
                                    FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  "${DateHelper.formatFullDate(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}, ${DateHelper.formatTime(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}",
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
                          Text("Total Bayar", style: context.bodyMedium),
                          const Spacer(),
                          Text(
                            ToRupiah(tiket.totalbayar.toString()),
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

class RiwayatListQris extends StatelessWidget {
  const RiwayatListQris({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      builder: (context, state) {
        if (state.apiRiwayatQrisStatus.isLoading) {
          return const RiwayatListBankTransferShimmer();
        }

        return RefreshableList(
          padding: paddingPage.copyWith(bottom: 29),
          onRefresh: () async {
            getMemberIsiStokProvider(context).fetchRiwayatTiketQris();
          },
          items: state.listRiwayatQris,
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
                  ).setSelectedRiwayatQris(tiket);
                  pushNamed(DetailTiketQrisPage.routeName);
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
                            child: CustomLocalImage(
                              size: 25,
                              imagePath: Assets.img.bank.icMethodQris.path,
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
                                  "${DateHelper.formatFullDate(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}, ${DateHelper.formatTime(DateHelper.tryParse(tiket.waktu) ?? DateTime.now())}",
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
                          Text("Total Bayar", style: context.bodyMedium),
                          const Spacer(),
                          Text(
                            ToRupiah(tiket.totalbayar.toString()),
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
