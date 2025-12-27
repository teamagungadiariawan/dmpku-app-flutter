import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/kasir/catatan/member_catatan_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TambahCatatanDialog extends StatefulWidget {
  const TambahCatatanDialog({super.key});

  static void show(BuildContext context) {
    var provider = context.read<MemberCatatanProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: provider,
          child: const TambahCatatanDialog(),
        );
      },
    );
  }

  @override
  State<TambahCatatanDialog> createState() => _TambahCatatanDialogState();
}

class _TambahCatatanDialogState extends State<TambahCatatanDialog> {
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();
  bool _isPinned = false;

  final shakeKeyJudul = GlobalKey<ShakeWidgetState>();
  final shakeKeyIsi = GlobalKey<ShakeWidgetState>();

  String errorJudul = '';
  String errorIsi = '';

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  bool validate() {
    bool isValid = true;
    setState(() {
      errorJudul = '';
      errorIsi = '';

      if (_judulController.text.trim().isEmpty) {
        errorJudul = 'Judul tidak boleh kosong';
        isValid = false;
      }
      if (_isiController.text.trim().isEmpty) {
        errorIsi = 'Isi catatan tidak boleh kosong';
        isValid = false;
      }
    });

    if (!isValid) {
      if (errorJudul.isNotEmpty) shakeKeyJudul.currentState?.shake();
      if (errorIsi.isNotEmpty) shakeKeyIsi.currentState?.shake();
    }
    return isValid;
  }

  void _submit() {
    if (validate()) {
      getMemberCatatanProvider(context)
          .tambahCatatan(
            context,
            judul: _judulController.text.trim(),
            isicatatan: _isiController.text.trim(),
            perioritas: _isPinned ? 1 : 0,
          )
          .then((success) {
            if (success) {
              pop();
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomInset),
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
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      child: const Icon(MdiIcons.notebookPlus, size: 16),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tambah Catatan',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Tambahkan catatan baru Anda di sini.',
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
            const Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Judul Catatan",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildTextField(
                controller: _judulController,
                hintText: 'Contoh: Daftar Belanja',
                shakeKey: shakeKeyJudul,
                errorText: errorJudul,
                icon: MdiIcons.formatTitle,
              ),
            ),
            const Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Isi Catatan",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildTextField(
                controller: _isiController,
                hintText: 'Tulis catatan Anda...',
                shakeKey: shakeKeyIsi,
                errorText: errorIsi,
                icon: MdiIcons.text,
                maxLines: 4,
              ),
            ),
            const Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isPinned = !_isPinned;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    IgnorePointer(
                      child: Checkbox(
                        value: _isPinned,
                        activeColor: context.primary,
                        onChanged: (val) {},
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Sematkan Catatan (Prioritas)',
                      style: context.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
            BlocBuilder<MemberCatatanProvider, MemberCatatanState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomButton(
                    height: 32,
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    iconPosition: IconPosition.end,
                    icon: LucideIcons.arrowRight,
                    isLoading: state.apiTambahCatatanStatus.isLoading,
                    text: "Simpan Catatan",
                    onPressed: _submit,
                  ),
                );
              },
            ),
            const Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required GlobalKey<ShakeWidgetState> shakeKey,
    required String errorText,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(
              color: errorText.isEmpty ? context.border : context.destructive,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            crossAxisAlignment: maxLines > 1
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: maxLines > 1 ? 8 : 0),
                child: Icon(icon, size: 18, color: context.foreground),
              ),
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: hintText,
                    border: InputBorder.none,
                    suffixIcon: (controller.text.isNotEmpty && maxLines == 1)
                        ? InkWell(
                            onTap: () {
                              controller.clear();
                              setState(() {});
                            },
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: context.foreground,
                            ),
                          )
                        : null,
                  ),
                  textInputAction: maxLines > 1
                      ? TextInputAction.newline
                      : TextInputAction.done,
                ),
              ),
            ],
          ),
        ).withShake(key: shakeKey),
        if (errorText.isNotEmpty) ...[
          const Gap(4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorText,
              style: context.captionRegular.withColor(context.destructive),
            ),
          ),
        ],
      ],
    );
  }
}
