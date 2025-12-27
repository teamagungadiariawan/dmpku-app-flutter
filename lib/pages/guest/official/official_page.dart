import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/launch_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

// ============================================================================
// Model
// ============================================================================

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ============================================================================
// Main Page
// ============================================================================

class OfficialPage extends StatefulWidget {
  const OfficialPage({super.key});

  @override
  State<OfficialPage> createState() => _OfficialPageState();
}

class _OfficialPageState extends State<OfficialPage> {
  // --------------------------------------------------------------------------
  // Data
  // --------------------------------------------------------------------------

  static const List<ServiceItem> _services = [
    ServiceItem(
      icon: MdiIcons.faceAgent,
      title: 'Pelayanan Customer Service Handal',
      description: 'Kami siap melayani pertanyaan anda selama 24 Jam',
    ),
    ServiceItem(
      icon: MdiIcons.shieldCheck,
      title: 'Jaminan Keamanan Transaksi',
      description:
          'Keamanan sistem adalah prioritas kami demi menjaga kenyamanan mitra',
    ),
    ServiceItem(
      icon: MdiIcons.cashMultiple,
      title: 'Penawaran harga dan fee terbaik',
      description:
          'Harga dari kami relatif murah dan dapatkan keuntungan maksimal bermitra dengan kami',
    ),
    ServiceItem(
      icon: MdiIcons.swapHorizontal,
      title: 'Kemudahan Integrasi Sistem',
      description: 'Proses integrasi yang mudah dan cepat.',
    ),
    ServiceItem(
      icon: MdiIcons.clock,
      title: 'Penanganan H+0 Untuk masalah',
      description:
          'Kami usahakan setiap transaksi yang bermasalah selesai dalam hari itu juga',
    ),
    ServiceItem(
      icon: MdiIcons.packageVariantClosed,
      title: 'Produk-produk Berkualitas',
      description:
          'Kami pastikan layanan dan barang dengan kualitas terbaik untuk para mitra.',
    ),
  ];

  // --------------------------------------------------------------------------
  // Actions
  // --------------------------------------------------------------------------



  Future<void> _openWhatsAppChannel() async {
    final link = await SecureStorageHelper.instance.getChannelWa();
    await launchUrlApp(link);
  }

  Future<void> _openWhatsAppCS() async {
    final link = await SecureStorageHelper.instance.getWacs();
    await launchUrlApp(link);
  }

