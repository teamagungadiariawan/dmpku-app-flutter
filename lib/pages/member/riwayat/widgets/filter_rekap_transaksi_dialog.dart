import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';

import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_filter_sheet_scaffold.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FilterRekapTransaksiDialog extends StatefulWidget {
  final String initialSearch;
  final DateTime? waktuAwal;

  const FilterRekapTransaksiDialog({
    super.key,
    this.initialSearch = '',
    this.waktuAwal,
  });

  static void show(
    BuildContext context, {
    String initialSearch = '',
    DateTime? waktuAwal,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => FilterRekapTransaksiDialog(
        initialSearch: initialSearch,
        waktuAwal: waktuAwal ?? DateTime.now(),
      ),
    );
  }

  @override
  State<FilterRekapTransaksiDialog> createState() =>
      _FilterRekapTransaksiDialogState();
}

class _FilterRekapTransaksiDialogState
    extends State<FilterRekapTransaksiDialog> {
  late final TextEditingController _searchController = TextEditingController(
    text: widget.initialSearch,
  );
  late DateTime? _waktuAwal = widget.waktuAwal ?? DateTime.now();

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RiwayatFilterSheetScaffold(
      title: 'Filter Rekap Transaksi',
      subtitle: 'Terapkan filter untuk menampilkan rekap transaksi.',
      onApply: () {
        getMemberRiwayatProvider(context)
          ..setKataKunciRekapTransaksi(_searchController.text)
          ..setWaktuAwalRekapTransaksi(_waktuAwal!)
          ..fetchRekapTransaksi();

        pop();
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tanggal Rekap:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              const Spacer(),
              CustomButton(
                text: "Reset",
                onPressed: () {
                  getMemberRiwayatProvider(context)
                    ..resetSearchRekapTransaksi()
                    ..fetchRekapTransaksi();

                  pop();
                },
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                variant: ButtonVariant.border,
                backgroundColor: context.destructive.withValues(alpha: 0.2),
                borderColor: context.destructive,
                textStyle: context.bodySmall
                    .withColor(context.destructive)
                    .withWeight(FontWeight.w500),
              ),
            ],
          ),
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Card(
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
                    const Gap(6),
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
        ),
        const Gap(10),
        Divider(color: context.border, height: 0.5),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "Kata Kunci:",
            style: context.bodyMedium.withWeight(FontWeight.w500),
          ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: _buildSearchField(context),
        ),
      ],
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
