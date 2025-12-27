import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/kategori_favorit.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/akun/favorit/member_favorit_provider.dart';
import 'package:dmpku/pages/member/akun/favorit/widget/pilih_kategori_dialog.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TambahFavoritDialog extends StatefulWidget {
  final int idKategori;
  final String? nomor;

  const TambahFavoritDialog({super.key, required this.idKategori, this.nomor});

  static void show(
    BuildContext context, {
    required int idKategori,
    String? nomor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TambahFavoritDialog(idKategori: idKategori, nomor: nomor),
    );
  }

  @override
  State<TambahFavoritDialog> createState() => _TambahFavoritDialogState();
}

class _TambahFavoritDialogState extends State<TambahFavoritDialog> {
  late Kategori kat = Kategori.fromId(widget.idKategori) ?? Kategori.all;
  late TextEditingController _namaFavoritController;
  late TextEditingController _nomorFavoritController;

  final shakeKeyNama = GlobalKey<ShakeWidgetState>();
  final shakeKeyNomor = GlobalKey<ShakeWidgetState>();

  String errorKategori = '';
  String errorNamaFavorit = '';
  String errorNomorFavorit = '';

  @override
  void initState() {
    super.initState();
    _namaFavoritController = TextEditingController();
    _nomorFavoritController = TextEditingController(text: widget.nomor);
  }

  @override
  void dispose() {
    _namaFavoritController.dispose();
    _nomorFavoritController.dispose();
    super.dispose();
  }

  bool validateTambahFavorit() {
    bool isValid = true;

    setState(() {
      errorKategori = '';
      errorNamaFavorit = '';
      errorNomorFavorit = '';

      if (_namaFavoritController.text.isEmpty) {
        errorNamaFavorit = 'Nama favorit tidak boleh kosong.';
        isValid = false;
      } else {
        var text = _namaFavoritController.text;
        if (text.length < 3) {
          errorNamaFavorit = 'Nama favorit minimal 3 karakter.';
          isValid = false;
        } else if (text.length > 50) {
          errorNamaFavorit = 'Nama favorit maksimal 50 karakter.';
          isValid = false;
        }
      }

      if (_nomorFavoritController.text.isEmpty) {
        errorNomorFavorit = 'Nomor favorit tidak boleh kosong.';
        isValid = false;
      } else {
        var text = _nomorFavoritController.text;

        if (text.length < 3) {
          errorNomorFavorit = 'Nomor favorit minimal 6 digit.';
          isValid = false;
        }
      }
    });

    if (!isValid) {
      if (errorNamaFavorit.isNotEmpty) {
        shakeKeyNama.currentState?.shake();
      }
      if (errorNomorFavorit.isNotEmpty) {
        shakeKeyNomor.currentState?.shake();
      }
    }

    return isValid;
  }

  void simpanFavorit() async {
    if (validateTambahFavorit()) {
      // Simpan favorit ke database atau API di sini

      var suc = await getMemberFavoritProvider(context).saveFavorit(
        context,
        kategori: kat,
        nama: _namaFavoritController.text.trim(),
        nomor: _nomorFavoritController.text.trim(),
      );

      if (!suc) {
        return;
      }

      // Setelah berhasil disimpan, tutup dialog
      pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var katItem = kat.toKategoriItem ?? getKategoriFavorit()[0];

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
                      child: Icon(MdiIcons.starPlus, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tambah Favorit',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Tambah Tujuan Favorit Anda untuk kemudahan akses di masa mendatang.',
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
                "Kategori",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Card(
                color: context.muted,
                child: InkWell(
                  onTap: () {
                    PilihKategoriDialog.show(
                      context,
                      selectedIndex: kat.id,
                      onCategorySelected: (val) {
                        Kategori katNew =
                            Kategori.fromId(val.id) ?? Kategori.all;
                        setState(() {
                          kat = katNew;
                        });
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        if (katItem.icon != null)
                          Image(image: katItem.icon!, width: 24, height: 24)
                        else
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: context.background,
                              border: Border.all(
                                color: context.border,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              LucideIcons.star,
                              size: 12,
                              color: context.foreground,
                            ),
                          ),
                        Gap(6),
                        Expanded(
                          child: Text(
                            katItem.label,
                            style: context.bodyMedium.withWeight(
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        Gap(10),
                        Icon(
                          MdiIcons.chevronRight,
                          size: 20,
                          color: context.mutedForeground,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Nama Favorit:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildNamaFavoritField(),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Nomor Favorit:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildNomorFavoritField(),
            ),
            Gap(20),
            BlocBuilder<MemberFavoritProvider, MemberFavoritState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomButton(
                    height: 32,
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    iconPosition: IconPosition.end,
                    icon: LucideIcons.arrowRight,
                    isLoading: state.apiTambahFavoritStatus.isLoading,
                    text: "Simpan Favorit",
                    onPressed: () {
                      simpanFavorit();
                    },
                  ),
                );
              },
            ),
            Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildNamaFavoritField() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(
              color: errorNamaFavorit.isEmpty
                  ? context.border
                  : context.destructive,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(MdiIcons.starSettings, size: 18, color: context.foreground),
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: _namaFavoritController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Contoh : Rumah, Kantor, dll',
                    suffixIcon: _namaFavoritController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              _updateController(_namaFavoritController, "");
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
        ).withShake(key: shakeKeyNama),
        if (errorNamaFavorit.isNotEmpty) ...[
          Gap(4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorNamaFavorit,
              style: context.captionRegular.withColor(context.destructive),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNomorFavoritField() {
    var katItem = kat.toKategoriItem ?? getKategoriFavorit()[0];

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(
              color: errorNomorFavorit.isEmpty
                  ? context.border
                  : context.destructive,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              if (katItem.icon != null)
                Image(image: katItem.icon!, width: 24, height: 24)
              else
                Icon(
                  MdiIcons.cardAccountDetails,
                  size: 18,
                  color: context.foreground,
                ),
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: _nomorFavoritController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Masukkan Nomor Favorit',
                    suffixIcon: _nomorFavoritController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              _updateController(_nomorFavoritController, "");
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
        ).withShake(key: shakeKeyNomor),
        if (errorNomorFavorit.isNotEmpty) ...[
          Gap(4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorNomorFavorit,
              style: context.captionRegular.withColor(context.destructive),
            ),
          ),
        ],
      ],
    );
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }
}
