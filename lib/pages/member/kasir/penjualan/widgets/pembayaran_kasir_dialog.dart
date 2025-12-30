import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PembayaranKasirDialog extends StatefulWidget {
  final int totalTagihan;

  const PembayaranKasirDialog({super.key, required this.totalTagihan});

  static void show(BuildContext context, {required int totalTagihan}) {
    // Capture the parent provider
    final kasirProvider = context.read<KasirProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: kasirProvider,
          child: PembayaranKasirDialog(totalTagihan: totalTagihan),
        );
      },
    );
  }

  @override
  State<PembayaranKasirDialog> createState() => _PembayaranKasirDialogState();
}

class _PembayaranKasirDialogState extends State<PembayaranKasirDialog> {
  late TextEditingController _uangController;
  final shakeKeyUang = GlobalKey<ShakeWidgetState>();

  int _kembalian = 0;
  String errorUang = '';

  @override
  void initState() {
    super.initState();
    _uangController = TextEditingController();
    // Initialize kembalian based on 0 input - totalTagihan (negative)
    _kembalian = -widget.totalTagihan;
  }

  @override
  void dispose() {
    _uangController.dispose();
    super.dispose();
  }

  void _hitungKembalian() {
    String cleanValue = _uangController.text.replaceAll('.', '');
    int uang = int.tryParse(cleanValue) ?? 0;
    setState(() {
      _kembalian = uang - widget.totalTagihan;
    });
  }

  bool _validateInput() {
    String cleanValue = _uangController.text.replaceAll('.', '');
    int uang = int.tryParse(cleanValue) ?? 0;

    if (uang < widget.totalTagihan) {
      setState(() {
        errorUang = 'Uang pembayaran kurang';
      });
      shakeKeyUang.currentState?.shake();
      return false;
    }

    setState(() {
      errorUang = '';
    });
    return true;
  }

  Future<void> _processPayment() async {
    if (_validateInput()) {
      String cleanValue = _uangController.text.replaceAll('.', '');
      int uang = int.tryParse(cleanValue) ?? 0;

      // Close the dialog first
      pop();

      // Process in provider
      await context.read<KasirProvider>().processTransaction(
        uangPelanggan: uang,
        kembalian: _kembalian,
      );

      // If success, user might need to pop the InputPenjualanPage, but that logic is usually handled by listener or callback.
      // However, current KasirProvider.processTransaction logic typically handles state updates.
      // The original code popped parent page on success.
      // We might need to handle navigation result here if necessary.
    }
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
    _hitungKembalian();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomInset),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const TopDividerSheet(),
              const Gap(15),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        child: Icon(MdiIcons.cashRegister, size: 16),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pembayaran',
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Masukkan nominal pembayaran pelanggan.',
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
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    _buildTotalInfo(
                      context,
                      "Total Tagihan",
                      widget.totalTagihan,
                    ),
                    const Gap(10),
                    _buildKembalianInfo(context, "Kembalian", _kembalian),
                  ],
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _buildTextField(
                  controller: _uangController,
                  label: 'Uang Pelanggan',
                  hint: '0',
                  icon: MdiIcons.cashMultiple,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  shakeKey: shakeKeyUang,
                  errorText: errorUang,
                  onChanged: (val) {
                    _updateController(_uangController, ToCurrency(val));
                    // _hitungKembalian is called inside _updateController
                  },
                ),
              ),
              const Gap(20),
              BlocBuilder<KasirProvider, KasirState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomButton(
                      height: 32,
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      iconPosition: IconPosition.end,
                      icon: LucideIcons.check,
                      isLoading: state.apiInputPenjualanStatus.isLoading,
                      text: "Bayar & Selesai",
                      onPressed: _processPayment,
                    ),
                  );
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalInfo(BuildContext context, String label, int value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.muted,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.bodyMedium),
          Text(
            'Rp ${ToCurrency(value.toString())}',
            style: context.headingSmall.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildKembalianInfo(BuildContext context, String label, int value) {
    final isNegative = value < 0;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNegative
            ? context.destructive.withValues(alpha: 0.1)
            : context.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isNegative ? context.destructive : context.success,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.bodyMedium),
          Text(
            'Rp ${ToCurrency(value.toString())}',
            style: context.headingSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: isNegative ? context.destructive : context.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required GlobalKey<ShakeWidgetState> shakeKey,
    required String errorText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.bodyMedium.withWeight(FontWeight.w500)),
        const Gap(6),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(
              color: errorText.isEmpty ? context.border : context.destructive,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: context.foreground),
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: hint,
                    border: InputBorder.none,
                    suffixIcon: controller.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              _updateController(controller, "");
                            },
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: context.foreground,
                            ),
                          )
                        : null,
                  ),
                  onChanged: (val) {
                    if (onChanged != null) {
                      onChanged(val);
                    } else {
                      setState(() {});
                    }
                  },
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _processPayment(),
                ),
              ),
            ],
          ),
        ).withShake(key: shakeKey),
        if (errorText.isNotEmpty) ...[
          const Gap(4),
          Text(
            errorText,
            style: context.captionRegular.withColor(context.destructive),
          ),
        ],
      ],
    );
  }
}
