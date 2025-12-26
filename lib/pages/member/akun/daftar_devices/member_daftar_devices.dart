import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/launch_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/device_response.dart';
import 'package:dmpku/pages/member/akun/daftar_devices/widgets/konfirmasi_hapus_device_dialog.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberDaftarDevices extends StatefulWidget {
  static const String routeName = '/member/akun/daftar_devices';

  const MemberDaftarDevices({super.key});

  @override
  State<MemberDaftarDevices> createState() => _MemberDaftarDevicesState();
}

class _MemberDaftarDevicesState extends State<MemberDaftarDevices> {
  void closePage() {
    pop();
  }

  // Method buat refresh data
  Future<void> _handleRefresh() async {
    getMemberProvider(context).getProfileDevice();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          closePage();
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Daftar Device",
            onBackButtonPressed: () {
              closePage();
            },
          ),
          // Tambahin RefreshIndicator di sini
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: context.primary, // Warna loading spinner
            backgroundColor: context.background,
            child: Padding(
              padding: paddingPage,
              child: ListView(
                // PENTING: Pake AlwaysScrollable biar bisa ditarik walau item dikit
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  _buildHeaderCard(context),
                  const Gap(10),

                  // --- SECTION NOMOR TERDAFTAR ---
                  Text(
                    "Nomor Terdaftar",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  const Gap(5),
                  Card(
                    child: Padding(
                      padding: paddingCard,
                      child: BlocBuilder<MemberProvider, MemberState>(
                        buildWhen: (previous, current) =>
                            previous.profileDeviceNumber !=
                                current.profileDeviceNumber ||
                            previous.apiGetMemberDeviceStatus !=
                                current.apiGetMemberDeviceStatus,
                        builder: (context, state) {
                          bool isLoading = state.apiGetMemberDeviceStatus
                              .toString()
                              .contains('loading');

                          if (isLoading) {
                            return _buildListShimmer(count: 2, height: 30);
                          }

                          if (state.profileDeviceNumber.isEmpty) {
                            return _buildEmptyState(
                              context,
                              "Tidak ada nomor terdaftar",
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.profileDeviceNumber.length,
                            itemBuilder: (context, index) {
                              final device = state.profileDeviceNumber[index];
                              final isLastItem =
                                  index == state.profileDeviceNumber.length - 1;

                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: !isLastItem
                                        ? BorderSide(color: context.border)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: context.success.withOpacity(
                                            0.3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(
                                          MdiIcons.phone,
                                          size: 15,
                                          color: context.success,
                                        ),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: Text(
                                          device.perangkat,
                                          style: context.bodyMedium.withWeight(
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const Gap(12),
                                      Icon(
                                        Icons.check_circle,
                                        size: 20,
                                        color: context.success,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const Gap(10),

                  // --- SECTION DEVICE TERDAFTAR ---
                  Text(
                    "Device Terdaftar",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  const Gap(5),

                  BlocBuilder<MemberProvider, MemberState>(
                    buildWhen: (previous, current) =>
                        previous.profileDevicePhone !=
                            current.profileDevicePhone ||
                        previous.apiGetMemberDeviceStatus !=
                            current.apiGetMemberDeviceStatus,
                    builder: (context, state) {
                      bool isLoading = state.apiGetMemberDeviceStatus
                          .toString()
                          .contains('loading');

                      if (isLoading) {
                        return _buildDeviceShimmerList();
                      }

                      if (state.profileDevicePhone.isEmpty) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildEmptyState(
                              context,
                              "Belum ada device terdaftar",
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.profileDevicePhone.length,
                        itemBuilder: (context, index) {
                          final device = state.profileDevicePhone[index];
                          return _buildDeviceItem(context, device);
                        },
                      );
                    },
                  ),
                  const Gap(10),

                  // --- SECTION KEAMANAN ---
                  Text(
                    "Keamanan",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  const Gap(5),
                  _buildKeamananCard(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS (Sama kayak sebelumnya, gak berubah) ---

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.img.profile.icManageDevice.image(width: 40, height: 40),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kelola Device Anda",
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                  ),
                  Text(
                    "Lihat dan kelola perangkat yang terhubung ke akun Anda untuk keamanan tambahan.",
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceItem(BuildContext context, DeviceModel device) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: paddingCard,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.img.profile.icManageDevice.image(width: 25, height: 25),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (device.device ?? 'Unknown Device').toUpperCase(),
                        style: context.bodyMedium.withWeight(FontWeight.w600),
                      ),
                      Text(
                        device.version ?? 'Unknown Version',
                        style: context.captionMedium,
                      ),
                      const Gap(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.send500,
                            size: 10,
                            color: context.mutedForeground,
                          ),
                          const Gap(4),
                          Expanded(
                            child: Text(
                              device.alamat ?? 'Lokasi tidak tersedia',
                              style: context.captionMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.calendarClock,
                            size: 10,
                            color: context.mutedForeground,
                          ),
                          const Gap(4),
                          Text(
                            device.formatWaktuDitambah,
                            style: context.captionMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: device.isDmpku
                        ? context.primary.withOpacity(0.3)
                        : context.success.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    device.app ?? "-",
                    style: context.captionMedium.withColor(
                      device.isDmpku ? context.primary : context.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: context.border),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                  ),
                  onTap: () {
                    openMapByQuery(device.loc ?? "-");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: context.border, width: 0.25),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: 12,
                          color: context.primary,
                        ),
                        const Gap(4),
                        Text(
                          "Lihat Lokasi",
                          style: context.bodySmall
                              .withColor(context.primary)
                              .withWeight(FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                  onTap: () {
                    KonfirmasiHapusDeviceDialog.show(context, device: device);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: context.border, width: 0.25),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.trash,
                          size: 12,
                          color: context.destructive,
                        ),
                        const Gap(4),
                        Text(
                          "Hapus Device",
                          style: context.bodySmall
                              .withColor(context.destructive)
                              .withWeight(FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: context.bodyMedium.withColor(context.mutedForeground),
      ),
    );
  }

  // --- SHIMMER WIDGETS ---

  Widget _buildListShimmer({required int count, required double height}) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: context.isDarkMode
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        separatorBuilder: (_, __) => const Gap(10),
        itemBuilder: (_, __) => Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceShimmerList() {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: context.isDarkMode
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, __) => const Gap(10),
        itemBuilder: (_, __) => Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 14,
                            color: Colors.white,
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Container(
                  width: double.infinity,
                  height: 12,
                  color: Colors.white,
                ),
                const Gap(5),
                Container(
                  width: double.infinity,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
