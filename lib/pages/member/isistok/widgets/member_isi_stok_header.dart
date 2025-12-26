import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberIsiStokHeader extends StatelessWidget {
  const MemberIsiStokHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      color: context.primary,
      child: Stack(
        children: [
          Positioned.fill(
            child: RhombusPattern(
              color: Colors.black.withValues(alpha: 0.05),
              radius: 4,
              spacing: 30,
              isStaggered: false,
            ),
          ),
          Positioned.fill(
            child: Column(children: [_buildAppBar(context), _buildInfoStok(context)]),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: () => pop(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(LucideIcons.chevronLeft, size: 22, color: Colors.white),
            const Gap(5),
            Text(
              "Isi Stok",
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

  Widget _buildInfoStok(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Stok",
                          style: context.bodyLarge.withColor(Colors.white),
                        ),
                        const Gap(5),
                        InkWell(
                          onTap: () {
                            getMemberProvider(context).getProfile();
                          },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(1000),
                          ),
                          child: const Icon(
                            LucideIcons.rotateCcw,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<MemberProvider, MemberState>(
                      builder: (context, state) {
                        if (state.apiGetMemberStatus.isLoading) {
                          return SizedBox(
                            width: 150,
                            height: 30,
                            child: Shimmer.fromColors(
                              baseColor: context.muted,
                              highlightColor: context.muted.withValues(alpha: 0.5),
                              child: Container(
                                height: 32,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: context.muted,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "Rp ",
                                style: context.bodyLarge
                                    .withColor(Colors.white)
                                    .withWeight(FontWeight.w400),
                              ),
                            ),
                            Text(
                              ToCurrency(state.profile.saldo.toString()),
                              style: context.displayLarge
                                  .withColor(Colors.white)
                                  .withWeight(FontWeight.w600),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: "Riwayat Isi Stok",
                onPressed: () {},
                icon: MdiIcons.receiptTextClockOutline,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 30,
                variant: ButtonVariant.secondary,
              ),
            ],
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: Colors.white70, size: 24),
                const Gap(5),
                Expanded(
                  child: Text(
                    "Stok ini adalah kredit internal aplikasi untuk pembelian produk digital yang tersedia. Tidak dapat diuangkan kembali.",
                    style: context.bodySmall
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
