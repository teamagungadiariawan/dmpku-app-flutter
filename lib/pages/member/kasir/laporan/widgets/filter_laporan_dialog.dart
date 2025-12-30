import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilterLaporanDialog extends StatefulWidget {
  final DateTime initialTanggalAwal;
  final DateTime initialTanggalAkhir;

  const FilterLaporanDialog({
    super.key,
    required this.initialTanggalAwal,
    required this.initialTanggalAkhir,
  });

  static Future<void> show(
    BuildContext context, {
    required DateTime tanggalAwal,
    required DateTime tanggalAkhir,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => FilterLaporanDialog(
        initialTanggalAwal: tanggalAwal,
        initialTanggalAkhir: tanggalAkhir,
      ),
    );
  }

  @override
  State<FilterLaporanDialog> createState() => _FilterLaporanDialogState();
}

class _FilterLaporanDialogState extends State<FilterLaporanDialog> {
  late DateTime _tanggalAwal;
  late DateTime _tanggalAkhir;

  @override
  void initState() {
    super.initState();
    _tanggalAwal = widget.initialTanggalAwal;
    _tanggalAkhir = widget.initialTanggalAkhir;
  }

  Future<void> _selectTanggalAwal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalAwal,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalAwal = picked;
        if (_tanggalAwal.isAfter(_tanggalAkhir)) {
          _tanggalAkhir = _tanggalAwal;
        }
      });
    }
  }

  Future<void> _selectTanggalAkhir() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalAkhir,
      firstDate: _tanggalAwal,
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalAkhir = picked;
      });
    }
  }

  void _applyFilter() {
    getKasirProvider(context).setTanggalLaporan(_tanggalAwal, _tanggalAkhir);
    getKasirProvider(context).fetchLaporanKasir();
    getKasirProvider(context).fetchTotalLaporanKasir();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: paddingCard,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Laporan",
              style: context.sectionTitle.withWeight(FontWeight.w600),
            ),
            const Gap(16),
            Text(
              "Tanggal Awal",
              style: context.bodySmall.withColor(context.mutedForeground),
            ),
            const Gap(6),
            InkWell(
              onTap: _selectTanggalAwal,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: context.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateHelper.formatYYYYMMDD(_tanggalAwal),
                        style: context.bodyMedium,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: context.primary,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(12),
            Text(
              "Tanggal Akhir",
              style: context.bodySmall.withColor(context.mutedForeground),
            ),
            const Gap(6),
            InkWell(
              onTap: _selectTanggalAkhir,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: context.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateHelper.formatYYYYMMDD(_tanggalAkhir),
                        style: context.bodyMedium,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: context.primary,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Batal",
                    onPressed: () => Navigator.pop(context),
                    variant: ButtonVariant.border,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: CustomButton(
                    text: "Terapkan",
                    onPressed: _applyFilter,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
