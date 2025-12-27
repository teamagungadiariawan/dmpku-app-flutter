import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_cetak_struk_nominal_bebas_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AturHargaNominalBebasDialog extends StatefulWidget {
  static const routeName =
      '/member/riwayat/cetak_struk_nominal_bebas/atur_harga_nominal_bebas_dialog';

  final int initialHarga;
  final int initialAdmin;

  const AturHargaNominalBebasDialog({
    super.key,
    required this.initialHarga,
    required this.initialAdmin,
  });

  static Future<void> show(
    BuildContext context, {
    required int initialHarga,
    required int initialAdmin,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (context) => AturHargaNominalBebasDialog(
        initialHarga: initialHarga,
        initialAdmin: initialAdmin,
      ),
    );
  }

  @override
  State<AturHargaNominalBebasDialog> createState() =>
      _AturHargaNominalBebasDialogState();
}

class _AturHargaNominalBebasDialogState extends State<AturHargaNominalBebasDialog> {
  late TextEditingController _hargaController;
  late TextEditingController _adminController;

  @override
  void initState() {
    super.initState();

    var curHarga = ToCurrency(widget.initialHarga.toString());
    var curAdmin = ToCurrency(widget.initialAdmin.toString());

    _hargaController = TextEditingController(text: curHarga);
    _adminController = TextEditingController(text: curAdmin);
  }

  @override
  void dispose() {
    _hargaController.dispose();
    _adminController.dispose();
    super.dispose();
  }

  bool validateAturHarga() {
    if (_hargaController.text.isEmpty) {
      showWarningMessage("Harga tidak boleh kosong");
      return false;
    }

    if (_adminController.text.isEmpty) {
      showWarningMessage("Biaya admin tidak boleh kosong");
      return false;
    }

    return true;
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
                      child: Icon(MdiIcons.cashEdit, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Atur Harga',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Atur harga dan biaya admin untuk cetak struk.',
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Harga",
                    style: context.bodyMedium.withWeight(FontWeight.w500),
                  ),
                  Spacer(),
                  BlocBuilder<
                    MemberCetakStrukNominalBebasProvider,
                    MemberCetakStrukNominalBebasState
                  >(
                    builder: (context, state) {
                      return CustomButton(
                        text: "Reset",
                        onPressed: () {

                          debugPrint("Harga Temp: ${state.hargaTemp}");
                          debugPrint("Admin Temp: ${state.adminTemp}");

                          _updateController(_hargaController, ToCurrency(
                            state.hargaTemp.toString(),
                          ));
                          _updateController(_adminController, ToCurrency(
                            state.adminTemp.toString(),
                          ));
                        },
                        height: 28,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        variant: ButtonVariant.border,
                        backgroundColor: context.destructive.withValues(alpha: 0.2),
                        borderColor: context.destructive,
                        textStyle: context.bodySmall
                            .withColor(context.destructive)
                            .withWeight(FontWeight.w500),
                      );
                    },
                  ),
                ],
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildHargaField(context),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Admin:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildAdminField(context),
            ),
            Gap(15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomButton(
                height: 32,
                padding: EdgeInsets.zero,
                width: double.infinity,
                iconPosition: IconPosition.end,
                icon: LucideIcons.arrowRight,
                text: "Terapkan Harga",
                onPressed: () {
                  var valid = validateAturHarga();
                  if (!valid) return;

                  List<KeyValue> dataBiaya = [
                    KeyValue(
                      key: "Harga",
                      value: (_hargaController.text).toString(),
                    ),
                    KeyValue(
                      key: "Admin",
                      value: (_adminController.text).toString(),
                    ),
                  ];

                  getMemberCetakStrukNominalBebasProvider(context)
                    ..setDataBiaya(dataBiaya)
                    ..setHarga(_hargaController.text)
                    ..setAdmin(_adminController.text);

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

  Widget _buildHargaField(BuildContext context) {
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
          Text("Rp.", style: context.bodyMedium),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _hargaController,
              onChanged: (value) {
                _updateController(
                  _hargaController,
                  ToCurrency(FromCurrency(value).toString()),
                );

                if (value.isEmpty) {
                  _updateController(_hargaController, "0");
                }
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : 5.000',
                suffixIcon: _hargaController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _updateController(_hargaController, "0");
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

  Widget _buildAdminField(BuildContext context) {
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
          Text("Rp.", style: context.bodyMedium),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _adminController,
              onChanged: (value) {
                _updateController(
                  _adminController,
                  ToCurrency(FromCurrency(value).toString()),
                );

                if (value.isEmpty) {
                  _updateController(_adminController, "0");
                }
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : 1.000',
                suffixIcon: _adminController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _updateController(_adminController, "0");
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

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }
}
