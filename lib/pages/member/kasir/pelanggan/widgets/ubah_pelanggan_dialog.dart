import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/pelanggan/member_pelanggan_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UbahPelangganDialog extends StatefulWidget {
  final PelangganModel pelangganModel;

  const UbahPelangganDialog({super.key, required this.pelangganModel});

  static void show(
    BuildContext context, {
    required PelangganModel pelangganModel,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MemberPelangganProvider>(),
          child: UbahPelangganDialog(pelangganModel: pelangganModel),
        );
      },
    );
  }

  @override
  State<UbahPelangganDialog> createState() => _UbahPelangganDialogState();
}

class _UbahPelangganDialogState extends State<UbahPelangganDialog> {
  late TextEditingController _namaController;
  late TextEditingController _noHpController;
  late TextEditingController _alamatController;

  final shakeKeyNama = GlobalKey<ShakeWidgetState>();
  final shakeKeyNoHp = GlobalKey<ShakeWidgetState>();
  final shakeKeyAlamat = GlobalKey<ShakeWidgetState>();

  String errorNama = '';
  String errorNoHp = '';
  String errorAlamat = '';

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(
      text: widget.pelangganModel.namapelanggan,
    );
    _noHpController = TextEditingController(
      text: widget.pelangganModel.nohppelanggan,
    );
    _alamatController = TextEditingController(
      text: widget.pelangganModel.alamatpelanggan,
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _noHpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  bool validateUbahPelanggan() {
    bool isValid = true;

    setState(() {
      errorNama = '';
      errorNoHp = '';
      errorAlamat = '';

      if (_namaController.text.isEmpty) {
        errorNama = 'Nama pelanggan wajib diisi';
        isValid = false;
      }

      if (_noHpController.text.isEmpty) {
        errorNoHp = 'No HP wajib diisi';
        isValid = false;
      }
    });

    if (!isValid) {
      if (errorNama.isNotEmpty) shakeKeyNama.currentState?.shake();
      if (errorNoHp.isNotEmpty) shakeKeyNoHp.currentState?.shake();
    }

    return isValid;
  }

  void simpanPelanggan() {
    if (validateUbahPelanggan()) {
      final nama = _namaController.text.trim();
      final noHp = _noHpController.text.trim();
      final alamat = _alamatController.text.trim();

      context.read<MemberPelangganProvider>().ubahPelanggan(
        context,
        idPelanggan: widget.pelangganModel.idpelanggan,
        namaPelanggan: nama,
        noHp: noHp,
        alamat: alamat,
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

    return BlocListener<MemberPelangganProvider, MemberPelangganState>(
      listenWhen: (prev, curr) =>
          prev.apiUbahPelangganStatus != curr.apiUbahPelangganStatus,
      listener: (context, state) {
        if (state.apiUbahPelangganStatus == ApiStatus.success) {
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
                          child: Icon(MdiIcons.accountEdit, size: 16),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ubah Pelanggan',
                                style: context.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Ubah informasi pelanggan Anda.',
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
                    "Informasi Pelanggan",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildTextField(
                    controller: _namaController,
                    label: 'Nama Pelanggan',
                    hint: 'Contoh: Budi Santoso',
                    icon: LucideIcons.user,
                    shakeKey: shakeKeyNama,
                    errorText: errorNama,
                  ),
                ),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildTextField(
                    controller: _noHpController,
                    label: 'No HP',
                    hint: 'Contoh: 081234567890',
                    icon: LucideIcons.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    shakeKey: shakeKeyNoHp,
                    errorText: errorNoHp,
                  ),
                ),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildTextField(
                    controller: _alamatController,
                    label: 'Alamat (Opsional)',
                    hint: 'Contoh: Jl. Merdeka No. 1',
                    icon: LucideIcons.mapPin,
                    shakeKey: shakeKeyAlamat,
                    errorText: errorAlamat,
                  ),
                ),
                const Gap(20),
                BlocBuilder<MemberPelangganProvider, MemberPelangganState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CustomButton(
                        height: 32,
                        padding: EdgeInsets.zero,
                        width: double.infinity,
                        iconPosition: IconPosition.end,
                        icon: LucideIcons.arrowRight,
                        isLoading: state.apiUbahPelangganStatus.isLoading,
                        text: "Simpan Perubahan",
                        onPressed: simpanPelanggan,
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
                  onChanged: (_) => setState(() {}),
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
