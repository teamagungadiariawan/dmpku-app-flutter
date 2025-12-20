import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AturInfoKiosDialog extends StatefulWidget {
  final String namaKios;
  final String alamatKios;
  final String footerKios;
  final Function(String namaKios, String alamatKios, String footerKios) onSave;

  const AturInfoKiosDialog({
    Key? key,
    required this.namaKios,
    required this.alamatKios,
    required this.footerKios,
    required this.onSave,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required String namaKios,
    required String alamatKios,
    required String footerKios,
    required Function(String namaKios, String alamatKios, String footerKios)
        onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => AturInfoKiosDialog(
        namaKios: namaKios,
        alamatKios: alamatKios,
        footerKios: footerKios,
        onSave: onSave,
      ),
    );
  }

  @override
  _AturInfoKiosDialogState createState() => _AturInfoKiosDialogState();
}

class _AturInfoKiosDialogState extends State<AturInfoKiosDialog> {
  late TextEditingController _namaKiosController;
  late TextEditingController _alamatKiosController;
  late TextEditingController _footerKiosController;

  @override
  void initState() {
    super.initState();
    _namaKiosController = TextEditingController(text: widget.namaKios);
    _alamatKiosController = TextEditingController(text: widget.alamatKios);
    _footerKiosController = TextEditingController(text: widget.footerKios);
  }

  @override
  void dispose() {
    _namaKiosController.dispose();
    _alamatKiosController.dispose();
    _footerKiosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomInset),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            TopDividerSheet(),
            Gap(15),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: paddingCard,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? stone[700] : stone[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(MdiIcons.storeEdit, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Atur Info Kios',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Atur nama, alamat, dan footer kios Anda yang akan tercetak pada struk.',
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
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Nama Kios:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildNamaKiosField(),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Alamat Kios:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildAlamatKiosField(),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Footer Nota:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildFooterKiosField(),
            ),
            Gap(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomButton(
                height: 32,
                padding: EdgeInsets.zero,
                width: double.infinity,
                iconPosition: IconPosition.end,
                icon: LucideIcons.arrowRight,
                text: "Simpan Info Kios",
                onPressed: () {
                  SecureStorageHelper.instance.saveNamaKios(
                    _namaKiosController.text,
                  );
                  SecureStorageHelper.instance.saveAlamatKios(
                    _alamatKiosController.text,
                  );
                  SecureStorageHelper.instance.saveFooterKios(
                    _footerKiosController.text,
                  );

                  widget.onSave(
                    _namaKiosController.text,
                    _alamatKiosController.text,
                    _footerKiosController.text,
                  );

                  pop();
                },
              ),
            ),

            Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildNamaKiosField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(MdiIcons.store, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _namaKiosController,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : Kios ABC',
                suffixIcon: _namaKiosController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _updateController(_namaKiosController, "");
                        },
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlamatKiosField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(MdiIcons.mapMarker, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: SizedBox(
              height: 80,
              child: TextField(
                controller: _alamatKiosController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Contoh : Jl. Merdeka No.123, Jakarta',
                  suffixIcon: _alamatKiosController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            _updateController(_alamatKiosController, "");
                          },
                          child: Icon(
                            MdiIcons.close,
                            size: 18,
                            color: context.foreground,
                          ),
                        )
                      : null,
                ),
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterKiosField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(MdiIcons.textBox, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: SizedBox(
              height: 80,
              child: TextField(
                controller: _footerKiosController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Contoh : Terima Kasih Telah Berbelanja',
                  suffixIcon: _footerKiosController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            _updateController(_footerKiosController, "");
                          },
                          child: Icon(
                            MdiIcons.close,
                            size: 18,
                            color: context.foreground,
                          ),
                        )
                      : null,
                ),
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }
}
