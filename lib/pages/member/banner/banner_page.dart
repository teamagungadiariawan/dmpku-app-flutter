import 'package:dmpku/core/helpers/launch_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';

import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class BannerPage extends StatefulWidget {
  static const routeName = '/banner';
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _namaTokoController = TextEditingController();
  final TextEditingController _alamatTokoController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _selectedUkuran;

  final List<String> _ukuranOptions = [
    'Landscape (200 cm x 100 cm)',
    'Potrait (60 cm x 160 cm)',
    'Persegi (100 cm x 100 cm)',
  ];

  @override
  void dispose() {
    _namaTokoController.dispose();
    _alamatTokoController.dispose();
    _noTelpController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleWa() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedUkuran == null) {
        showErrorMessage('Ukuran Banner belum dipilih');
        return;
      }

      final message =
          'Halo Admin, saya ingin memesan banner dengan detail:\n\n'
          'Nama Toko: ${_namaTokoController.text}\n'
          'Alamat Toko: ${_alamatTokoController.text}\n'
          'No. Telp: ${_noTelpController.text}\n'
          'Email: ${_emailController.text.isNotEmpty ? _emailController.text : "-"}\n'
          'Ukuran: $_selectedUkuran';

      await launchBantuanWaByMessage(text: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Banner'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoSection(),
              const Gap(16),
              Text(
                'Media promosi',
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const Gap(4),
              Text(
                'Banner adalah media promosi dari DMPKU untuk agen maupun pengguna aplikasi DMPKU. Agar pelanggan makin ramai dan semakin dikenal, Memasang Banner cara mudah dan efektif.',
                style: context.bodyMedium,
              ),
              const Gap(16),
              Text(
                'Syarat Mendapatkan Media Promosi ini',
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              _buildRequirementItem(
                '1.',
                'Akun DMPKU anda sudah Terverifikasi',
              ),
              const Gap(4),
              _buildRequirementItem(
                '2.',
                'Masa aktif akun DMPKU harus diatas 30 hari dengan minimal transaksi 30 kali',
              ),
              const Gap(4),
              _buildRequirementItem('3.', 'Wajib melengkapi data toko'),
              const Gap(24),
              _buildTextField(
                controller: _namaTokoController,
                label: 'Nama Toko',
                hint: 'Masukkan Nama Toko Anda',
                icon: MdiIcons.storefrontEditOutline,
              ),
              const Gap(12),
              _buildTextField(
                controller: _alamatTokoController,
                label: 'Alamat Toko',
                hint: 'Masukkan Alamat Toko Anda',
                icon: MdiIcons.mapMarker,
              ),
              const Gap(12),
              _buildTextField(
                controller: _noTelpController,
                label: 'Nomor Telp',
                hint: 'Masukkan Nomor Telp Toko Anda',
                icon: MdiIcons.whatsapp,
                keyboardType: TextInputType.phone,
              ),
              const Gap(12),
              _buildTextField(
                controller: _emailController,
                label: 'Email (opsional)',
                hint: 'Masukkan Email Toko Anda',
                icon: MdiIcons.emailOutline,
                isRequired: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(24),
              Text(
                'Ukuran Banner',
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              DropdownButtonFormField<String>(
                value: _selectedUkuran,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MdiIcons.cardBulleted,
                    color: context.primary,
                  ),
                  filled: true,
                  fillColor: context.muted,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: context.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: context.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                hint: Text('Pilih Ukuran', style: context.bodyMedium),
                items: _ukuranOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: context.bodyMedium),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedUkuran = newValue;
                  });
                },
              ),
              const Gap(24),
              CustomButton(
                text: 'Pesan Melalui Whatsapp',
                onPressed: _handleWa,
                width: double.infinity,
              ),
              const Gap(24),
              Text(
                'Contoh Banner',
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Assets.img.banner.image(
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                MdiIcons.informationOutline,
                color: Colors.white,
                size: 16,
              ),
              const Gap(8),
              Text(
                'Keterangan',
                style: context.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            'DMPKU hanya menyediakan file design saja (tidak dalam bentuk fisik)',
            style: context.bodyMedium.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number, style: context.bodyMedium),
        const Gap(8),
        Expanded(child: Text(text, style: context.bodyMedium)),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap(8),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(color: context.border, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: context.primary),
              const Gap(6),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: (value) {
                    if (isRequired && (value == null || value.isEmpty)) {
                      return '$label tidak boleh kosong';
                    }
                    return null;
                  },
                  style: context.bodyMedium,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: hint,
                    hintStyle: context.hintStyle,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
