import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberSaldoCard extends StatelessWidget {
  final bool isSaldoVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onRefresh;
  final VoidCallback onIsiSaldo;

  const MemberSaldoCard({
    super.key,
    required this.isSaldoVisible,
    required this.onToggleVisibility,
    required this.onRefresh,
    required this.onIsiSaldo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberProvider, MemberState>(
      builder: (context, state) {
        final profile = state.profile;

        return Card(
          child: Padding(
            padding: paddingCard,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _SaldoIcon(),
                  const Gap(12),
                  Expanded(
                    child: _SaldoInfo(
                      isLoading: state.apiGetMemberStatus.isLoading,
                      formatSaldo: profile.formatSaldo,
                      isSaldoVisible: isSaldoVisible,
                      onToggleVisibility: onToggleVisibility,
                      onRefresh: onRefresh,
                    ),
                  ),
                  const Gap(6),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: context.primary,
                  ),
                  const Gap(12),
                  _IsiSaldoButton(onTap: onIsiSaldo),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SaldoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Assets.img.beranda.imgIsiSaldo.image(height: 28, width: 28),
    );
  }
}

class _SaldoInfo extends StatelessWidget {
  final bool isLoading;
  final String formatSaldo;
  final bool isSaldoVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onRefresh;

  const _SaldoInfo({
    required this.isLoading,
    required this.formatSaldo,
    required this.isSaldoVisible,
    required this.onToggleVisibility,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_buildTitle(context), _buildSaldoRow(context)],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          "Stok Anda",
          style: context.bodyMedium.withWeight(FontWeight.w600),
        ),
        const Gap(8),
        GestureDetector(
          onTap: onRefresh,
          child: Icon(LucideIcons.rotateCcw, size: 14, color: context.primary),
        ),
      ],
    );
  }

  Widget _buildSaldoRow(BuildContext context) {
    return Row(
      children: [
        if (isLoading) _buildShimmer(context) else _buildSaldoText(context),
        const Gap(4),
        _buildVisibilityToggle(context),
      ],
    );
  }

  Widget _buildShimmer(BuildContext context) {
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

  Widget _buildSaldoText(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: Text(
        isSaldoVisible ? formatSaldo : "Rp ••••••••",
        key: ValueKey(isSaldoVisible),
        style: context.bodyLarge
            .withColor(context.primary)
            .withWeight(FontWeight.w700),
      ),
    );
  }

  Widget _buildVisibilityToggle(BuildContext context) {
    return GestureDetector(
      onTap: onToggleVisibility,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          isSaldoVisible ? LucideIcons.eye : LucideIcons.eyeOff,
          size: 18,
          color: context.mutedForeground,
        ),
      ),
    );
  }
}

class _IsiSaldoButton extends StatelessWidget {
  final VoidCallback onTap;

  const _IsiSaldoButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Assets.img.profile.icIsiSaldo.image(
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
          ),
          const Gap(4),
          Text(
            "Isi Saldo",
            style: context.captionMedium
                .withColor(context.primary)
                .withWeight(FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
