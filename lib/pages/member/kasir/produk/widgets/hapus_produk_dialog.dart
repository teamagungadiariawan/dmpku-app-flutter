import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/produk/member_produk_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HapusProdukDialog extends StatefulWidget {
  final ProdukModel produkModel;

  const HapusProdukDialog({super.key, required this.produkModel});

  static void show(BuildContext context, {required ProdukModel produkModel}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MemberProdukProvider>(),
          child: HapusProdukDialog(produkModel: produkModel),
        );
      },
    );
  }

  @override
  State<HapusProdukDialog> createState() => _HapusProdukDialogState();
}

class _HapusProdukDialogState extends State<HapusProdukDialog> {
  void hapusProduk() {
    context.read<MemberProdukProvider>().hapusProduk(
      context,
      idProduk: widget.produkModel.idproduk,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberProdukProvider, MemberProdukState>(
      listenWhen: (prev, curr) =>
          prev.apiHapusProdukStatus != curr.apiHapusProdukStatus,
      listener: (context, state) {
        if (state.apiHapusProdukStatus == ApiStatus.success) {
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
                              'Hapus Produk',
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.destructive,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Produk ini akan dihapus permanen dari daftar produk Anda.',
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
              _buildProdukItem(context, widget.produkModel),
              const Gap(24),
              BlocBuilder<MemberProdukProvider, MemberProdukState>(
                buildWhen: (prev, curr) =>
                    prev.apiHapusProdukStatus != curr.apiHapusProdukStatus,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          text: 'Batal',
                          variant: ButtonVariant.outline,
                          onPressed: () => !state.apiHapusProdukStatus.isLoading
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
                          isLoading: state.apiHapusProdukStatus.isLoading,
                          onPressed: hapusProduk,
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

  Widget _buildProdukItem(BuildContext context, ProdukModel produk) {
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
                LucideIcons.package,
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
                    produk.namaproduk,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Text(
                        'Jual: ',
                        style: context.bodySmall.withColor(
                          context.mutedForeground,
                        ),
                      ),
                      Text(
                        ToCurrency(produk.hargajual.toString()),
                        style: context.bodySmall.withWeight(FontWeight.w600),
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
