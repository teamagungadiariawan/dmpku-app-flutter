import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_filter_sheet_scaffold.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FilterPenjualanDialog extends StatefulWidget {
  final DateTime initialDate;

  const FilterPenjualanDialog({super.key, required this.initialDate});

  static void show(BuildContext context, {required DateTime initialDate}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => FilterPenjualanDialog(initialDate: initialDate),
    );
  }

  @override
  State<FilterPenjualanDialog> createState() => _FilterPenjualanDialogState();
}

class _FilterPenjualanDialogState extends State<FilterPenjualanDialog> {
  late DateTime _selectedDate = widget.initialDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024), // Reasonable start date
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RiwayatFilterSheetScaffold(
      title: 'Filter Penjualan',
      subtitle: 'Pilih tanggal untuk menampilkan rekap penjualan.',
      onApply: () {
        context.read<KasirProvider>().onChangeTanggalPenjualan(_selectedDate);
        pop();
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tanggal:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              const Spacer(),
              CustomButton(
                text: "Reset",
                onPressed: () {
                  context.read<KasirProvider>().onChangeTanggalPenjualan(
                    DateTime.now(),
                  );
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
              onTap: _selectDate,
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
                        DateHelper.formatSimpleDate(_selectedDate),
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
      ],
    );
  }
}
