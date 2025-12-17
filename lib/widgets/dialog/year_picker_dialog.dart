import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class YearPickerDialog extends StatefulWidget {
  final Function(String)? onSelected;
  final String? initialYear;

  const YearPickerDialog({super.key, this.onSelected, this.initialYear});

  static void show(
    BuildContext context, {
    Function(String)? onSelected,
    String? initialYear,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => YearPickerDialog(
        onSelected: onSelected,
        initialYear: initialYear,
      ),
    );
  }

  @override
  State<YearPickerDialog> createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<YearPickerDialog> {
  late List<String> _years;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    _years = List.generate(12, (index) => (currentYear - index).toString());
    _selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TopDividerSheet(),
            const Gap(15),
            _buildHeader(context),
            const Gap(10),
            Flexible(child: _buildYearGrid(context)),
            const Gap(10),
            CustomButton(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.zero,
              variant: ButtonVariant.destructive,
              text: "TUTUP",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? stone[700] : stone[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(MdiIcons.calendar),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Tahun',
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Pilih salah satu tahun dari daftar.',
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2.0,
      ),
      itemCount: _years.length,
      itemBuilder: (context, index) {
        final year = _years[index];
        final isSelected = year == _selectedYear;

        return InkWell(
          onTap: () {
            widget.onSelected?.call(year);
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? context.primary : context.muted,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? context.primary : context.border,
              ),
            ),
            child: Center(
              child: Text(
                year,
                style: context.bodyMedium.copyWith(
                  color: isSelected
                      ? context.primaryForeground
                      : context.foreground,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
