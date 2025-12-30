import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
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

class TambahProdukManualDialog extends StatefulWidget {
  final String? initialNama;
  final int? initialHargaModal;
  final int? initialHargaJual;

  const TambahProdukManualDialog({
    super.key,
    this.initialNama,
    this.initialHargaModal,
    this.initialHargaJual,
  });

  static void show(
    BuildContext context, {
    String? initialNama,
    int? initialHargaModal,
    int? initialHargaJual,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<KasirProvider>(),
          child: TambahProdukManualDialog(
            initialNama: initialNama,
            initialHargaModal: initialHargaModal,
            initialHargaJual: initialHargaJual,
          ),
        );
      },
    );
  }

  @override
  State<TambahProdukManualDialog> createState() =>
      _TambahProdukManualDialogState();
}

class _TambahProdukManualDialogState extends State<TambahProdukManualDialog> {
  late TextEditingController _namaController;
  late TextEditingController _hargaModalController;
  late TextEditingController _hargaJualController;

  final shakeKeyNama = GlobalKey<ShakeWidgetState>();
  final shakeKeyHargaModal = GlobalKey<ShakeWidgetState>();
  final shakeKeyHargaJual = GlobalKey<ShakeWidgetState>();

  String errorNama = '';
  String errorHargaModal = '';
  String errorHargaJual = '';

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialNama);
    _hargaModalController = TextEditingController(
      text: widget.initialHargaModal != null
          ? ToCurrency(widget.initialHargaModal.toString())
          : '',
    );
    _hargaJualController = TextEditingController(
      text: widget.initialHargaJual != null
          ? ToCurrency(widget.initialHargaJual.toString())
          : '',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaModalController.dispose();
    _hargaJualController.dispose();
    super.dispose();
  }

  bool validateTambahProduk() {
    bool isValid = true;

    setState(() {
      errorNama = '';
      errorHargaModal = '';
      errorHargaJual = '';

      if (_namaController.text.isEmpty) {
        errorNama = 'Nama produk wajib diisi';
        isValid = false;
      }

      if (_hargaJualController.text.isEmpty) {
        errorHargaJual = 'Harga jual wajib diisi';
        isValid = false;
      }
    });

    if (!isValid) {
      if (errorNama.isNotEmpty) shakeKeyNama.currentState?.shake();
      if (errorHargaJual.isNotEmpty) shakeKeyHargaJual.currentState?.shake();
    }

    return isValid;
  }

  void simpanProduk() {
    if (validateTambahProduk()) {
      final nama = _namaController.text.trim();
      final modal =
          int.tryParse(_hargaModalController.text.replaceAll('.', '')) ?? 0;
      final jual =
          int.tryParse(_hargaJualController.text.replaceAll('.', '')) ?? 0;
      // Default satuan 'trx'
      const satuan = "trx";

      context.read<KasirProvider>().tambahProdukManual(
        namaProduk: nama,
        hargaModal: modal,
        hargaJual: jual,
        satuan: satuan,
      );
    }
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<KasirProvider, KasirState>(
      listenWhen: (prev, curr) =>
          prev.apiTambahProdukStatus != curr.apiTambahProdukStatus,
      listener: (context, state) {
        if (state.apiTambahProdukStatus == ApiStatus.success) {
          pop();
        }
      },
      child: SafeArea(
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
                          child: Icon(MdiIcons.packageVariantPlus, size: 16),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tambah Produk Manual',
                                style: context.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Input data produk manual (Non-Stok).',
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
                  child: Text(
                    "Informasi Produk",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildTextField(
                    controller: _namaController,
                    label: 'Nama Produk',
                    hint: 'Contoh: Jasa Service',
                    icon: MdiIcons.tagTextOutline,
                    shakeKey: shakeKeyNama,
                    errorText: errorNama,
                  ),
                ),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _hargaModalController,
                          label: 'Harga Modal',
                          hint: '0',
                          icon: MdiIcons.cashMultiple,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          shakeKey: shakeKeyHargaModal,
                          errorText: errorHargaModal,
                          onChanged: (val) {
                            _updateController(
                              _hargaModalController,
                              ToCurrency(val),
                            );
                            setState(() {});
                          },
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: _buildTextField(
                          controller: _hargaJualController,
                          label: 'Harga Jual',
                          hint: '0',
                          icon: MdiIcons.cashRegister,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          shakeKey: shakeKeyHargaJual,
                          errorText: errorHargaJual,
                          onChanged: (val) {
                            _updateController(
                              _hargaJualController,
                              ToCurrency(val),
                            );
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                        icon: LucideIcons.arrowRight,
                        isLoading: state.apiTambahProdukStatus.isLoading,
                        text: "Simpan Produk",
                        onPressed: simpanProduk,
                      ),
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
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
                  textInputAction: TextInputAction.next,
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
