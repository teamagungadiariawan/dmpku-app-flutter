import 'package:dmpku/core/enums/tipe_produk.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/pilih_favorit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

import 'package:dmpku/pages/member/akun/favorit/widget/tambah_favorit_dialog.dart';

class ButtonFavorit extends StatelessWidget {
  final bool isGuest;
  final String? tujuan;
  final TipeProduk tipeProduk;
  final Function(String) onResult;

  const ButtonFavorit({
    super.key,
    required this.isGuest,
    required this.onResult,
    this.tujuan = '',
    this.tipeProduk = TipeProduk.all,
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
            height: 32,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.border,
            text: "Pilih Dari Favorit",
            icon: MdiIcons.star,
            onPressed: () {
              if (isGuest) {
                BelumLoginDialog.show(context);
              } else {
                PilihFavoritDialog.show(
                  context,
                  tipeProduk: tipeProduk,
                  onFavoritSelected: (favorit) {
                    onResult(favorit.nomor);
                  },
                );
              }
            },
          ),
        ),
        Gap(10),
        Expanded(
          child: CustomButton(
            height: 32,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.border,
            text: "Simpan Ke Favorit",
            icon: MdiIcons.starPlus,
            onPressed: () {
              if (isGuest) {
                BelumLoginDialog.show(context);
              } else {
                TambahFavoritDialog.show(
                  context,
                  idKategori: tipeProduk.idFavorit,
                  nomor: tujuan,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
