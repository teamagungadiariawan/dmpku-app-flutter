import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_page.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/nobu/progress_nobu_page.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/beranda/sales_feature_card.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class DashboardHeader extends StatefulWidget {
  final List<MenuData> salesMenus;
  final VoidCallback onPromoTap;
  final ValueChanged<String> onMenuTap;

  static const double _headerHeight = 260.0;
  static const double _cardOverlapHeight = 75.0;
  static const double _cardTopOffset = kToolbarHeight + 35.0;

  const DashboardHeader({
    super.key,
    required this.salesMenus,
    required this.onPromoTap,
    required this.onMenuTap,
  });

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  bool _isSaldoVisible = true;

  void _toggleSaldoVisibility() {
    setState(() => _isSaldoVisible = !_isSaldoVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [_buildHeaderBackground(), _buildBalanceCard()],
    );
  }

  Widget _buildHeaderBackground() {
    return Column(
      children: [
        Container(
          height: DashboardHeader._headerHeight,
          decoration: BoxDecoration(
            color: context.primary,
            image: DecorationImage(
              image: Assets.img.bgPattern.provider(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: DashboardHeader._cardOverlapHeight),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Positioned(
      top: DashboardHeader._cardTopOffset,
      left: 12,
      right: 12,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: paddingCard,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildStokMenuItem()),
                    const Gap(8),
                    VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: context.border,
                    ),
                    const Gap(8),
                    Expanded(child: _buildQrisMenuItem()),
                  ],
                ),
              ),
            ),
          ),
          SalesFeatureCard(
            menus: widget.salesMenus,
            onMenuTap: (title) => widget.onMenuTap.call(title),
          ),
        ],
      ),
    );
  }

  Widget _buildStokMenuItem() {
    return BlocBuilder<MemberProvider, MemberState>(
      buildWhen: (prev, curr) =>
          prev.apiGetMemberStatus != curr.apiGetMemberStatus,
      builder: (context, state) {
        final isLoading = state.apiGetMemberStatus.isLoading;

        return _buildHeaderMenuItem(
          icon: Assets.img.beranda.imgIsiSaldo.image(height: 14, width: 14),
          iconBgColor: context.primary.withOpacity(0.28),
          title: 'Stok Anda',
          subtitle: _buildSaldoDisplay(
            saldo: state.profile.formatSaldo,
            isLoading: isLoading,
            isVisible: _isSaldoVisible,
          ),
          trailing: _buildVisibilityToggle(
            isVisible: _isSaldoVisible,
            onToggle: _toggleSaldoVisibility,
          ),
          buttonText: 'Isi Stok',
          buttonIcon: MdiIcons.walletPlusOutline,
          onRefresh: () {
            getMemberProvider(context).getProfile();
            getMemberIsiStokProvider(context).fetchRiwayatTiketBankTransfer();
          },
          onButtonPressed: () {
            pushNamed(MemberIsiStokPage.routeName);
          },
        );
      },
    );
  }

  Widget _buildQrisMenuItem() {
    return _buildHeaderMenuItem(
      icon: Assets.img.beranda.imgNobu.image(height: 14, width: 14),
      iconBgColor: context.destructive.withOpacity(0.28),
      title: 'Qris By Nobu',
      subtitle: Text(
        'Transaksi lebih mudah',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.bodySmall
            .withColor(context.primary)
            .withWeight(FontWeight.w600),
      ),
      buttonText: 'Scan Qris',
      buttonIcon: MdiIcons.qrcodeScan,
      onButtonPressed: () {
        pushNamed(ProgressNobuPage.routeName);
      },
    );
  }

  Widget _buildHeaderMenuItem({
    required Widget icon,
    required Color iconBgColor,
    required String title,
    required Widget subtitle,
    Widget? trailing,
    required String buttonText,
    required IconData buttonIcon,
    VoidCallback? onRefresh,
    VoidCallback? onButtonPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              _buildIconBox(icon: icon, backgroundColor: iconBgColor),
              const Gap(12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleRow(title: title, onRefresh: onRefresh),
                    _buildSubtitleRow(subtitle: subtitle, trailing: trailing),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        CustomButton(
          height: 30,
          width: double.infinity,
          padding: EdgeInsets.zero,
          variant: ButtonVariant.border,
          text: buttonText,
          borderColor: Colors.transparent,
          backgroundColor: context.isDarkMode ? neutral[700] : neutral[200],
          foregroundColor: context.primary,
          textStyle: context.bodyMedium
              .withWeight(FontWeight.w600)
              .withColor(context.primary),
          icon: buttonIcon,
          onPressed: onButtonPressed,
        ),
        const Gap(2),
      ],
    );
  }

  Widget _buildSubtitleRow({required Widget subtitle, Widget? trailing}) {
    if (trailing == null) {
      return Align(alignment: Alignment.centerLeft, child: subtitle);
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [subtitle, const Spacer(), trailing!],
    );
  }

  Widget _buildSaldoDisplay({
    required String saldo,
    required bool isLoading,
    required bool isVisible,
  }) {
    if (isLoading) {
      return _buildSaldoShimmer();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: Text(
        isVisible ? saldo : 'Rp ••••••••',
        key: ValueKey(isVisible),
        style: context.bodyLarge
            .withColor(context.primary)
            .withWeight(FontWeight.w600),
      ),
    );
  }

  Widget _buildSaldoShimmer() {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode ? neutral[700]! : neutral[300]!,
      highlightColor: context.isDarkMode ? neutral[600]! : neutral[100]!,
      child: Container(
        height: 20,
        width: 80,
        decoration: BoxDecoration(
          color: neutral[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildVisibilityToggle({
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return GestureDetector(
      onTap: onToggle,
      child: Icon(
        isVisible ? LucideIcons.eye : LucideIcons.eyeOff,
        size: 15,
        color: context.mutedForeground,
      ),
    );
  }

  Widget _buildIconBox({required Widget icon, required Color backgroundColor}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: icon,
    );
  }

  Widget _buildTitleRow({required String title, VoidCallback? onRefresh}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            title,
            style: context.bodyMedium.withWeight(FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onRefresh != null) ...[
          const Gap(8),
          _buildRefreshButton(onTap: onRefresh),
        ],
      ],
    );
  }

  Widget _buildRefreshButton({required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Icon(LucideIcons.rotateCcw, size: 12, color: context.primary),
    );
  }
}