  Future<void> _callCS() async {
    final phone = await SecureStorageHelper.instance.getCallCenter();
    if (phone == null || phone.isEmpty) return;

    final canCall = await canLaunchUrl(Uri(scheme: 'tel', path: '123'));
    if (!canCall) {
      showWarningMessage(
        "Perangkat Anda tidak mendukung fitur panggilan telepon.",
      );
      return;
    }

    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  // --------------------------------------------------------------------------
  // Build
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Official Page",
          onBackButtonPressed: () {},
          showBackButton: false,
        ),
        body: ListView(
          padding: paddingPage,
          children: [
            _buildHeaderBanner(),
            const Gap(8),
            _buildWhatsAppCard(),
            const Gap(8),
            _buildContactButtons(),
            const Gap(8),
            _buildAboutSection(),
            const Gap(8),
            _buildLegalitySection(),
            const Gap(8),
            _buildServicesGrid(),
            const Gap(20),
            _buildFooter(),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Header Banner
  // --------------------------------------------------------------------------

  Widget _buildHeaderBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.primary),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          _DecorativeCircle(top: -12, left: -12, size: 80, opacity: 0.2),
          _DecorativeCircle(bottom: -12, left: -12, size: 80, opacity: 0.3),
          _DecorativeCircle(bottom: -40, left: -4, size: 110, opacity: 0.2),
          Row(
            children: [
              Assets.img.official.bannerOfficial.image(width: 100),
              const Gap(10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.img.logoText.image(width: 120),
                      Text("PT.Dunia Master Pulsa", style: context.bodyMedium),
                      Text(
                        "${appname.toUpperCase()} membangun layanan digital untuk semua orang",
                        style: context.captionMedium
                            .withColor(context.foreground)
                            .withWeight(FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // WhatsApp Card
  // --------------------------------------------------------------------------

  Widget _buildWhatsAppCard() {
    return Container(
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: -12,
            left: -12,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(MdiIcons.whatsapp, size: 50, color: Colors.white),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Follow Kami di WhatsApp",
                          style: context.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          "Dapatkan informasi terbaru dan promo menarik dari $appname melalui Whatsapp",
                          style: context.captionMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: "Ikuti Kami",
                  onPressed: _openWhatsAppChannel,
                  variant: ButtonVariant.border,
                  backgroundColor: Colors.white,
                  foregroundColor: context.primary,
                  borderColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Contact Buttons
  // --------------------------------------------------------------------------

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            height: 30,
            icon: MdiIcons.whatsapp,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.border,
            borderColor: context.primary,
            foregroundColor: context.primary,
            text: "CS WhatsApp",
            onPressed: _openWhatsAppCS,
          ),
        ),
        const Gap(10),
        Expanded(
          child: CustomButton(
            height: 30,
            icon: MdiIcons.phone,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.border,
            borderColor: context.primary,
            foregroundColor: context.primary,
            text: "CS Call Center",
            onPressed: _callCS,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // About Section
  // --------------------------------------------------------------------------

  Widget _buildAboutSection() {
    return Text(
      'PT Dunia Master Pulsa (merek dagang $appname) adalah perusahaan distribusi produk digital. '
      'Perjalanan kami dimulai dari bisnis distribusi pulsa pada 2014 dan berlanjut dengan pendirian badan '
      'usaha pada Desember 2019. Kami berkomitmen menghadirkan penjualan produk digital yang mudah diakses, cepat diproses, dan terjangkau, '
      'sehingga dapat mendukung kegiatan ekonomi dan membuka peluang usaha bagi masyarakat luas.',
      style: context.bodyMedium,
    );
  }

  // --------------------------------------------------------------------------
  // Legality Section
  // --------------------------------------------------------------------------

  Widget _buildLegalitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "LEGALITAS PERUSAHAAN",
          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(5),
        _LegalityCard(
          image: Assets.img.official.logoKemenkumham.provider(),
          title: "Keputusan Kemenkumham",
          subtitle: "Nomor AHU-0005426.AH.01.01.TAHUN2020",
        ),
        const Gap(5),
        _LegalityCard(
          image: Assets.img.official.logoNib.provider(),
          title: "Nomor Induk Berusaha",
          subtitle: "Nomor 0220008112698",
        ),
        const Gap(5),
        _LegalityCard(
          image: Assets.img.official.logoDjp.provider(),
          title: "Pengukuhan Perusahaan Kena Pajak",
          subtitle: "Nomor S-126PKP/WPJ/12/KP.1403/2020",
        ),
        const Gap(5),
        _LegalityCard(
          image: Assets.img.official.logoKomdigi.provider(),
          title: "Kami Terdaftar di KOMDIGI",
          subtitle: "DUNIA MASTER PULSA terdaftar di PSE KOMDIGI",
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Services Grid
  // --------------------------------------------------------------------------

  Widget _buildServicesGrid() {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 70,
          child: Container(
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemCount: _services.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              _ServiceCard(service: _services[index]),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Footer
  // --------------------------------------------------------------------------

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          "PT. Dunia Master Pulsa",
          style: context.bodySmall.withWeight(FontWeight.w800),
        ),
        Text(
          "Jl. Raya Mulyorejo Atrani Square No. 19 Sukun, Kota Malang",
          style: context.bodySmall,
        ),
        Text(
          "www.duniamasterpulsa.com",
          style: context.bodySmall.withColor(context.primary),
        ),
      ],
    );
  }
}

// ============================================================================
// Reusable Widgets
// ============================================================================

class _DecorativeCircle extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  final double opacity;

  const _DecorativeCircle({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: context.primary.withValues(alpha: opacity),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _LegalityCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String subtitle;

  const _LegalityCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingCard,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.primary),
      ),
      child: Row(
        children: [
          Image(image: image, width: 28, height: 28, fit: BoxFit.contain),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(subtitle, style: context.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Column(
          children: [
            const Gap(5),
            Icon(service.icon, color: context.primary, size: 32),
            const Gap(8),
            Text(
              service.title,
              style: context.bodySmall.withWeight(FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            Text(
              service.description,
              style: context.captionMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
