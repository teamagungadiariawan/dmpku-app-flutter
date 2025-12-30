import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/pages/member/kasir/widgets/card_history_kasir.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class SukseskanDialog extends StatefulWidget {
  final PenjualanModel penjualanModel;

  const SukseskanDialog({super.key, required this.penjualanModel});

  static void show(
    BuildContext context, {
    required PenjualanModel penjualanModel,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<KasirProvider>(),
          child: SukseskanDialog(penjualanModel: penjualanModel),
        );
      },
    );
  }

  @override
  State<SukseskanDialog> createState() => _SukseskanDialogState();
}

class _SukseskanDialogState extends State<SukseskanDialog> {
  void sukseskanTransaksi() {
    context.read<KasirProvider>().sukseskanTransaction(
      idPenjualan: widget.penjualanModel.idpenjualan,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KasirProvider, KasirState>(
      listenWhen: (prev, curr) =>
          prev.apiSukseskanStatus != curr.apiSukseskanStatus,
      listener: (context, state) {
        if (state.apiSukseskanStatus == ApiStatus.success) {
          pop();
        }
      },
      child: SafeArea(
        child: Container(
          padding: paddingPage,
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: context.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const TopDividerSheet(),
              const Gap(15),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: context.success, width: 1),
                ),
                color: context.success.withValues(alpha: 0.1),
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.background,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          MdiIcons.checkCircleOutline,
                          size: 20,
                          color: context.success,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sukseskan Transaksi',
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.success,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Status transaksi akan diubah menjadi sukses.',
                              style: context.bodySmall.withColor(
                                context.foreground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(16),
              _buildTransaskiItem(context, widget.penjualanModel),
              const Gap(24),
              BlocBuilder<KasirProvider, KasirState>(
                buildWhen: (prev, curr) =>
                    prev.apiSukseskanStatus != curr.apiSukseskanStatus,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          text: 'Batal',
                          variant: ButtonVariant.outline,
                          onPressed: () => !state.apiSukseskanStatus.isLoading
                              ? pop()
                              : null,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          text: 'Sukseskan',
                          // Custom success color variant if available, or just primary/default
                          // Usually 'primary' is fine, or hardcode color if needed to match success
                          variant: ButtonVariant.primary,
                          backgroundColor: context.success,
                          isLoading: state.apiSukseskanStatus.isLoading,
                          onPressed: sukseskanTransaksi,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransaskiItem(BuildContext context, PenjualanModel item) {
    // Reuse status logic implicitly or duplicate if fine
    String statusText = 'Pending';
    Color statusColor = Colors.orange;
    IconData statusIcon = Icons.more_horiz;

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

    return CardHistoryKasir(
      title: item.namaproduk,
      subtitle:
          (item.namapelanggan.isNotEmpty ? item.namapelanggan : 'Umum') +
          ' • ' +
          item.nohppelanggan,
      amount: ToCurrency(item.jumlahbayar.toString()),
      time: jam,
      status: statusText,
      statusColor: statusColor,
      statusIcon: statusIcon,
      invCode: "#TRX-${item.idpenjualan}",
      itemCount: item.jumlahproduk,
    );
  }
}
