import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/catatan_response.dart';
import 'package:dmpku/pages/member/kasir/member_catatan_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class HapusCatatanDialog extends StatefulWidget {
  final CatatanModel item;

  const HapusCatatanDialog({super.key, required this.item});

  static Future<void> show(BuildContext context, CatatanModel item) {
    var provider = context.read<MemberCatatanProvider>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      builder: (_) {
        return BlocProvider.value(
          value: provider,
          child: HapusCatatanDialog(item: item),
        );
      },
    );
  }

  @override
  State<HapusCatatanDialog> createState() => _HapusCatatanDialogState();
}

class _HapusCatatanDialogState extends State<HapusCatatanDialog> {
  void hapusCatatan() async {
    var suc = await getMemberCatatanProvider(
      context,
    ).deleteCatatan(context, idcatatan: widget.item.idcatatan);

    if (suc) {
      pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              color: context.destructive.withOpacity(0.3),
              child: Padding(
                padding: paddingCard,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? stone[700] : stone[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(MdiIcons.notebookRemove, size: 16),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hapus Catatan',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Catatan ini akan dihapus permanen.',
                            style: context.captionRegular.withColor(
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
            const Gap(10),
            _buildCatatanItem(context, widget.item),
            const Gap(15),
            BlocBuilder<MemberCatatanProvider, MemberCatatanState>(
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 30,
                        padding: EdgeInsets.zero,
                        variant: ButtonVariant.border,
                        borderColor: context.primary,
                        foregroundColor: context.primary,
                        text: "Batal",
                        onPressed: () {
                          if (!state.apiHapusCatatanStatus.isLoading) pop();
                        },
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: CustomButton(
                        height: 30,
                        padding: EdgeInsets.zero,
                        variant: ButtonVariant.destructive,
                        text: "Hapus Catatan",
                        isLoading: state.apiHapusCatatanStatus.isLoading,
                        onPressed: () {
                          hapusCatatan();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildCatatanItem(BuildContext context, CatatanModel item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.border, width: 0.7),
      ),
      child: Padding(
        padding: paddingCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: context.muted,
                shape: BoxShape.circle,
              ),
              child: Icon(
                MdiIcons.notebook,
                size: 18,
                color: context.mutedForeground,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.judul,
                    style: context.bodySmall.withWeight(FontWeight.w500),
                  ),
                  const Gap(2),
                  Text(
                    item.isicatatan,
                    style: context.bodySmall.withColor(context.mutedForeground),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
