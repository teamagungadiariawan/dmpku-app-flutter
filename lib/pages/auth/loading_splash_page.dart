import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoadingSplashPage extends StatelessWidget {
  const LoadingSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: context.primary,
        body: Stack(
          children: [
            Positioned.fill(
              child: Assets.img.bgSplash.image(fit: BoxFit.cover),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    } else if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    } else {
                      final packageInfo = snapshot.data!;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            'PT. DUNIA MASTER PULSA',
                            style: context.bodyMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            packageInfo.version,
                            style: context.bodyMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            "Produk INDONESIA",
                            style: context.bodyMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(15),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
