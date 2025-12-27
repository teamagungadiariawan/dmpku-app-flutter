import 'package:dmpku/core/enums/tipe_produk.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/pilih_favorit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

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
                // Untuk sementara "Simpan Ke Favorit" mungkin belum diubah logikanya
                // atau mungkin ini yang dimaksud "login" tadi?
                // Tapi request user spesifik "tambahkan dialog untuk pilih favorit".
                // Jadi saya biarkan simpan favorit seperti logic sebelumnya (callback login/action).
                // TAPI tunggu, logic sebelumnya: onResult('login');
                // Saya akan kembalikan 'login' string untuk tombol SIMPAN ini agar tidak merusak existing behavior
                // jika existing behavior mengandalkan string 'login' untuk trigger something.
                // Namun, sepertinya user ingin tombol "Pilih" yg muncul dialog.
                onResult('login');
              }
            },
          ),
        ),
      ],
    );
  }
}
