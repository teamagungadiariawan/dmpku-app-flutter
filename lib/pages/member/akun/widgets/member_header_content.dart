import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MemberHeaderContent extends StatelessWidget {
  final double headerHeight;
  final VoidCallback onRefresh;

  const MemberHeaderContent({
    super.key,
    required this.headerHeight,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberProvider, MemberState>(
      builder: (context, state) {
        final profile = state.profile;

        return SizedBox(
          height: headerHeight,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddinPageh + 12,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(10),
                  Row(
                    children: [
                      _buildAvatar(),
                      Gap(10),
                      Expanded(
                        child: _buildWelcomeText(context, profile.namamember),
                      ),
                      const Gap(10),
                      CustomButton(
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        borderRadius: BorderRadius.circular(999),
                        variant: ButtonVariant.secondary,
                        text: 'Bantuan',
                        foregroundColor: context.primary,
                        icon: LucideIcons.messageCircleQuestionMark600,
                        onPressed:  () {},
                      ),

                    ],
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      _buildAgentIdBadge(
                        context,
                        kodemember: profile.kodemember,
                      ),
                      Spacer(),
                      _buildVerificationBadge(
                        context,
                        isVerified: profile.isVerified,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar({double size = 45, double borderWidth = 1}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: borderWidth),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Assets.img.profile.icDmpku.image(
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAgentIdBadge(
    BuildContext context, {
    required String kodemember,
  }) {
    return InkWell(
      onTap: () => _copyToClipboard(context, kodemember),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.hash, color: Colors.white, size: 12),
            const Gap(4),
            Text(
              "ID Agen: $kodemember",
              style: context.captionMedium
                  .withColor(Colors.white)
                  .withWeight(FontWeight.w600),
            ),
            const Gap(6),
            const Icon(LucideIcons.copy, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationBadge(
    BuildContext context, {
    bool isVerified = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
        color: isVerified ? context.success : context.destructive,
      ),
      child: Text(
       "Akun " + (isVerified ? 'Terverifikasi' : 'Belum Verifikasi'),
        style: context.captionMedium.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selamat Datang,",
          style: context.bodyMedium
              .withColor(Colors.white)
              .withWeight(FontWeight.w800),
        ),
        Text(
          name,
          style: context.pageTitle.withColor(Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ID Agen berhasil disalin',
          style: context.bodyMedium.withColor(Colors.white),
        ),
        backgroundColor: context.mutedForeground,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
