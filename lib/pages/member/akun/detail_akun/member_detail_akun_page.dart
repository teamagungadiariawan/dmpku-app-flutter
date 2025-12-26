import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberDetailAkunPage extends StatefulWidget {
  static const routeName = '/member/akun/detail';

  const MemberDetailAkunPage({super.key});

  @override
  State<MemberDetailAkunPage> createState() => _MemberDetailAkunPageState();
}

class _MemberDetailAkunPageState extends State<MemberDetailAkunPage> {
  // --- Actions ---
  void closePage() {
    pop();
  }

  // --- Helpers ---
  String _maskNik(String nik) {
    if (nik != "-" && nik.length > 8) {
      return nik.replaceRange(4, nik.length - 4, '*' * (nik.length - 8));
    }
    return nik;
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Email berhasil disalin',
          style: context.bodyMedium.withColor(Colors.white),
        ),
        backgroundColor: context.mutedForeground,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: true,
        child: Scaffold(
          body: Stack(
            children: [
              _buildHeaderSection(context),
              _buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Header Section ---

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: 270,
      color: context.primary,
      child: Stack(
        children: [
          Positioned.fill(
            child: RhombusPattern(
              color: Colors.black.withOpacity(0.05),
              radius: 4,
              spacing: 30,
              isStaggered: false,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [_buildAppBar(), _buildAkunInfoCard(context)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: closePage,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(LucideIcons.chevronLeft, size: 22, color: Colors.white),
            const Gap(5),
            Text(
              "Detail Akun",
              style: context.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildAkunInfoCard(BuildContext context) {
    return BlocBuilder<MemberProvider, MemberState>(
      buildWhen: (prev, curr) =>
          prev.apiGetMemberDetailStatus != curr.apiGetMemberDetailStatus ||
          prev.profileDetail != curr.profileDetail ||
          prev.profile != curr.profile,
      builder: (context, state) {
        if (state.apiGetMemberDetailStatus.isLoading) {
          return _buildAkunInfoCardShimmer();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Assets.img.profile.icDmpku.image(
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(10),
            Text(
              state.profile.namamember,
              style: context.sectionTitle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(4),
            InkWell(
              onTap: () => _copyToClipboard(context, state.profileDetail.email),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.profileDetail.email,
                      style: context.bodyMedium
                          .withColor(Colors.white)
                          .withWeight(FontWeight.w600),
                    ),
                    const Gap(6),
                    const Icon(
                      MdiIcons.contentCopy,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAkunInfoCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Profile Picture Placeholder (Circle)
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ), // Opsional, biar width-nya presisi
            ),
          ),
          const Gap(10),

          // 2. Name Placeholder (Text Line)
          Container(
            width: 120, // Estimasi lebar nama rata-rata
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8), // Gap antara nama dan email
          // 3. Email Pill Placeholder (Rounded Container)
          Container(
            width: 180, // Estimasi lebar email + icon
            height: 36, // Tinggi approx padding vertikal 8 + text
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                24,
              ), // Match border radius asli
            ),
          ),
        ],
      ),
    );
  }

  // --- Main Content Section ---

  Widget _buildMainContent(BuildContext context) {
    return BlocBuilder<MemberProvider, MemberState>(
      buildWhen: (previous, current) {
        return previous.apiGetMemberDetailStatus !=
                current.apiGetMemberDetailStatus ||
            previous.profileDetail != current.profileDetail ||
            previous.profile != current.profile;
      },
      builder: (context, state) {
        if (state.apiGetMemberDetailStatus.isLoading) {
          return _buildShimmerLoading(context);
        }

        final obfuscatedNIK = _maskNik(state.profileDetail.noktp);

        return Column(
          children: [
            const SizedBox(height: 240),
            _buildVerifiedCard(context),
            Expanded(
              child: ListView(
                padding: paddingPage.copyWith(top: 18),
                children: [
                  Text(
                    "Informasi Akun",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  const Gap(5),

                  // Nama Pemilik
                  _buildInfoCard(
                    context,
                    icon: MdiIcons.account,
                    label: "Nama Pemilik",
                    value: state.profileDetail.pemilik,
                    iconColor: context.primary,
                  ),

                  // Row: NIK & ID Agen
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: MdiIcons.cardAccountDetails,
                          label: "NO. KTP",
                          value: obfuscatedNIK,
                          iconColor: context.success,
                        ),
                      ),
                      const Gap(5),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: MdiIcons.account,
                          label: "ID Agen",
                          value: state.profile.kodemember,
                          iconColor: context.primary,
                        ),
                      ),
                    ],
                  ),

                  // Alamat
                  _buildInfoCard(
                    context,
                    icon: MdiIcons.mapMarker,
                    label: "Alamat Lengkap",
                    value: state.profileDetail.alamat,
                    iconColor: context.primary,
                    isAddress: true,
                  ),

                  const Gap(15),
                  Text(
                    "Keamanan",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  const Gap(5),
                  _buildKeamananCard(context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVerifiedCard(BuildContext context) {
    return BlocBuilder<MemberProvider, MemberState>(
      buildWhen: (prev, curr) =>
          prev.apiGetMemberDetailStatus != curr.apiGetMemberDetailStatus ||
          prev.profileDetail != curr.profileDetail ||
          prev.profile != curr.profile,
      builder: (context, state) {
        final isVerified = state.profile.isVerified;
        final statusColor = isVerified ? context.success : context.destructive;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: paddinPageh),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? stone[700] : stone[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isVerified ? LucideIcons.checkCircle2 : LucideIcons.xCircle,
                    size: 16,
                    color: statusColor,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status Akun",
                        style: context.captionMedium
                            .withColor(context.foreground)
                            .withWeight(FontWeight.w400),
                      ),
                      Text(
                        'Akun ${isVerified ? 'Terverifikasi' : 'Belum Verifikasi'}',
                        style: context.bodyMedium
                            .copyWith(fontWeight: FontWeight.w600)
                            .withColor(statusColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Components ---

  /// Helper untuk item di dalam card keamanan
  Widget _buildSecurityItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.bodyMedium
                    .withWeight(FontWeight.w600)
                    .withColor(context.foreground),
              ),
              const Gap(4),
              Text(
                description,
                style: context.bodySmall
                    .withWeight(FontWeight.w400)
                    .withColor(context.foreground),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeamananCard(BuildContext context) {
    return Card(
      color: context.isDarkMode ? slate[800] : slate[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: context.isDarkMode ? slate[700]! : slate[300]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSecurityItem(
              context,
              icon: MdiIcons.lock,
              iconColor: context.destructive,
              title: "Jaga Kerahasiaan OTP",
              description:
                  "Jangan pernah memberikan kode OTP atau kode rahasia lainnya kepada siapapun, termasuk pihak yang mengaku dari $appname.",
            ),
            const Gap(12),
            const Divider(height: 1),
            const Gap(12),
            _buildSecurityItem(
              context,
              icon: MdiIcons.alertOutline,
              iconColor: context.warning,
              title: "Waspada Penipuan Chat",
              description:
                  "Khusus pengguna WhatsApp & Telegram, harap ekstra hati-hati terhadap modus penipuan CS palsu yang mengaku dari pihak $appname.",
            ),
            const Gap(12),
            const Divider(height: 1),
            const Gap(12),
            _buildSecurityItem(
              context,
              icon: MdiIcons.shieldAccount,
              iconColor: context.primary,
              title: "Nomor Aktif",
              description:
                  "Hanya gunakan nomor yang aktif pada perangkat Anda untuk menghindari penyalahgunaan.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool isAddress = false,
  }) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.bodySmall
                        .withColor(context.foreground)
                        .withWeight(FontWeight.w400),
                  ),
                  Text(
                    value,
                    style: isAddress
                        ? context.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                        : context.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    // Base color buat skeleton, sesuaikan sama dark/light mode
    final baseColor = context.isDarkMode
        ? Colors.grey[800]!
        : Colors.grey[300]!;
    final highlightColor = context.isDarkMode
        ? Colors.grey[700]!
        : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        children: [
          // Space buat header profile (tetap dijaga tingginya)
          const SizedBox(height: 240),

          // Shimmer Verified Card
          _buildVerifiedCardShimmer(context),

          Expanded(
            child: ListView(
              padding: paddingPage.copyWith(top: 18),
              children: [
                // Title: Informasi Akun
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const Gap(5),

                // Shimmer: Nama Pemilik
                _buildInfoCardShimmer(context),

                // Shimmer: Row NIK & ID Agen
                Row(
                  children: [
                    Expanded(child: _buildInfoCardShimmer(context)),
                    const Gap(5),
                    Expanded(child: _buildInfoCardShimmer(context)),
                  ],
                ),

                // Shimmer: Alamat
                _buildInfoCardShimmer(context, isAddress: true),

                const Gap(15),

                // Title: Keamanan
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 80,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const Gap(5),

                // Shimmer: Keamanan Card (Static info juga di-shimmer biar rapi)
                _buildKeamananCardShimmer(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Components Shimmer ---

  Widget _buildVerifiedCardShimmer(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: paddinPageh),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Circle Icon Placeholder
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label Placeholder
                  Container(width: 80, height: 10, color: Colors.white),
                  const Gap(6),
                  // Value Placeholder
                  Container(width: 150, height: 14, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCardShimmer(BuildContext context, {bool isAddress = false}) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Box Placeholder
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label Placeholder
                  Container(width: 60, height: 10, color: Colors.white),
                  const Gap(6),
                  // Value Placeholder
                  Container(
                    width: isAddress ? double.infinity : 100,
                    height: 14,
                    color: Colors.white,
                  ),
                  if (isAddress) ...[
                    const Gap(4),
                    Container(width: 150, height: 14, color: Colors.white),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeamananCardShimmer(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(3, (index) {
            return Column(
              children: [
                if (index > 0) ...[
                  const Gap(12),
                  const Divider(height: 1),
                  // Divider tetap dirender biar struktur sama
                  const Gap(12),
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 18, height: 18, color: Colors.white),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 14,
                            color: Colors.white,
                          ),
                          const Gap(6),
                          Container(
                            width: double.infinity,
                            height: 10,
                            color: Colors.white,
                          ),
                          const Gap(4),
                          Container(
                            width: 200,
                            height: 10,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
