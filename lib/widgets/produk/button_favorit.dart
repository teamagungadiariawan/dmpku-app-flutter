import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class ButtonFavorit extends StatelessWidget {
  final bool isGuest;
  final String? tujuan;
  final int? idKategori;
  final Function(String) onResult;

  const ButtonFavorit({
    super.key,
    required this.isGuest,
    required this.onResult,
    this.tujuan = '',
    this.idKategori = 0,
  });

  @override
  Widget build(BuildContext context) {
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
            text: "Pilih Dari Favorit",
            icon: MdiIcons.star,
            onPressed: () {
              if (isGuest) {
                BelumLoginDialog.show(context);
              } else {
                onResult('login');
              }
            },
          ),
        ),
        Gap(10),
        Expanded(
          child: CustomButton(
            height: 30,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.border,
            text: "Simpan Ke Favorit",
            icon: MdiIcons.starPlus,
            onPressed: () {
              if (isGuest) {
                BelumLoginDialog.show(context);
              } else {
                onResult('login');
              }
            },
          ),
        ),
      ],
    );
  }
}
