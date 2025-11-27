import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/service/informasi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final InformasiService _informasiService = InformasiService();

  @override
  void initState()  {
    super.initState();


    gotoGuestDashboard();
  }

  void gotoGuestDashboard() async {
    await _informasiService.getInformasi();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    pushReplacementNamed(MainPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: context.primary,
      body: Stack(
        children: [
          Positioned.fill(child: Assets.img.bgSplash.image(fit: BoxFit.cover)),
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
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        Gap(8),
                        Text(
                          'PT. DUNIA MASTER PULSA',
                          style: context.bodyMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Gap(2),
                        Text(
                          '${packageInfo.version}',
                          style: context.bodyMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Gap(2),
                        Text(
                          "Produk INDONESIA",
                          style: context.bodyMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Gap(15),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
