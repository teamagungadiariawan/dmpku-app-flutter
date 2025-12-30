import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';

import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/member_pelanggan_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HapusPelangganDialog extends StatefulWidget {
  final PelangganModel pelangganModel;

  const HapusPelangganDialog({super.key, required this.pelangganModel});

  static void show(
    BuildContext context, {
    required PelangganModel pelangganModel,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MemberPelangganProvider>(),
          child: HapusPelangganDialog(pelangganModel: pelangganModel),
        );
      },
    );
  }

  @override
  State<HapusPelangganDialog> createState() => _HapusPelangganDialogState();
}

class _HapusPelangganDialogState extends State<HapusPelangganDialog> {
  void hapusPelanggan() {
    context.read<MemberPelangganProvider>().hapusPelanggan(
      context,
      idPelanggan: widget.pelangganModel.idpelanggan,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberPelangganProvider, MemberPelangganState>(
      listenWhen: (prev, curr) =>
          prev.apiHapusPelangganStatus != curr.apiHapusPelangganStatus,
      listener: (context, state) {
        if (state.apiHapusPelangganStatus == ApiStatus.success) {
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
                  side: BorderSide(color: context.destructive, width: 1),
                ),
                color: context.destructive.withValues(alpha: 0.1),
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
                          MdiIcons.deleteAlert,
                          size: 20,
                          color: context.destructive,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hapus Pelanggan',
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.destructive,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Pelanggan ini akan dihapus permanen dari daftar pelanggan Anda.',
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
              _buildPelangganItem(context, widget.pelangganModel),
              const Gap(24),
              BlocBuilder<MemberPelangganProvider, MemberPelangganState>(
                buildWhen: (prev, curr) =>
                    prev.apiHapusPelangganStatus !=
                    curr.apiHapusPelangganStatus,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          text: 'Batal',
                          variant: ButtonVariant.outline,
                          onPressed: () =>
                              !state.apiHapusPelangganStatus.isLoading
                              ? pop()
                              : null,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          text: 'Hapus',
                          variant: ButtonVariant.destructive,
                          isLoading: state.apiHapusPelangganStatus.isLoading,
                          onPressed: hapusPelanggan,
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

  Widget _buildPelangganItem(BuildContext context, PelangganModel pelanggan) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                LucideIcons.user,
                size: 20,
                color: context.foreground,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelanggan.namapelanggan,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.phone,
                        size: 14,
                        color: context.mutedForeground,
                      ),
                      const Gap(4),
                      Text(
                        pelanggan.nohppelanggan,
                        style: context.bodySmall.withColor(
                          context.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
