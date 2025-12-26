import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_filter_sheet_scaffold.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FilterMutasiStokDialog extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;

  const FilterMutasiStokDialog({super.key, this.startDate, this.endDate});

  static void show(
    BuildContext context, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) =>
          FilterMutasiStokDialog(startDate: startDate, endDate: endDate),
    );
  }

  @override
  State<FilterMutasiStokDialog> createState() => _FilterMutasiStokDialogState();
}

class _FilterMutasiStokDialogState extends State<FilterMutasiStokDialog> {
  late DateTime? _startDate = widget.startDate ?? DateTime.now();
  late DateTime? _endDate = widget.endDate ?? DateTime.now();

  Future<void> _selectDate({required bool isStart}) async {
    final initialDate = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? DateTime.now());

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    setState(() {
      if (pickedDate != null) {
        if (isStart) {
          _startDate = pickedDate;
          // Ensure end date is not before start date
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = pickedDate;
          // Ensure start date is not after end date
          if (_startDate != null && _startDate!.isAfter(_endDate!)) {
            _startDate = _endDate;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RiwayatFilterSheetScaffold(
      title: 'Filter Mutasi Stok',
      subtitle: 'Terapkan filter untuk menampilkan mutasi stok.',
      onApply: () {
        getMemberIsiStokProvider(context)
          ..setDateFilterMutasi(_startDate!, _endDate!)
          ..refreshMutasiDeposit();

        pop();
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tanggal Mutasi:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              const Spacer(),
              CustomButton(
                text: "Reset",
                onPressed: () {
                  getMemberIsiStokProvider(context).resetMutasiDepositFilter();

                  pop();
                },
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: _buildDateCard(
                  title: "Dari",
                  date: _startDate,
                  onTap: () => _selectDate(isStart: true),
                ),
              ),
              const Gap(10),
              Expanded(
                child: _buildDateCard(
                  title: "Sampai",
                  date: _endDate,
                  onTap: () => _selectDate(isStart: false),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Card(
      color: context.isDarkMode ? slate[800] : slate[50],
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: paddingCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.captionRegular.withColor(
                  context.mutedForeground,
                ),
              ),
              const Gap(4),
              Row(
                children: [
                  Icon(
                    LucideIcons.calendarClock,
                    size: 14,
                    color: context.mutedForeground,
                  ),
                  const Gap(6),
                  Expanded(
                    child: Text(
                      DateHelper.formatSimpleDate(date!),
                      style: context.captionRegular
                          .withColor(context.primary)
                          .withWeight(FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
