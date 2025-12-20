import 'package:dmpku/core/enums/jenis_filter_riwayat.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
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

class FilterRiwayatTodayDialog extends StatefulWidget {
  final String initialSearch;
  final JenisFilterRiwayat initialFilter;

  const FilterRiwayatTodayDialog({
    super.key,
    this.initialSearch = '',
    this.initialFilter = JenisFilterRiwayat.tujuan,
  });

  static void show(
    BuildContext context, {
    String initialSearch = '',
    JenisFilterRiwayat initialFilter = JenisFilterRiwayat.tujuan,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => FilterRiwayatTodayDialog(
        initialSearch: initialSearch,
        initialFilter: initialFilter,
      ),
    );
  }

  @override
  State<FilterRiwayatTodayDialog> createState() =>
      _FilterRiwayatTodayDialogState();
}

class _FilterRiwayatTodayDialogState extends State<FilterRiwayatTodayDialog> {
  late JenisFilterRiwayat _selectedFilter = widget.initialFilter;
  late TextEditingController _searchController = TextEditingController(
    text: widget.initialSearch,
  );

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
                            'Filter Riwayat Hari Ini',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Terapkan filter untuk menampilkan riwayat transaksi hari ini.',
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
                    "Cari Berdasarkan:",
                    style: context.bodyMedium.withWeight(FontWeight.w500),
                  ),
                  Spacer(),
                  CustomButton(
                    text: "Reset",
                    onPressed: () {
                      getMemberRiwayatProvider(context)
                        ..setKataKunciToday("")
                        ..setJenisFilterToday(JenisFilterRiwayat.tujuan)
                        ..resetPageRiwayatToday();
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
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFilterOption(
                    context,
                    _selectedFilter.isTujuan,
                    JenisFilterRiwayat.tujuan,
                  ),
                  Gap(8),
                  _buildFilterOption(
                    context,
                    _selectedFilter.isKodeProduk,
                    JenisFilterRiwayat.kodeProduk,
                  ),
                  Gap(8),
                  _buildFilterOption(
                    context,
                    _selectedFilter.isNamaProduk,
                    JenisFilterRiwayat.namaProduk,
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
                  getMemberRiwayatProvider(context)
                    ..setKataKunciToday(_searchController.text)
                    ..setJenisFilterToday(_selectedFilter)
                    ..resetPageRiwayatToday();
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

  Widget _buildFilterOption(
    BuildContext context,
    bool isSelected,
    JenisFilterRiwayat jenisFilter,
  ) {
    return Expanded(
      child: Card(
        color: isSelected
            ? context.primary.withOpacity(0.1)
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
                Gap(6),
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
