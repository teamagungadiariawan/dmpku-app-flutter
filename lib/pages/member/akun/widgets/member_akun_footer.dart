import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MemberAkunFooter extends StatelessWidget {
  const MemberAkunFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: context.primary,
                strokeWidth: 2,
              ),
            );
          }

          if (snapshot.hasError) {
            return const SizedBox.shrink();
          }

          final packageInfo = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(8),
              Text('PT. DUNIA MASTER PULSA', style: context.bodyMedium),
              const Gap(2),
              Text(
                "Versi ${packageInfo.version}",
                style: context.bodyMedium,
              ),
            ],
          );
        },
      ),
    );
  }
}