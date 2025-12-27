import 'package:dmpku/core/enums/jenis_filter_riwayat.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_filter_sheet_scaffold.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FilterRiwayatHistoryDialog extends StatefulWidget {
  final String initialSearch;
  final JenisFilterRiwayat initialFilter;
  final DateTime? waktuAwal;
  final DateTime? waktuAkhir;

  const FilterRiwayatHistoryDialog({
    super.key,
    this.initialSearch = '',
    this.initialFilter = JenisFilterRiwayat.tujuan,
    this.waktuAwal,
    this.waktuAkhir,
  });

  static void show(
    BuildContext context, {
    String initialSearch = '',
    JenisFilterRiwayat initialFilter = JenisFilterRiwayat.tujuan,
    DateTime? waktuAwal,
    DateTime? waktuAkhir,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => FilterRiwayatHistoryDialog(
        initialSearch: initialSearch,
        initialFilter: initialFilter,
        waktuAwal: waktuAwal ?? DateTime.now().subtract(const Duration(days: 4)),
        waktuAkhir: waktuAkhir ?? DateTime.now().subtract(const Duration(days: 1)),
      ),
    );
  }

  @override
  State<FilterRiwayatHistoryDialog> createState() =>
      _FilterRiwayatHistoryDialogState();
}

class _FilterRiwayatHistoryDialogState
    extends State<FilterRiwayatHistoryDialog> {
  late JenisFilterRiwayat _selectedFilter = widget.initialFilter;
  late final TextEditingController _searchController = TextEditingController(
    text: widget.initialSearch,
  );
  late DateTime? _waktuAwal =
      widget.waktuAwal ?? DateTime.now().subtract(const Duration(days: 4));
  late DateTime? _waktuAkhir =
      widget.waktuAkhir ?? DateTime.now().subtract(const Duration(days: 1));

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
        _waktuAkhir = pickedDate.add(const Duration(days: 3));
      }
    });
  }

  Future<void> _selectDateAkhir() async {
    var maxDate = DateTime.now();
    if (_waktuAwal != null) {
      maxDate = _waktuAwal!.add(const Duration(days: 7));
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
    return RiwayatFilterSheetScaffold(
      title: 'Filter Transaksi Kemarin',
      subtitle: 'Terapkan filter untuk menampilkan riwayat transaksi kemarin.',
      onApply: () {
        var valid = validateWaktuRange();
        if (!valid) return;

        getMemberRiwayatProvider(context)
          ..setKataKunciHistory(_searchController.text)
          ..setJenisFilterHistory(_selectedFilter)
          ..setRangeWaktu(_waktuAwal!, _waktuAkhir!)
          ..resetPageRiwayatHistory();

        pop();
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Rentang Waktu:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              const Spacer(),
              CustomButton(
                text: "Reset",
                onPressed: () {
                  getMemberRiwayatProvider(context)
                    ..resetSearchRiwayatHistory()
                    ..resetPageRiwayatHistory();

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
                  ],
                ),
              ),
              const Gap(6),
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
                              const Gap(6),
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
        const Gap(10),
        Divider(color: context.border, height: 0.5),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "Cari Berdasarkan:",
            style: context.bodyMedium.withWeight(FontWeight.w500),
          ),
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildFilterOption(
                context,
                _selectedFilter.isTujuan,
                JenisFilterRiwayat.tujuan,
              ),
              const Gap(8),
              _buildFilterOption(
                context,
                _selectedFilter.isKodeProduk,
                JenisFilterRiwayat.kodeProduk,
              ),
              const Gap(8),
              _buildFilterOption(
                context,
                _selectedFilter.isNamaProduk,
                JenisFilterRiwayat.namaProduk,
              ),
            ],
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

  Widget _buildFilterOption(
    BuildContext context,
    bool isSelected,
    JenisFilterRiwayat jenisFilter,
  ) {
    return Expanded(
      child: Card(
        color: isSelected
            ? context.primary.withValues(alpha: 0.1)
            : context.isDarkMode
                ? slate[800]
                : slate[50],
        shape: isSelected
            ? RoundedRectangleBorder(
                side: BorderSide(color: context.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: context.border, width: 1),
              ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedFilter = jenisFilter;
            });
          },
          child: Padding(
            padding: paddingCard,
            child: Row(
              children: [
                Icon(
                  jenisFilter.icon,
                  size: 14,
                  color: isSelected ? context.primary : context.mutedForeground,
                ),
                const Gap(6),
                Expanded(
                  child: Text(
                    jenisFilter.label,
                    style: context.bodySmall
                        .withColor(
                          isSelected ? context.primary : context.foreground,
                        )
                        .withWeight(FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
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
                          Icons.close,
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
