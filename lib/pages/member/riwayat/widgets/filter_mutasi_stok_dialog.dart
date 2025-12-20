import 'package:dmpku/core/enums/jenis_filter_riwayat.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FilterMutasiStokDialog extends StatefulWidget {
  final String initialSearch;
  final DateTime? waktuAwal;
  final DateTime? waktuAkhir;

  const FilterMutasiStokDialog({
    super.key,
    this.initialSearch = '',
    this.waktuAwal,
    this.waktuAkhir,
  });

  static void show(
      BuildContext context, {
        String initialSearch = '',
        DateTime? waktuAwal,
        DateTime? waktuAkhir,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => FilterMutasiStokDialog(
        initialSearch: initialSearch,
        waktuAwal: waktuAwal ?? DateTime.now().subtract(Duration(days: 4)),
        waktuAkhir: waktuAkhir ?? DateTime.now().subtract(Duration(days: 1)),
      ),
    );
  }

  @override
  State<FilterMutasiStokDialog> createState() =>
      _FilterMutasiStokDialogState();
}

class _FilterMutasiStokDialogState
    extends State<FilterMutasiStokDialog> {
  late TextEditingController _searchController = TextEditingController(
    text: widget.initialSearch,
  );
  late DateTime? _waktuAwal =
      widget.waktuAwal ?? DateTime.now().subtract(Duration(days: 4));
  late DateTime? _waktuAkhir =
      widget.waktuAkhir ?? DateTime.now().subtract(Duration(days: 1));

  Future<void> _selectDateAwal() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _waktuAwal,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    setState(() {
      if (pickedDate != null) {
        _waktuAwal = pickedDate;
        _waktuAkhir = pickedDate.add(Duration(days: 3));
      }
    });
  }

  Future<void> _selectDateAkhir() async {
    var maxDate = DateTime.now();
    if (_waktuAwal != null) {
      maxDate = _waktuAwal!.add(Duration(days: 7));
      if (maxDate.isAfter(DateTime.now())) {
        maxDate = DateTime.now();
      }
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _waktuAkhir,
      firstDate: _waktuAwal!,
      lastDate: maxDate,
    );

    setState(() {
      if (pickedDate != null) {
        _waktuAkhir = pickedDate;
      }
    });
  }

  bool validateWaktuRange() {
    if (_waktuAwal != null && _waktuAkhir != null) {
      final difference = _waktuAkhir!.difference(_waktuAwal!).inDays;

      if (difference < 0) {
        showWarningMessage("Waktu Akhir tidak boleh sebelum Waktu Awal.");
        return false;
      } else if (difference > 7) {
        showWarningMessage("Rentang waktu maksimal adalah 7 hari.");
        return false;
      }
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
                      child: Icon(MdiIcons.tableSearch, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filter Mutasi Stok',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Terapkan filter untuk menampilkan mutasi stok.',
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
                    "Rentang Waktu:",
                    style: context.bodyMedium.withWeight(FontWeight.w500),
                  ),
                  Spacer(),
                  CustomButton(
                    text: "Reset",
                    onPressed: () {
                      getMemberRiwayatProvider(context)
                        ..resetSearchMutasiStok()
                        ..resetPageMutasiStok();

                      pop();
                    },
                    height: 28,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    variant: ButtonVariant.border,
                    backgroundColor: context.destructive.withOpacity(0.2),
                    borderColor: context.destructive,
                    textStyle: context.bodySmall
                        .withColor(context.destructive)
                        .withWeight(FontWeight.w500),
                  ),
                ],
              ),
            ),
            Gap(5),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dari:",
                          style: context.captionRegular.withWeight(
                            FontWeight.w500,
                          ),
                        ),
                        Card(
                          color: context.isDarkMode ? slate[800] : slate[50],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              _selectDateAwal();
                            },
                            child: Padding(
                              padding: paddingCard,
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.calendarClock,
                                    size: 14,
                                    color: context.mutedForeground,
                                  ),
                                  Gap(6),
                                  Expanded(
                                    child: Text(
                                      DateHelper.formatSimpleDate(_waktuAwal!),
                                      style: context.captionRegular
                                          .withColor(context.primary)
                                          .withWeight(FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sampai:",
                          style: context.captionRegular.withWeight(
                            FontWeight.w500,
                          ),
                        ),
                        Card(
                          color: context.isDarkMode ? slate[800] : slate[50],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              _selectDateAkhir();
                            },
                            child: Padding(
                              padding: paddingCard,
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.calendarClock,
                                    size: 14,
                                    color: context.mutedForeground,
                                  ),
                                  Gap(6),
                                  Expanded(
                                    child: Text(
                                      DateHelper.formatSimpleDate(_waktuAkhir!),
                                      style: context.captionRegular
                                          .withColor(context.primary)
                                          .withWeight(FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(10),
            Divider(color: context.border, height: 0.5),
            Gap(10),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Kata Kunci:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildSearchField(context),
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
                text: "Terapkan Filter",
                onPressed: () {
                  var valid = validateWaktuRange();
                  if (!valid) return;

                  getMemberRiwayatProvider(context)
                    ..setKataKunciHistory(_searchController.text)
                    ..setRangeWaktuMutasiStok(_waktuAwal!, _waktuAkhir!)
                    ..resetPageMutasiStok();

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

  Widget _buildSearchField(BuildContext context) {
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
          Icon(LucideIcons.search, size: 14, color: context.mutedForeground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : DMP001, Produk A',
                suffixIcon: _searchController.text.isNotEmpty
                    ? InkWell(
                  onTap: () {
                    _searchController.clear();
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
}
