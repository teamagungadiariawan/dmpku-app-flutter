import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/kategori_favorit.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/favorit_response.dart';
import 'package:dmpku/pages/member/akun/favorit/member_favorit_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HapusFavoritDialog extends StatefulWidget {
  final FavoritModel favorit;

  const HapusFavoritDialog({super.key, required this.favorit});

  static Future<void> show(
    BuildContext context, {
    required FavoritModel favorit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      builder: (_) => HapusFavoritDialog(favorit: favorit),
    );
  }

  @override
  State<HapusFavoritDialog> createState() => _HapusFavoritDialogState();
}

class _HapusFavoritDialogState extends State<HapusFavoritDialog> {
  void hapusFavorit() async {
    var suc = await getMemberFavoritProvider(
      context,
    ).deleteFavorit(context, idfavorit: widget.favorit.idfavorit);

    if (suc) {
      pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: paddingPage,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: context.destructive, width: 1),
              ),
              color: context.destructive.withValues(alpha: 0.3),
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
                      child: Icon(MdiIcons.starRemove, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hapus dari Favorit',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Kontak ini akan dihapus dari daftar favorit Anda.',
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
            _buildFavoritItem(context, widget.favorit),
            Gap(15),
            BlocBuilder<MemberFavoritProvider, MemberFavoritState>(
              buildWhen: (previous, current) =>
                  previous.apiHapusFavoritStatus !=
                  current.apiHapusFavoritStatus,
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
                          if (!state.apiHapusFavoritStatus.isLoading) pop();
                        },
                      ),
                    ),
                    Gap(15),
                    Expanded(
                      child: CustomButton(
                        height: 30,
                        padding: EdgeInsets.zero,
                        variant: ButtonVariant.destructive,
                        text: "Hapus Perangkat",
                        isLoading: state.apiHapusFavoritStatus.isLoading,
                        onPressed: () {
                          hapusFavorit();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritItem(BuildContext context, FavoritModel provider) {
    var jenisFav = Kategori.fromId(provider.idkategori) ?? Kategori.all;
    var katItem = jenisFav.toKategoriItem ?? getKategoriFavorit()[0];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            if (katItem.icon != null)
              Image(image: katItem.icon!, width: 40, height: 40)
            else
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: context.border, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  LucideIcons.star,
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
                    provider.nama,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    provider.nomor,
                    style: context.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: context.muted,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                provider.namakategori,
                style: context.bodySmall
                    .withSize(10)
                    .withWeight(FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
